Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F35C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208A52171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi1sQ13i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208A52171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSkd7-0000DX-CR
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 11:55:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSkbt-000833-0C
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSkbr-0001Xh-SK
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:53:56 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hSkbr-0001XQ-NJ; Mon, 20 May 2019 11:53:55 -0400
Received: by mail-oi1-x241.google.com with SMTP id v2so10368351oie.6;
	Mon, 20 May 2019 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Gs0kl/XKWL4VZt8EyiEa3WDXQNOIJkACfh3axcEU2sI=;
	b=Gi1sQ13ih83yz1q8MEKPuBZtPez423nvF5SJimXwVOeRuoe2tnlY6WJRuCfebMnUnw
	RrtM494IOziML/BTZSdoHF+JGPCR/Vrb3IR5fbLHUELEp0rFUPKuo3GdmgWqlHV1htlk
	qdVPGKQ8GkkwO1gPV3IrEsZdC5WsI/Oylcp3c+VXX8m7drCWLUgBOd2Q9FUTq8HCBJoJ
	OeUKjjlzjCFvUaO3jLz5HrSpjnFTo64C/1c8v+p3vAFjxqm0J3G3vIrXn3DltZOt0w1d
	OncVnX3yxdORyAaiASELg1208SRSCKb3YGB0cCYYXuV7oY7TR/aVjU2cQ3skIzUOTa9v
	Pc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Gs0kl/XKWL4VZt8EyiEa3WDXQNOIJkACfh3axcEU2sI=;
	b=FgKPstjh/cadmm8IpWWg+XJdHQh8Y8rVHL+bitLh4N399as+7oYV0nm7Tz0BqSgeEi
	V+IiRPppWCZs3zlHKqxoZB1JvCpumJ6OOT7CO/RIHWbNZ5XTTsweqBgv8MhVe+v87MqX
	u5M+dEmFpStJ2A0vlxPu5RYUL0zSw8dstQ/3TDfv4GvqTAVtFW9fVIjebFpWek/Zdqez
	00+tDCLLcS8KoyuycAcnPZr06mBAKbt3MN61bw3gXE7mkbcCTexzpsAgvrY9p+9QftAq
	ZXobQa1PsGWISGngYSVCKOWCdH2HlSvZaENRs9xRbt/wdozkZOn9+x2e0XOeUfRfQ2Ps
	WDkg==
X-Gm-Message-State: APjAAAWV9lHrHY/pYbbwn5mnnN5U8Oj5bd5JPN2Xcn/23CbXX4NKzYvg
	2s4xDjymopq5Ig4BDVsraMINiel7Z+7BNEEERT8=
X-Google-Smtp-Source: APXvYqxEZ4TqKx6u3sJUY3Cshh2C+8F4WjycACiUu7EFfseZdhbBYp3J+xz6xY+u0MBDX0mQbJiKVFiLjE7oUSyh9z8=
X-Received: by 2002:aca:3906:: with SMTP id g6mr16358566oia.106.1558367634670; 
	Mon, 20 May 2019 08:53:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 08:53:54
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 08:53:54
	-0700 (PDT)
In-Reply-To: <20190514155301.16123-10-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-10-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 20 May 2019 17:53:54 +0200
Message-ID: <CAL1e-=iS33qAdeN0uODh7nak55OVuLBs=ftVqgvobn5mdMOmbQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RFC PATCH 09/11] target/mips: only build
 mips-semi for softmmu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 14, 2019 6:04 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote:
>
> The is_uhi gates all semihosting calls and always returns false for
> CONFIG_USER_ONLY builds. There is no reason to build and link
> mips-semi for these builds so lets fix that.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  target/mips/Makefile.objs | 3 ++-
>  target/mips/helper.h      | 2 ++
>  target/mips/translate.c   | 8 ++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
> index 651f36f5176..3448ad5e193 100644
> --- a/target/mips/Makefile.objs
> +++ b/target/mips/Makefile.objs
> @@ -1,4 +1,5 @@
>  obj-y +=3D translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cp=
u.o
> -obj-y +=3D gdbstub.o msa_helper.o mips-semi.o
> +obj-y +=3D gdbstub.o msa_helper.o
> +obj-$(CONFIG_SOFTMMU) +=3D mips-semi.o
>  obj-$(CONFIG_SOFTMMU) +=3D machine.o cp0_timer.o
>  obj-$(CONFIG_KVM) +=3D kvm.o
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index a6d687e3405..90ab03b76e3 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -2,7 +2,9 @@ DEF_HELPER_3(raise_exception_err, noreturn, env, i32, int=
)
>  DEF_HELPER_2(raise_exception, noreturn, env, i32)
>  DEF_HELPER_1(raise_exception_debug, noreturn, env)
>
> +#ifndef CONFIG_USER_ONLY
>  DEF_HELPER_1(do_semihosting, void, env)
> +#endif
>
>  #ifdef TARGET_MIPS64
>  DEF_HELPER_4(sdl, void, env, tl, tl, int)
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3cd5b11b16b..fb905c88b57 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -13726,6 +13726,14 @@ static inline bool is_uhi(int sdbbp_code)
>  #endif
>  }
>
> +#ifdef CONFIG_USER_ONLY
> +/* The above should dead-code away any calls to this..*/
> +static inline void gen_helper_do_semihosting(void *env)
> +{
> +    g_assert_not_reached();
> +}
> +#endif
> +
>  static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
>  {
>      int rx, ry;
> --
> 2.20.1
>
>
