Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ACEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 05:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647DA206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 05:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl/Jr+dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647DA206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeB4t-0007hh-I5
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 01:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jeB48-0006pf-5E
 for qemu-devel@nongnu.org; Thu, 28 May 2020 01:26:52 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:41638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jeB42-0000pT-PE
 for qemu-devel@nongnu.org; Thu, 28 May 2020 01:26:51 -0400
Received: by mail-ej1-x644.google.com with SMTP id x1so30629354ejd.8
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fcxIpnYUGABwai97i+7IBXG9kDPO3b24hoN38SS5u/c=;
 b=nl/Jr+dMLCkZeR3/D2taadJckW/2xw/fiKkDaAo1NdiQORQkwYvoZQd7dlgn2aZ/Kk
 dlqztU1uFsi62PKx/SlOaQTzZkfEYRbca+a2TA+7gejKrx2rx8uFWz3LB6kb/sQPxQcP
 DFqISWZgxKxbjTVtuSjXiGGQrzoXBrOfNIeIFUN5PdNP3dDOyKRG10ZMxvSK7uA3k45a
 j3CNXwrpFWZRrwS9qtwG/67ltm5ydPh7+hzk4JV0VCcyfV/fYO1ozfDlY7KmhFlj7D+T
 tE2sM6Kvz09woCs56/JN1tf4i/JOyoudICJ8G8EkJQlFNXwDRLlJRz7xQ/8Kpwlj0RLR
 im7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fcxIpnYUGABwai97i+7IBXG9kDPO3b24hoN38SS5u/c=;
 b=bBYH/O5afWaYfYmCzyz5lwXXWLdx15/lt6Y0sjLxwdPmzjvRLMYs+Vtgpy1cKoDwGI
 WCMraNqPK1/hJbuxN4RD1Wqbb5DG5vIQNK1YhbF1lyxaEAmR7GLbO2uzVjjL2Q9DA7mu
 ezzhTxEiw4Eo5BOG8PVBw+z5z4tD38XZJN5GzzXLqubk2X33oH3k0gM8iDiglHI1Kjb+
 UG+A5Cd/GYeod7QBQbUJAfFGhzmLGwAup9ovv0Jboa2ciua/jJPZgeHegGvjdWXz4oAN
 pquwMoQ5apc/x8WFGNekirfChcGHxY6N5Tc3CQa+KUWCfBd7gqjtGIYEv9NiFTi9x/+y
 A3CA==
X-Gm-Message-State: AOAM530QOBPnBL7z3FdmzK+FlDQel0fW20QEGG28YedrP4T3pxEin6AT
 QDngXEp5JhPheYnXA98psxA=
X-Google-Smtp-Source: ABdhPJzg+NNYByRnOSdc1R+W6Tlfyk3Q5yHi/3nRKZTwL6tXsIE8NzMHS8/XfDpw+T2i1pnxhLNToA==
X-Received: by 2002:a17:906:bc4c:: with SMTP id
 s12mr1376484ejv.285.1590643604754; 
 Wed, 27 May 2020 22:26:44 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id p7sm3859307edj.81.2020.05.27.22.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 22:26:44 -0700 (PDT)
Date: Thu, 28 May 2020 08:26:42 +0300
From: Jon Doron <arilou@gmail.com>
To: Igor Mammedow <imammedo@redhat.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200528052642.GB3071@jondnuc>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200511182121.GA1307176@rvkaganb.lan>
 <20200513173414.62e3cb4e@redhat.com>
 <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
 <20200522104053.4e7834a8@nas.mammed.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200522104053.4e7834a8@nas.mammed.net>
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x644.google.com
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

On 22/05/2020, Igor Mammedow wrote:
>On Thu, 21 May 2020 18:02:07 +0200
>Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> On 13/05/20 17:34, Igor Mammedov wrote:
>> > I'd rather avoid using random IRQ numbers (considering we are
>> > dealing with black-box here). So if it's really necessary to have
>> > IRQ described here, I'd suggest to implement them in device model
>> > so they would be reserved and QEMU would error out in a sane way if
>> > IRQ conflict is detected.
>>
>> We don't generally detect ISA IRQ conflicts though, do we?
>
>that I don't know that's why I'm not suggesting how to do it.
>The point is hard-coding in AML random IRQs is not right thing to do,
>(especially with the lack of 'any' spec), as minimum AML should pull
>it from device model and that probably should be configurable and set
>by board.
>
>Other thing is:
>I haven't looked at VMBus device model in detail, but DSDT part aren't
>matching device though (device model is not ISA device hence AML part
>shouldn't be on in ISA scope), where to put it is open question.
>There were other issues with AML code, I've commented on, so I was
>waiting on respin with comments addressed.
>I don't think that this patch is good enough for merging.
>
>

But it seems like the current patch does match what's Microsoft HyperV 
is publishing in it's APCI tables.

I dont think it's correct for us to "fix" Microsoft emulation even if 
it's wrong, since that's what Windows probably expects to see...

I tried looking where Microsoft uses the ACPI tables to identify the 
VMBus but without much luck in order to understand how flexible a change 
would be for the OS to still detect the VMBus device, but in general 
I think "correcting" something that is emulated 1:1 because there is no 
spec is the right way.

>>
>> Paolo
>>
>

