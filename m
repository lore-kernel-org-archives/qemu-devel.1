Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE27C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A402184E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDGT+NyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A402184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWwS-0000ve-Ug
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpWwH-0000RH-0K
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpWwG-0000wi-1k
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:57:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpWwF-0000w1-Q4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:57:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id a15so34855155wmj.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=s/KelhptN6ubJpqJZP1G3NB+n0K4Q5g/1q5F+spVmiY=;
 b=MDGT+NyUVUbUwmQwUQ/9zc5Dd+CStoXT95pCjjBrsvzZk/lxpNR6H3mt2o7+fAsx/j
 xwtolVhuhV7tq9bU1qL28h0kKiysBLHw6rTJZLksypoZWeXWP/sEjxVSos/TJaXGZdn/
 PScEHpHNOQo2HKZ7rCqlHosRAb4J69jIJb5Zr3l7CpkgrMFrbzqPGfohsvWZhiOTtBjO
 0Cv8c/EmbMifLgCL2AHThFkKDWB+cxwy2ab1JOWTpSyXn/CnXyLsTbJZiwgSdQblkTLy
 Wfj1/iGbTpFcPRdgy+PNhBFpUhHZ5Dtddsn9aESKuMZeMn+LkIwC3QpGBqJRGaQDE1XB
 VjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=s/KelhptN6ubJpqJZP1G3NB+n0K4Q5g/1q5F+spVmiY=;
 b=R7Kfp5vg+zTx6CysXeKllHgK5DBacJ8SWS3SSHD8TaLadIFUJfpwYYKsYCdVePXe/H
 83rgixljxcpq01j+pKuukeBqUjZua/7hce7I/K/Bxbuzo3d556e+MFQB92rWCy5m7gHq
 MQ4uzI4k2VqdieIgvBg33yeG4EgGGTX1vY+do/nS6jncPHqWv49tXwPinw+VHjgBL0ol
 E8t5o3TA2UdtXuk6uD9u5dymKH2uPULgt1E9wdYNpn+7Fk3yAxpQSvgUbG0iY1y/jdwo
 qfJSQW/Jnw0BvjmWNGO2LV9Ej/iS8axp2GBlxGI793enhpVe5+0kDRliVbOyMH4jaaam
 sS5A==
X-Gm-Message-State: APjAAAXfOjTh63lEKET68je27WAbpojzUyE3EXiMCsfYfLmlpp4JRBjM
 xm0PUubgVcML76P0JKR/RJQaTg==
X-Google-Smtp-Source: APXvYqx4Tqw38ayJEgPz0ODpkeUbVzR63fSbETcw5envmJhzGIzmXIVH5GghahKJdop2Z357qUaOGA==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr63806008wmi.38.1563796626205; 
 Mon, 22 Jul 2019 04:57:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e19sm52289067wra.71.2019.07.22.04.57.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 04:57:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D0321FF87;
 Mon, 22 Jul 2019 12:57:05 +0100 (BST)
References: <20190722111914.28574-1-alex.bennee@linaro.org>
 <CAFEAcA_uOX9qkrwRASAaxOfTms9SsQMEyhJ0XwYFiFPVtEnqkw@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_uOX9qkrwRASAaxOfTms9SsQMEyhJ0XwYFiFPVtEnqkw@mail.gmail.com>
Date: Mon, 22 Jul 2019 12:57:05 +0100
Message-ID: <87r26ijn8u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RFC PATCH for 4.2] target/arm: generate a custom
 MIDR for -cpu max
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 22 Jul 2019 at 12:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> While most features are now detected by probing the ID_* registers
>> kernels can (and do) use MIDR_EL1 for working out of they have to
>> apply errata. This can trip up warnings in the kernel as it tries to
>> work out if it should apply workarounds to features that don't
>> actually exist in the reported CPU type.
>>
>> Avoid this problem by synthesising our own MIDR value using the
>> reserved value of 0 for the implementer and encoding the moving feast
>> that is the QEMU version string into the other fields.
>
> Exposing the QEMU_VERSION_* information to the guest is
> usually not a good plan. For instance it means that the
> MIDR will mysteriously change if you save a VM on one
> version of QEMU and restore it on another.

Given the mutability of -cpu max that is probably a good thing?

> We went through
> a while back carefully removing places where we'd exposed
> the version number to the guest (have a look at the
> qemu_hw_version() stuff which has to jump through hoops
> so that old versioned machines like pc-1.5 report the
> old "1.5" version number, and any QEMU 2.5 and above
> now reports "2.5+"...)

Well I guess we could do:

  cpu->midr =3D FIELD_DP64(0, MIDR_EL1, ARCHITECTURE, 0xf)

but any kernel that attempts to apply fixups for a 0x0 implementer is
asking for trouble anyway. I assume it's unlikely ARM would assign QEMU
an implementer code!

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

