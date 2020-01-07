Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2017C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697592187F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y12b+XD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697592187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq02-0003Pf-Ff
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iooqQ-0001ER-Ul
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iooqP-0001sr-Na
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:24:26 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iooqP-0001s8-G4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:24:25 -0500
Received: by mail-wr1-x442.google.com with SMTP id j42so53868945wrj.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MEPaZjJKplBO7wj4d4sOLL0rEvJQo/YpJlQXN5dOdjo=;
 b=Y12b+XD4S1r1JdLNO2RJWlHuFLGZ1VVFoJ2vnTu9vGcwsMFu6H109HZ2sHfn2I5qps
 0avj6Vpcw/GCnYcpVobECNMi64ySkxbScuphlGFr/ROPDrKKzOWwVyJf9QIrE8uPoGu2
 qaqE13QAG540WxwksbFdHMeXYTiyKREXs+DxGRTqeTsBa+6xJeTE7X0hDxxpxpYE99zM
 rEv5dzKoy8GJw9mu/FvSa1LqvgOCeS67HPi4lgMQpfvNwdR2pHzN+/ZhB2CpFKw+L26C
 InHFvw64ZpynAv4u8MhDzUHHBPtEJJEpb4/MeHNvIEd+tzR4kxN2K7Bp+j4B4tGsxpSQ
 6VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MEPaZjJKplBO7wj4d4sOLL0rEvJQo/YpJlQXN5dOdjo=;
 b=U8wQzaUCjJ2idHF+OhXgIZ1L0Qm8sKOfdEqYTPV6gddB7YgSxTC+d8tSeJMsaPGuGN
 wIosBJQPiJWnk5KE3OnkkJZOhQJxlTeqs8qFBNI2xkOWE1gjdTSTzw7jNu39Cj3RULM+
 QAVZbTOwN0gg1tkJLHv7bFu46vi/kib0VmiWWbvV5GsVmW/vCce1ZlpkjIDhrDoNEd4o
 9WkVSLlDXIg2gyfDC+iP4Juzy6ekLzxiu7CggmQ6yZls73z+GYyMw792FUnmTW6Mn22R
 anQc05vlwTIUs/0Acf8OdOJq9dn6YkbO7yhj6UbwIGPYP3bEegAUkGrdlipv5QukZlj/
 BJVw==
X-Gm-Message-State: APjAAAW4A4nQN4ORXrF+EdSfwWgQX+EDTA9duQecEhOYN6kfEtG6guDp
 dmZxAN8xyR9/Irwea+K0a1NtSQ==
X-Google-Smtp-Source: APXvYqzaulxMQHwyfPLOhki8M88MqRbSrVOlsN+srwhTGIQABunjNcExXu1gcAuTwzbq9eun4SAJWQ==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr111747490wrr.306.1578403464203; 
 Tue, 07 Jan 2020 05:24:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p18sm26801463wmg.4.2020.01.07.05.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:24:22 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBAFA1FF87;
 Tue,  7 Jan 2020 13:24:21 +0000 (GMT)
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-7-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/7] configure: Override the os default with
 --disable-pie
In-reply-to: <20191218223441.23852-7-richard.henderson@linaro.org>
Date: Tue, 07 Jan 2020 13:24:21 +0000
Message-ID: <87imln4cxm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: berrange@redhat.com, Thomas Huth <thuth@redhat.com>, i@maskray.me,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Some distributions, e.g. Ubuntu 19.10, enable PIE by default.
> If for some reason one wishes to build a non-pie binary, we
> must provide additional options to override.
>
> At the same time, reorg the code to an elif chain.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/configure b/configure
> index 2503288654..f6ff079fab 100755
> --- a/configure
> +++ b/configure
> @@ -2035,19 +2035,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
>    LDFLAGS_NOPIE=3D"-no-pie"
>  fi
>=20=20
> -if test "$pie" !=3D "no" ; then
> -  if compile_prog "-fPIE -DPIE" "-pie"; then
> -    QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
> -    LDFLAGS=3D"-pie $LDFLAGS"
> -    pie=3D"yes"
> -  else
> -    if test "$pie" =3D "yes"; then
> -      error_exit "PIE not available due to missing toolchain support"
> -    else
> -      echo "Disabling PIE due to missing toolchain support"
> -      pie=3D"no"
> -    fi
> -  fi
> +if test "$pie" =3D "no"; then
> +  QEMU_CFLAGS=3D"$CFLAGS_NOPIE $QEMU_CFLAGS"
> +  LDFLAGS=3D"$LDFLAGS_NOPIE $LDFLAGS"
> +elif compile_prog "-fPIE -DPIE" "-pie"; then
> +  QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
> +  LDFLAGS=3D"-pie $LDFLAGS"
> +  pie=3D"yes"
> +elif test "$pie" =3D "yes"; then
> +  error_exit "PIE not available due to missing toolchain support"
> +else
> +  echo "Disabling PIE due to missing toolchain support"
> +  pie=3D"no"
>  fi
>=20=20
>  # Detect support for PT_GNU_RELRO + DT_BIND_NOW.


--=20
Alex Benn=C3=A9e

