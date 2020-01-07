Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7571C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14AE222D9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RooiNLaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14AE222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopwy-0007oj-OI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iool1-0003h0-1k
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iool0-0007Y6-1s
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:18:50 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iookz-0007Xi-RF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:18:50 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so14941303wrm.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=F4RZ3RNIm/EZQJNxfXfsC5HolULABlTmlYeD0ThxhdQ=;
 b=RooiNLaVsAIhPhRZ1EhWjAYKTKQI5Xz3A3fGdvLYk5nWZ5FI+fd6rscKG+rq2AOdA/
 qL+EXt2COcSP4JCFjGXhXzX2KjyW5k60RT08DK+rYpMQJiuF5hOfug8voflmQ27aMK2V
 LtYNJqYVlPfSirLj+/XqZIBUdNdXggFtf1O/GHykgPWpq6tWd++o1lzJWQ9uGWgGH9ic
 b5xPy2IJdrckkRDK1wX1RIRkMFt8I1kBRaEdEUqiL+n/GdFfpss0hM/288qPU+OMJf+M
 NP8pCdIY1mW5izDYQ3yCNlakAmBhl7LS1dPna9y86wKQUeg67ER0UCuFieqas3gDRAfM
 SE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=F4RZ3RNIm/EZQJNxfXfsC5HolULABlTmlYeD0ThxhdQ=;
 b=G/mdk1Ohccl1yLpTGX7MJPGMKBoWd/PrmJWKYaJCpuUHMIw5a721s892r1Fdh68zlG
 AckIKXYLhRH95BQss1+IrwVFPbhcBZ1VoLx2SqNlmgSwjfU30oGooEEkM+5R6oF6wwga
 KFGFMf901T+i+6iSlUd0M+OU3gxLq21KI9I0ChR9s63OyOSNxY3dl2eWN1Q2FkOJR7mK
 QY9HnYSo+nwdol74Wsoo2tp+dbymVlXTte48nZWCTD0PhawbRqNUiZY1mlHm6svnVHw6
 IfN8iEpb7phNgX+3TtLYDgZEQ2Bi4tfJzyHcBHn33ts5OaijMwVxzG50buFWPwhcwbMy
 kKAQ==
X-Gm-Message-State: APjAAAUCWCkG6WeYYTvBCwFxwets0ebw+h3LhoQNwj/dvjOidyUrZWGr
 RpkEmFJ+VEqEWTwFbGdEmfpnCg==
X-Google-Smtp-Source: APXvYqyTwpcvah3t+D90O5Q7nXL4Gzy4ntJ2Ppzctwj7IujgXQT05NF5kafYiNQWcJuUB0G2Cv/umA==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr64219946wrm.13.1578403128653; 
 Tue, 07 Jan 2020 05:18:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s65sm27367313wmf.48.2020.01.07.05.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:18:47 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9D5061FF87;
 Tue,  7 Jan 2020 13:18:46 +0000 (GMT)
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/7] configure: Unnest detection of -z, relro and -z,
 now
In-reply-to: <20191218223441.23852-6-richard.henderson@linaro.org>
Date: Tue, 07 Jan 2020 13:18:46 +0000
Message-ID: <87lfqj4d6x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There is nothing about these options that is related to PIE.
> Use them unconditionally.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Do not split into two tests.
> ---
>  configure | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index 7a646ec007..2503288654 100755
> --- a/configure
> +++ b/configure
> @@ -2040,9 +2040,6 @@ if test "$pie" !=3D "no" ; then
>      QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
>      LDFLAGS=3D"-pie $LDFLAGS"
>      pie=3D"yes"
> -    if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
> -      LDFLAGS=3D"-Wl,-z,relro -Wl,-z,now $LDFLAGS"
> -    fi
>    else
>      if test "$pie" =3D "yes"; then
>        error_exit "PIE not available due to missing toolchain support"
> @@ -2053,6 +2050,12 @@ if test "$pie" !=3D "no" ; then
>    fi
>  fi
>=20=20
> +# Detect support for PT_GNU_RELRO + DT_BIND_NOW.
> +# The combination is known as "full relro", because .got is read-only to=
o.
> +if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
> +  LDFLAGS=3D"-Wl,-z,relro -Wl,-z,now $LDFLAGS"
> +fi
> +
>  ##########################################
>  # __sync_fetch_and_and requires at least -march=3Di486. Many toolchains
>  # use i686 as default anyway, but for those that don't, an explicit


--=20
Alex Benn=C3=A9e

