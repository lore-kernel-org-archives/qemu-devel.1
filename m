Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A78C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF106206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmxk6lNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF106206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYTz-0000eb-0J
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyYSu-0008IE-Ci
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:28:41 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:43936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyYSr-0004Gj-GP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:28:40 -0400
Received: by mail-oi1-x229.google.com with SMTP id x83so4532247oif.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CpZEVGndrvW4xinB6gp3y7B+mCnbrybNTf2qhctn0Mg=;
 b=nmxk6lNasBBCMIkoK4vixKBuWL8A+o0OMZ3OCP83kl4cZlv4gjvdvqVmHbbkHNpP8M
 Psq0O5wrC6d0OpLIf3Vzl1m9fcEtcKCZUQ3In+tQFEIM09opX3xiHL4qETfS50GrtV/e
 QTGHfKxJZ1qU9NA9MwkYUuwOJHUiQQ5xGMV1z39Ym/vzTH7Z5H/GBrvS2p19YdOqT3vk
 xM1PiRVgmMZxfH4hArk5qFYGxpRtHju7sLMkPz5cHxcTJJXMekStcClMDWh+IjqMvCs0
 8qySw2wq9wW09qmFCZNGXx7vWn3OUlNrxk2pZleO5rIHMrM+UfOiQQ9N3G3mkN6K7+pu
 +cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CpZEVGndrvW4xinB6gp3y7B+mCnbrybNTf2qhctn0Mg=;
 b=KyJ6kASZWM6sm3SJSAao7HEWbg9G0370FdqD3QKSUex+iuyywnm3758QSZ13r4pkUX
 QHaVkrDCaqglgybr3jyfFdrph7wT4JI6DY6t4/wzGFLk+xccuHskORO+PHlq/zU/i63I
 19tLF3dMuRU2SOSSH6SWM5ONyK3iMDw04hB/zKwyYyrYrEbypM2sksu6x1P2zbWFCxxb
 cqt55eAAZcGLw6EgLqKfLyhMfMvQ9+dT4GP1vxL9Lh8rIV/rKVHS/CPmzb5Wb7wDKXKi
 s5eD5aWGvOZwDbzT7hbYLN782aR7ALNXSagLzpuSqF1Tf/ZEBW2B87F2Uml7qyMAzQf1
 djUg==
X-Gm-Message-State: AOAM5307mJfQAZIWVJJBq26Kk8WVkRnxAIDgMVPXS68pFHQJGXgGAGR8
 rHcAo9YKlcR7vRobyjDRgn9SMmbIFwvThzeSH9s=
X-Google-Smtp-Source: ABdhPJwvdbdkWzZO9w6q5qsfA9liHZCsd4vxF2/U/xxeznCUBsvj2niKtjHHdwJ2/7aX3wZgINQQzHG5PQImCHVdLk0=
X-Received: by 2002:aca:494d:: with SMTP id w74mr3230071oia.97.1595500116305; 
 Thu, 23 Jul 2020 03:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200723101453.11129-1-philmd@redhat.com>
In-Reply-To: <20200723101453.11129-1-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 23 Jul 2020 18:28:00 +0800
Message-ID: <CAKXe6S+fS+a63ph4mdQ8UPa9BU3B_Uay2-_k0XroxnU1uJ50rA@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] qapi/error: Make error_vprepend() static
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x229.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=
=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:15=E5=86=99=E9=81=
=93=EF=BC=9A
>
> error_vprepend() is only used by util/error.c where it is
> defined. Make it static to reduce its scope.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/qapi/error.h | 6 ------
>  util/error.c         | 6 +++++-
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 7932594dce..fa2308dedd 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -384,12 +384,6 @@ void error_propagate(Error **dst_errp, Error *local_=
err);
>  void error_propagate_prepend(Error **dst_errp, Error *local_err,
>                               const char *fmt, ...);
>
> -/*
> - * Prepend some text to @errp's human-readable error message.
> - * The text is made by formatting @fmt, @ap like vprintf().
> - */
> -void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
> -
>  /*
>   * Prepend some text to @errp's human-readable error message.
>   * The text is made by formatting @fmt, ... like printf().
> diff --git a/util/error.c b/util/error.c
> index b6c89d1412..3990b741ff 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -121,7 +121,11 @@ void error_setg_file_open_internal(Error **errp,
>                                "Could not open '%s'", filename);
>  }
>
> -void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
> +/*
> + * Prepend some text to @errp's human-readable error message.
> + * The text is made by formatting @fmt, @ap like vprintf().
> + */
> +static void error_vprepend(Error *const *errp, const char *fmt, va_list =
ap)
>  {
>      GString *newmsg;
>
> --
> 2.21.3
>
>

