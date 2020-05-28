Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 05:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E0D20899
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 05:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9xsOnj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E0D20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeBDu-0004Jq-DF
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 01:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jeBDM-0003uv-EY
 for qemu-devel@nongnu.org; Thu, 28 May 2020 01:36:24 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jeBDK-00075w-TI
 for qemu-devel@nongnu.org; Thu, 28 May 2020 01:36:24 -0400
Received: by mail-ed1-x544.google.com with SMTP id g9so22118077edr.8
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gI7i8qw1Aytmy9+bDIt9QHkJO+SRs2Wop+ZM2Fl92Yk=;
 b=Y9xsOnj24aR0kinBGD8cIht0ID0tUNxKU2LSf8MXjcMpSQ8W8ncGVja404XP8Zo7aI
 tmzO5wwzINm+2spQFLTuypAwO5TD7aWFdBVXxDAgcPwTE7AsIxn1Pm10pY91pk16qjgs
 JC1GdDczrMHJHDc3FhbdE8DQFt26MCblA0+t3bGaUF6I5ShqAQh7cw/dURBMqIXHNbde
 xCsXSc/5XKIHvVcXtquEc0qLKeQ21isb6c+sDQYfXdr6K7idyUFykyl04D6fxJF6InQ8
 K8vU/x61nCZLXo8ZmEKycuaCakKLkXpMwaDpfoJ8DeH93EerFdzPOhwuHA8/hW76TZMl
 ReOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gI7i8qw1Aytmy9+bDIt9QHkJO+SRs2Wop+ZM2Fl92Yk=;
 b=AV3+sTD9in5qO/qINq5DYNxUeRqGOuC7SHULDxxeCKBxO1TL3L6Dd7eoejiQ6oQDGw
 Qzub0fAapj1o8h46nw2RoXnNdT5Yw3CYL43q6GDDuUGmCCq7/83xK1MlVdavgjtNqAH4
 VlQlP56doQr9JA9F/IulSoTAOxwnffMbVxAcAzUYv72UlFixZ0GfaV+V2jgyMw9Bx9P7
 +6mC+ORVPR3PwG2eB6MkcrLd4XqeFdoPH6GB7FR+vtZ/nxWAFJBuTrZ0m0QAX301vkLj
 Trj6Z60EH3vMrR3Xb+YGIPx+RwXQ8M6Rx0Mty5kpXCBll2wZ6KNzIsWHx1YmDlno54fx
 6XYg==
X-Gm-Message-State: AOAM533JHOHOoLS4l1cCet3UcOtjPdE+Cw8JG5+/U85UtF54J1Deazm1
 ETj10k1bwXn2ZK+BBWGDSGw=
X-Google-Smtp-Source: ABdhPJzEe0WtML8Zs7bMYzJnY6/TWKkJ8sMgICaKbcstmJpvkow/aJaxsi1/7TKVQgcHkXQfO5wMPw==
X-Received: by 2002:aa7:d04a:: with SMTP id n10mr1417608edo.175.1590644181365; 
 Wed, 27 May 2020 22:36:21 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id j10sm3802759edn.75.2020.05.27.22.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 22:36:20 -0700 (PDT)
Date: Thu, 28 May 2020 08:36:19 +0300
From: Jon Doron <arilou@gmail.com>
To: Igor Mammedow <imammedo@redhat.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200528053619.GC3071@jondnuc>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200511182121.GA1307176@rvkaganb.lan>
 <20200513173414.62e3cb4e@redhat.com>
 <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
 <20200522104053.4e7834a8@nas.mammed.net>
 <20200528052642.GB3071@jondnuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200528052642.GB3071@jondnuc>
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=arilou@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, Roman Kagan <rvkagan@yandex-team.ru>,
 liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/2020, Jon Doron wrote:
>On 22/05/2020, Igor Mammedow wrote:
>>On Thu, 21 May 2020 18:02:07 +0200
>>Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>>On 13/05/20 17:34, Igor Mammedov wrote:
>>>> I'd rather avoid using random IRQ numbers (considering we are
>>>> dealing with black-box here). So if it's really necessary to have
>>>> IRQ described here, I'd suggest to implement them in device model
>>>> so they would be reserved and QEMU would error out in a sane way if
>>>> IRQ conflict is detected.
>>>
>>>We don't generally detect ISA IRQ conflicts though, do we?
>>
>>that I don't know that's why I'm not suggesting how to do it.
>>The point is hard-coding in AML random IRQs is not right thing to do,
>>(especially with the lack of 'any' spec), as minimum AML should pull
>>it from device model and that probably should be configurable and set
>>by board.
>>
>>Other thing is:
>>I haven't looked at VMBus device model in detail, but DSDT part aren't
>>matching device though (device model is not ISA device hence AML part
>>shouldn't be on in ISA scope), where to put it is open question.
>>There were other issues with AML code, I've commented on, so I was
>>waiting on respin with comments addressed.
>>I don't think that this patch is good enough for merging.
>>
>>
>
>But it seems like the current patch does match what's Microsoft HyperV 
>is publishing in it's APCI tables.
>
>I dont think it's correct for us to "fix" Microsoft emulation even if 
>it's wrong, since that's what Windows probably expects to see...
>
>I tried looking where Microsoft uses the ACPI tables to identify the 
>VMBus but without much luck in order to understand how flexible a 
>change would be for the OS to still detect the VMBus device, but in 
>general I think "correcting" something that is emulated 1:1 because 
>there is no spec is the right way.
>

Bah sorry meant to say:
In general correcting some virtual emulated device which is current is 
matching 1:1 is wrong, I think the right way to handle this type of 
things is to copy them 1:1 and not try to "fix" or "correct" them since 
that's what Windows expects.

>>>
>>>Paolo
>>>
>>

