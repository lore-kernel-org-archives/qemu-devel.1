Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2680C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795D7206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ik/L+aiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795D7206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9meq-0003zF-NC
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i9md7-0002sH-Dt
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i9md4-0000G2-Pu
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:45:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i9mbw-0007uA-Kp
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:45:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id y21so4972365wmi.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hoCrFR+OnpOX+tndrBZoKWL2kFe0hX8F/LS8NNdy/Nk=;
 b=ik/L+aiIMLhWcg15EBJwPcjuUMjGNNleHsWiqYT63kAE6u8ZiKpH3jO/mb2nVSemTj
 a3c/+wPftmXC4J8k7eK43CHBVlae1khEYNIRxbKpMBDiTo31oPkBFO8rTCciAeIm86/+
 BUbSmNn7v63avg5UwBCEMRGlB9pvqszH1nRoLKdAtHoovZctQtDjTG9S02lmbhVzEjMv
 Njt44mCBxb6cwJpB0dMQJYD7eE4AYi5ixyVqNBG8X9Wg//ugtkZniWe3dP9Oh/M9LQXH
 FRIhoA1Vs1J7v2AksdMLvlraoc4xJVT3+5Scm5X71o5+0rIrEODLXcjd+gvUsK2vR7x7
 BtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hoCrFR+OnpOX+tndrBZoKWL2kFe0hX8F/LS8NNdy/Nk=;
 b=uismbJAah0tMVRcn2IgzMofUg+GAKX3x3lToe7FhFKJkG9TFLi3trWU43Gv1QuaS+f
 YIvUmU7x2V4SHJ66Gs006y2lK8/TMUa+ee3prkAftBOIRtd5TlASbGtMg8ZmlWauRnhR
 TFwAH9RVJWTjwBiEX0W35R+H/Os4IBGvizog2VX5tYyDmhIoLcR/ShHmu0MO8feipVZZ
 1q9vvwqSmg3l4H5ys/tEbX6Oigo+4C8e1pfko2ztn8nWJtCaeNQQmmq6P5S/DvMUAS/0
 4KkBvb6Br7ins5wR82GmYEJti6H3DHN9DFUV1ffCYbgXr8UsQx1iKs3EyaTdNp++F693
 dI1g==
X-Gm-Message-State: APjAAAVn8jZsVyNrMc9l4CX0X+hS0iWa+A6YFTp5rBPvBgHx3Q+evO2g
 +GB58sd81Tim/QvmJ8XOczzdZQ==
X-Google-Smtp-Source: APXvYqyUtXEA8+L3my1FnvC8AIrAo26kNQ7UQrNa+o9H3ZVp+RDd2F4+SvYNtw8dA7ljiAxzhiVGJA==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr12892855wmk.21.1568623430950; 
 Mon, 16 Sep 2019 01:43:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r18sm14295466wme.48.2019.09.16.01.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 01:43:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8CB661FF87;
 Mon, 16 Sep 2019 09:43:49 +0100 (BST)
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-7-f4bug@amsat.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
In-reply-to: <20190915211940.30427-7-f4bug@amsat.org>
Date: Mon, 16 Sep 2019 09:43:49 +0100
Message-ID: <87o8zk1vi2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 6/6] .travis.yml: Split enterprise vs.
 hobbyist acceptance test job
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  .travis.yml | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 69a37f7387..753276eb33 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -265,9 +265,23 @@ matrix:
>          - "3.6"
>
>
> -    # Acceptance (Functional) tests
> +    # Acceptance (Functional) tests [enterprise]
>      - env:
> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-soft=
mmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu"
> +        - CONFIG=3D"--python=3D/usr/bin/python3
> --target-list=3Dx86_64-softmmu,mips64el-softmmu,aarch64-softmmu,s390x-sof=
tmmu,ppc64-softmmu"

You could use:

  --target-list=3D${MAIN_SOFTMMU_TARGETS}

and

  --disable-user --target-list-exclude=3D${MAIN_SOFTMMU_TARGETS}

> +        - TEST_CMD=3D"make check-acceptance"
> +      after_failure:
> +        - cat tests/results/latest/job.log
> +      addons:
> +        apt:
> +          packages:
> +            - python3-pil
> +            - python3-pip
> +            - python3.5-venv
> +
> +
> +    # Acceptance (Functional) tests [hobbyist]
> +    - env:
> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dmips-sof=
tmmu,arm-softmmu,alpha-softmmu,ppc-softmmu,m68k-softmmu"
>          - TEST_CMD=3D"make check-acceptance"
>        after_failure:
>          - cat tests/results/latest/job.log


--
Alex Benn=C3=A9e

