Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B06C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC33420674
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPUGUQrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC33420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJpc-0004uP-2g
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jtJou-0004TR-LN
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:49:44 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:41793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jtJot-0003j9-4u
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:49:44 -0400
Received: by mail-oi1-x22f.google.com with SMTP id y22so418758oie.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fZDXokwWMRUDp2VygwJr08cRd91R4Vllb0vRv1vvqec=;
 b=LPUGUQrXpwRs7kcwXb+yQ5hlwCzFJN3b7CXO36DAF3KOErDdAMRdPTuH65F8Xdwbxs
 2I/QcwjYrmh6keC+poMDWjczNjBr2GTflujQDwGEj+DbkQayn5pJSKzPDWiPH3JwMa9r
 Td8oC/oh+BXdBuf/8MGD2v9OHtkSMDp/z0xrKmO3OpAyFxJRb11Bgmr71O8kjlu2wtQE
 RR0pNKHFD9TIvum4g93dtKtVsGDpHBDyromCU0eqbWwruzr5sU0hUOl42j+Rr/KBdh3y
 eBvX7+hXnaiWlGrJKkJeStJmnkArNWaAFARHNxQblgsklAV+O/QzkIL5mWJB5Qun0opO
 ioCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fZDXokwWMRUDp2VygwJr08cRd91R4Vllb0vRv1vvqec=;
 b=UQGIUNi/OmcupWaguMGtjtjygElH9AR1XRx5m5AkzOnq22SYdCcUuKVwStkvBZht8e
 cc9ZAlkiNzRQe0zmF0vJkCJ8tTNHKaqA2pajH775mMMAP4IBBYSdy9dkcwjYG9KiD/m8
 Njmu9TyUEOX3w0HNJJUVHUtFpk77e/FEOD8zLXZc/Wd2O9MgdGkaWF5Hfs3XCQFGyLoy
 qRTVGaoFyX8Vmi76ytOQCHJobLei20xKRKqYxUYC43x4GYpE2Joc5fs0e7xfApSb/nYt
 uRWGVYUm/GMX141w3+oidc/Df0UtLM0Cfsq6PiGvPeAEH6kc+56bKOtuBEdti0XmpDS4
 V4mA==
X-Gm-Message-State: AOAM530wX5/vDexSyf8lvCkOnvkw/MNfbPqtbh4OPKYA1lyeqdc0a2+8
 PTBmKrxuyu2JGPuDpWacFVloUnA53it7Df0mFng=
X-Google-Smtp-Source: ABdhPJxHdVO+6nx0aJgERwTF3M/PB2Lu/Ir35EIBEjMa6uDbXNteVkqdig04lzO2WIDjOhW7czSd5fV9khIqXQxNy44=
X-Received: by 2002:aca:494d:: with SMTP id w74mr9397002oia.97.1594252181585; 
 Wed, 08 Jul 2020 16:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200708200104.21978-1-alxndr@bu.edu>
 <20200708200104.21978-2-alxndr@bu.edu>
In-Reply-To: <20200708200104.21978-2-alxndr@bu.edu>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 9 Jul 2020 07:49:05 +0800
Message-ID: <CAKXe6S+_wk93hxfUJH=0F9TL3WE0XmYOTwc5oHXs4h7878zaZA@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 1/2] configure: do not clobber CFLAGS with
 --enable-fuzzing
To: Alexander Bulekov <alxndr@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexander Bulekov <alxndr@bu.edu> =E4=BA=8E2020=E5=B9=B47=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:02=E5=86=99=E9=81=93=EF=BC=9A
>
> When configuring with --enable-fuzzing, we overwrote the CFLAGS
> added by all the preceding checks. Instead of overwriting CFLAGS, append
> the ones we need.
>
> Fixes: adc28027ff ("fuzz: add configure flag --enable-fuzzing")
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>


Tested-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index ee6c3c6792..078ebaa9f3 100755
> --- a/configure
> +++ b/configure
> @@ -7898,7 +7898,7 @@ if test "$fuzzing" =3D "yes" ; then
>    if test "$have_fuzzer" =3D "yes"; then
>      FUZZ_LDFLAGS=3D" -fsanitize=3Daddress,fuzzer"
>      FUZZ_CFLAGS=3D" -fsanitize=3Daddress,fuzzer"
> -    CFLAGS=3D" -fsanitize=3Daddress,fuzzer-no-link"
> +    CFLAGS=3D"$CFLAGS -fsanitize=3Daddress,fuzzer-no-link"
>    else
>      error_exit "Your compiler doesn't support -fsanitize=3Daddress,fuzze=
r"
>      exit 1
> --
> 2.26.2
>
>

