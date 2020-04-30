Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2C7C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1007D208D6
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUJTA75R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1007D208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEVy-00058V-35
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUEP2-0003JV-H4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUEP1-0001Kc-0u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:59:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUEP0-0001Jb-J1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:59:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id d15so8427332wrx.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YLjRaxvFVvDQLVtq8yJxp7L9LI3zvyDZfk6Sal47NwM=;
 b=xUJTA75R25G2/dDCAbBfjfPou2DDgxB2/Ix5bRicwZ2Q31QMigN5/U/2cqu27jY0J2
 WSxFGkjtJ3V8yz/1Pykok9q6LON45O4rNzwKUMf1s39/85s+VV8Kx66fpxNpyHV35hAO
 t8QJW59cXByUvvTv+XdP9eAMbYUUiJoy0X43esTXIVGGNMShX8BD7r0dWcPECdyXcEEQ
 rbe1sB3eZhOEhjNdEF7Am+u2KHcarb+KRixO9byZ3O+GsgS8pcBqOwwJJFbd3A1mNMxj
 UeyYvPKOG+Onkrk3pwwh+Z9j3+LdrQi25EkO7+1CVyLZ9LM2wkjZFBtsD0Drc2eu4Jgl
 0/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YLjRaxvFVvDQLVtq8yJxp7L9LI3zvyDZfk6Sal47NwM=;
 b=JEdQjD5kol5Oqb7ID9wJexpL39vBIQQmYDWNsBfzU0QCw4W8COmuV6QOa0ptBlcIro
 Ayv7ohuZ8D4IbQCsdwSkMl+Y718FUhG6gku87ggbaD98d/gCJBNUmZjeig30t7H0HMF3
 fbZviP5yDxD2mYhheuXbk//HVRfy9jevtVUge7XYNfXQNCvSHaKvlg/mKU58IxNig46n
 thM1BifX880WH2Ro0egSQZXzwbL39RY5l0ss3sD6xJg+9r2o9mfSYjP/TwDfQt8HAYYW
 1WgUMOfVHJ/Ts62Y3Y0OLDElOYe00KaSQ904ajQAciqu9D4yqmwigKExkWSoHOWUMWXi
 +MRg==
X-Gm-Message-State: AGi0Puba6H8OmDJP96HpVuIG5r/HJqTYiIt2pXA59D1KDa0LGUtyIVJR
 ForzyIcvabaf2Gg6jhg2NeVxlg==
X-Google-Smtp-Source: APiQypICtjw71hWAjUUIRM3MHUIx8kGgXngT7j+SBYazffTtUTJlkcVEDu5uOVeesulMDFkyY9LO7A==
X-Received: by 2002:adf:9342:: with SMTP id 60mr5342035wro.129.1588273156430; 
 Thu, 30 Apr 2020 11:59:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x18sm909074wrv.12.2020.04.30.11.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:59:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 199AA1FF7E;
 Thu, 30 Apr 2020 19:59:14 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004301648440.29315@zero.eik.bme.hu>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: About hardfloat in ppc
In-reply-to: <alpine.BSF.2.22.395.2004301648440.29315@zero.eik.bme.hu>
Date: Thu, 30 Apr 2020 19:59:14 +0100
Message-ID: <87d07okdfh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: luoyonggang@gmail.com, "Emilio G . Cota" <cota@braap.org>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 28 Apr 2020, Alex Benn=C3=A9e wrote:
>> =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:
>>> I am confusing why only  inexact  are set then we can use hard-float.
>>
>> The inexact behaviour of the host hardware may be different from the
>> guest architecture we are trying to emulate and the host hardware may
>> not be configurable to emulate the guest mode.
>>
>> Have a look in softfloat.c and see all the places where
>> float_flag_inexact is set. Can you convince yourself that the host
>> hardware will do the same?
>
> Can you convince me that it won't? This all seems to be guessing
> without evidence so I think what we need first is some tests to prove
> it either way. Such tests could then also be used at runtime to decide
> if the host and guest FPU are compatible enough to enable hardfloat.
> Are such tests available somewhere or what would need to be done to
> implement them?

I seem to recall it comes down to the various approaches that FPUs can
take when dealing with tiny numbers when rounding. Emilio did the
original work so I've CC'd him. The original paper is referenced in the
hardfloat commentary:

 Guo, Yu-Chuan, et al. "Translating the ARM Neon and VFP instructions in a
 binary translator." Software: Practice and Experience 46.12 (2016):1591-16=
15.

which is worth a read if you can get hold of it.

Running tests on start up is not without precedent. We have a
softfloat_init which checks for a broken FMA implementation. However I'd
caution about adding too many checks in there.

> This may not solve the problem with PPC target with non-cumulative
> status bits but could improve hardfloat performance at least for some
> host-guest combinations. To see if it worth the effort we should run
> such test on common combinations (say x86_64. ARM and PPC hosts with
> at least these guests).

We already enable hardfloat for all hosts apart from PPC and FAST_MATHS.

>>> And PPC always clearing inexact  flag before calling to soft-float
>>> funcitons. so we can not
>>> optimize it with hard-float.
>>> I need some resouces about ineact flag and why always clearing inexcat =
in
>>> PPC FP simualtion.
>>
>> Because that is the behaviour of the PPC floating point unit. The
>> inexact flag will represent the last operation done.
>
> More precisely additional to the usual cumulative (or sticky) bits
> there are two non-sticky bits for inexact and rounded (latter of which
> is not emulated) that currently need clearing FP status before every
> FP op.

Thanks for the clarification.

> I wonder if we can know when the guest reads these and rerun
> the last FP op in softfloat to compute them only if these are read,
> then it's enough to remember the last FP op. This could be relatively
> simple and may be used even if we don't detect accessing the bits
> within FPSCR just accessing the FPSCR as likely most guest code does
> not check that and any cross-platform code won't check PPC specific
> non-sticky bits so I'd exepect most guest code to be fine with
> hardfloat.

You could go further if you know nothing in a block can fault you can
skip the calculation overhead of the per-op flags for all but the last
op in the block.

> Although what about FP exceptions? We also need to revert
> to softfloat it FP exceptions are enabled so maybe using host FP
> exception for managing status bits could be the way to go to let
> hardware manage this and we don't need to implement everything in=20
> software.

Well for all apart from inexact handling (which would fault as soon as
set) all other exception types are detected before we pass them to
hardfloat anyway. Given the range of NaN types we would have to post
process and hardfloat operation anyway to give the right NaN.

>
> Regards,
> BALATON Zoltan


--=20
Alex Benn=C3=A9e

