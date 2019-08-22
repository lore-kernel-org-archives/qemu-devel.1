Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F1CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F5523404
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F5523404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qYA-00041B-Q1
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0qWj-0001ga-BK
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0qWh-0001bY-4B
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0qWg-0001a4-Lr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:05:30 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9306B81F0F
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 17:05:29 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w11so3477889wru.17
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WTzbXG0mkpgpNuOVePYdTsarQT/Vh61f7KGB+kQJ4IQ=;
 b=LxbYTPOmR6zUe8jmFkI2S1BHIYsASYvFp1IdLi5DkxwyxGLrdLgsX4/rzJEml7cK6B
 E4uKF3A47iiOXLcC4ZGaRXpBnhZOor+4DhI5vVs5RED2nmHDwBmJ9JZPaU96JN2ob/zb
 K8mTXYI5ZXNH0l0hX4wR8qWLT2Wva03wMmx2rlUaLOqnNdQ7ZEgbH3+Cg3JTGnWum/xa
 FyGJ3VP9HVW4RsJ8849jrAMPr6ARMSHWvwA0RxWdHO5668mR3kwXDxmNixvm3Nje9nc+
 okgI/n2NIOETGEyfpyJx2z5zXBotVO/4s0KzzItrVozAcChz5QXllSxT8/TjfEzBBuuP
 oDkg==
X-Gm-Message-State: APjAAAVTcn1TQaQDun6RT1FIkdAlrQ0wK8r+hkq7gw+WvjPdTHKGSpnf
 /XYKduuVnX5jQM6NF7nEoWiNCiDVsIf8YDGaMyhmCc7r2C8PBEUCUab19oAKG1r5dVLrp0OOabv
 zUjBIShPKfYchm0E=
X-Received: by 2002:a5d:560a:: with SMTP id l10mr47895614wrv.101.1566493528222; 
 Thu, 22 Aug 2019 10:05:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUp0elFTu32UOB1yfth8Wm8KpQL3JDeyVnli02FTSY5nvzg6TrAKyt+z8Ul5/hNvx0Mw42Ug==
X-Received: by 2002:a5d:560a:: with SMTP id l10mr47895574wrv.101.1566493527910; 
 Thu, 22 Aug 2019 10:05:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id f6sm404367wrh.30.2019.08.22.10.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 10:05:27 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822114747.GS3267@redhat.com> <20190822163150.GA3332@work-vm>
 <9caf3a64-0841-dde6-3413-a77dc80e22bd@redhat.com>
 <20190822165045.GM3277@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b9f98b17-49c4-a227-ab87-de4a6f42f089@redhat.com>
Date: Thu, 22 Aug 2019 19:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822165045.GM3277@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 18:50, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> On 22/08/19 18:31, Dr. David Alan Gilbert wrote:
>>>> With both these points in mind, I think it is  pretty hard sell to
>>>> say we should write & maintain a custom CI system just for QEMU
>>>> unless it is offering major compelling functionality we can't do
>>>> without.
> 
> (That was Dan's comment)
> 
>> In theory I agree.
>>
>> In practice, the major compelling functionality is portability.  If it
>> is true that setting up runners is problematic even on aarch64, frankly
>> GitLab CI is dead on arrival.  If it is not true, then I'd be very happy
>> to use GitLab CI too.
> 
> IMHO if for some weird reason Gitlab has problems on aarch64 then we
> just need to get that fixed.

I'm sure it's just some packaging or deployment issue.  But
https://gitlab.com/gitlab-org/gitlab-runner/merge_requests/725 has been
open for more than one year; the last two messages are:

* 1 month ago: "I hope we will be able to merge it soon"

* 3 weeks ago: "Today I tried use gitlab-runner on my arm64 box, however
it kept mysteriously failing"

So the question is simply who does the work.

Paolo

> Dave
> 
>> Paolo
>>
>>> I'd agree; and I'd also find it useful to have runners setup for
>>> Gitlab CI for related things (it would be useful for the virtio-fs
>>> stuff);  if there are problems on other architectures then we should
>>> find some go wranglers to go fix it.
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


