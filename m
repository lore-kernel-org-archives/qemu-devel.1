Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E9DC33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E6C20656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ckcvsr1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E6C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVct-0002Lg-3q
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipVbz-0001Zy-9g
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipVby-0001mo-7s
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:04:23 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipVbx-0001ik-Vs
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:04:22 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so6975553wrr.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JssLQ7CCrGGE16jdVWBIGiRqDjFtPS75sE2+TnHskWk=;
 b=Ckcvsr1yCQTEfY6RIGHayLWbEWwDoPWhQtn7oBm3s8QXBHqUCvBmjvL5GbYqmT2ZqZ
 NyYAa8uxndHnLMb/ImrCEJgEAmgf38MVzbn0FliSuU0e7e1Yxti/1PMp2lakyxD+3oEC
 MIVeKzUlY+twvtYMxS2A3jcrcyUqlqkI+0/mIoVknvytKRoVcSmRB8VcPrzn2lhMRxIx
 HSXN3uCEc+/jIrosickQ1HrDpmq57l3XhHh+FMDMafPClkDlMwJ/c4EwQlbEnHJksTNx
 G7RVddt/F8jefkgriXSbV7J0nr3hGSmrf/2MdJnAyusxdowg5p2o2zH4TwT6FNtQjB+r
 G/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JssLQ7CCrGGE16jdVWBIGiRqDjFtPS75sE2+TnHskWk=;
 b=WQyl/D0lAqbFPCaUXzQ7fSDHvqw1Q2mZiUU+A8XlSo2tv/Fyl1adXXnIX+A4XmwmFr
 S+tCBmPplJFBbp5Kl4hkoQRUmYGWscYA+czDeObJ7/enkceT6asJRGam1sbejkFoovCi
 /i9okR+z7RD75gqoG22GD/7N3qEgMdw8jTlX28Z5bF+05h8nIB5LnS/ZlzA1/LJ2xRRr
 lUV4ZAYCfrwuL1k0OVBShgPLmSS7qZffRAz3huSQgyt88iHII36zdsPMr/xO7Q2Lcm0L
 jBcbuK+r9tqL0uNTrIsFj7dcSEDqsEG1Gxy1Ci1J7EBM0bZKZDVkEWpfF8Son314THGJ
 Q6IA==
X-Gm-Message-State: APjAAAWNQAX1kg6LUASkzuEY4jBijh0IakqpVlBveU8N5ZvD5udvt+rd
 aOL/mt+sbIJ2Gf5+BA5c27nQDBKLSak=
X-Google-Smtp-Source: APXvYqy7p7jnA5ahmWdJ3KNbpFhHjSuaYINvRuHALESlJS8v2XBg0sbxaWkX/BwASuLQzuY8T1VtnQ==
X-Received: by 2002:a05:6000:11c3:: with SMTP id
 i3mr10190437wrx.244.1578567860193; 
 Thu, 09 Jan 2020 03:04:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i16sm2618143wmb.36.2020.01.09.03.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:04:18 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 108EE1FF87;
 Thu,  9 Jan 2020 11:04:18 +0000 (GMT)
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] vl: Free accel_list in configure_accelerators
In-reply-to: <20200109021710.1219-3-richard.henderson@linaro.org>
Date: Thu, 09 Jan 2020 11:04:18 +0000
Message-ID: <87y2ugj3gt.fsf@linaro.org>
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We allocate the list with g_strsplit, so free it too.
> This freeing was lost during one of the rearrangements.
>
> Fixes: 6f6e1698a68c
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  vl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/vl.c b/vl.c
> index be79b03c1a..c9329fe699 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2748,7 +2748,6 @@ static int do_configure_accelerator(void *opaque, Q=
emuOpts *opts, Error **errp)
>  static void configure_accelerators(const char *progname)
>  {
>      const char *accel;
> -    char **accel_list, **tmp;
>      bool init_failed =3D false;
>=20=20
>      qemu_opts_foreach(qemu_find_opts("icount"),
> @@ -2756,6 +2755,8 @@ static void configure_accelerators(const char *prog=
name)
>=20=20
>      accel =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
>      if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
> +        char **accel_list, **tmp;
> +
>          if (accel =3D=3D NULL) {
>              /* Select the default accelerator */
>              if (!accel_find("tcg") && !accel_find("kvm")) {
> @@ -2787,6 +2788,7 @@ static void configure_accelerators(const char *prog=
name)
>                  error_report("invalid accelerator %s", *tmp);
>              }
>          }
> +        g_strfreev(accel_list);
>      } else {
>          if (accel !=3D NULL) {
>              error_report("The -accel and \"-machine accel=3D\" options a=
re incompatible");


--=20
Alex Benn=C3=A9e

