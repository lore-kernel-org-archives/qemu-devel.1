Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD3EC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B51206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6PKa4wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B51206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8lU-00052n-Mz
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ip8kc-0004X5-Fi
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ip8kb-0002Rj-46
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:39:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ip8ka-0002QX-S3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:39:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id a5so1942064wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 02:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SIyeqLIwSoMd/MatJpRZTUs43Ydcm7mt3mmc10it78E=;
 b=n6PKa4wIUkb6pAYopFEQptdr8DjpyGxGzlEk5IM7VcLzgiPFhinBNYMDQey2zOQZuP
 K07L1sT6dhtfrN08vphDjZakGCni8N66hrb+vz157xt7A4dhXh30WbXNp8+Zobvj3bmE
 Uai+i2VnJhKXDzS7dF1yJUYSEFVdqo72OoBEsMS4NYl990wchYuBsgf+Q/sFsqCioUgR
 7TpDgPFeF8T2kKEBBIAIbipwYm4cW+6TL+72MfGQHTdkeZdp2rFWXkzR19AnTAnnL4yN
 PI66Xfbz04APMiM4sfgI1uUDa8n/Q8gJFVeU0f99/bwNn8gQWsF4yk81I1GezZMT5d/+
 Mn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SIyeqLIwSoMd/MatJpRZTUs43Ydcm7mt3mmc10it78E=;
 b=e2/LaS809RigvqtDSyolmbyy+9EFoap6+FQMnySmmsVQEd5UqkWdiyJyvz6li5DHf2
 YFTSZ5JxGuSvHZNrdGskFOXOAGiZkwOQeV8AZa1xzd6jETe5tCnXYehdkLjVhvEoUofj
 0YuxMMac8mQUdD7YPcvG71XYMGsbu210oNRuWHiPQtup08GpGaK5rIx//iQpteWLJsN8
 SBoURmzVrqcbRL082dinM7691LcEX01d/DU+nQKeAs5rQJx1Fvfe2jJZzbQup/IG9FDh
 NKRjGtgepKSJHjd7ZymvmPqZFYH1JQmqi0Fs42qMItCcm/9lXKe+vreAmfjutikDsGUv
 SYpg==
X-Gm-Message-State: APjAAAXUQniFng/k9tvRSUmF1ea3shvAx3E+w5fO/uBu3v/HpJ1a2p2e
 jo/DuW1VRirebpB1B2CW2/EDHQ==
X-Google-Smtp-Source: APXvYqzi8RpIld9UWOH/pMIpAL6u8x3Bh+LED4M0TCqQ16gjoXsE6tne2lddzf/F99V/AlBrVDBNsQ==
X-Received: by 2002:a05:600c:210e:: with SMTP id
 u14mr3084741wml.28.1578479983014; 
 Wed, 08 Jan 2020 02:39:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm3796817wrr.11.2020.01.08.02.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 02:39:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 35FB11FF87;
 Wed,  8 Jan 2020 10:39:41 +0000 (GMT)
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update
 tests to recent desugarized -accel option)
In-reply-to: <3241dff4-6223-404f-55d4-846991763046@redhat.com>
Date: Wed, 08 Jan 2020 10:39:41 +0000
Message-ID: <87d0bujkpe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 07/01/2020 13.54, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Jan 07, 2020 at 01:23:18PM +0100, Paolo Bonzini wrote:
>>> On 07/01/20 13:18, Thomas Huth wrote:
>>>> I don't think we need a separate priority parameter here. But IMHO it's
>>>>  really rather common practice to prioritize the last option. So while
>>>> it might be more "self-explanatory" to a CLI newbie if the first
>>>> occurrence got the highest priority, it might be rather confusing
>>>> instead for a CLI veteran...?
>>>
>>> Prioritising the last certainly makes sense for a choose-one-only
>>> option, but I'm not sure it's the same for a choose-best option.  After
>>> all it was -machine accel=3Dkvm:tcg, not -machine accel=3Dtcg:kvm...
>>=20
>> IIUC, the main use case for specifying multiple accelerators is
>> so that lazy invokations can ask for a hardware virt, but then get
>> fallback to TCG if not available. For things that should be platform
>> portabile, there's more than just kvm to consider though, as we have
>> many accelerators.  Listing all possible accelerators is kind of
>> crazy though no matter what the syntax is.
>>=20
>> How about taking a completely different approach, inspired by the
>> -cpu arg and implement:
>>=20
>>     -machine accel=3Dbest
>
> Something like that sounds like the best solution to me, but I'd maybe
> rather not call it "best", since the definition of "best" might depend
> on your use-case (e.g. do you want to use a CPU close to the host or
> something different which might be better emulated by TCG?).

Indeed - you may well want to do TCG on Aarch64 if you want to test new
instructions.

>
> What about "-accel any" or "-accel fastest" or something similar?

"any" is just ambiguous, "fastest" is just begging for me to find a
micro-benchmark that TCG outperforms on ;-)

"-accel default" could be considered to have vibes of Do The Right
Thing (tm) and could in time actually become so!

Does qemu support any sort of configurable defaults mechanism via config
file where we can punt this sort of thing to the distribution/packager?

--=20
Alex Benn=C3=A9e

