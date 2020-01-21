Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577B6C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 02:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA5522522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 02:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ3yqI+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA5522522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itjO9-0004e9-6K
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 21:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itjNM-0003jL-Fy
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 21:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itjNL-0004tc-7l
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 21:34:44 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itjNK-0004sc-V8; Mon, 20 Jan 2020 21:34:43 -0500
Received: by mail-lf1-x144.google.com with SMTP id y19so888299lfl.9;
 Mon, 20 Jan 2020 18:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JDjK8f1wNDnYnv5MklAFUQW2n0lqeI71GG2vg7iUWG8=;
 b=fQ3yqI+LFK7V/MhmaV3QyECDozlmW8wLhOlzrtdO8cnsSJcvgQGgN4r7Srxu03Ck8/
 KGX8HttVcq1QoSKZu3LbFcdxyhVVhZnbA7ze1N1Xp18eXsnv0ty8e/Ic8Y/9Ml2+RNwr
 E2VXjl6Cgt4ri5bQkx2d7WRLKnzvq1Mg1Sa8OywfFmAOn2QljpGQOhtOlRMz6RWVeDLD
 qWxR1Vx2Q2b+xgt7JPqmlE7JF8511+AWxZC6nusnOLX010bT+YbmPHK+XIIVa065ZeSp
 mh9ri4n2g7GqI0kZBPdxAvNfsW9W6RM+GChS0ODuTV4ByOSlA3Hf2Lyc+vevV9O8z4kv
 RuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JDjK8f1wNDnYnv5MklAFUQW2n0lqeI71GG2vg7iUWG8=;
 b=gwQ3yhebHEki7ZpRRigOtCrztjrEzjcfQ4t7oPiz9Y0rjRUcGe6bCCA9cPXnguwEs0
 oqvL4y1WJ8vNu2dY2KIjA3TZ+cIaSCVaYP+t2RuPuB1LlXfYI0nJowgjrWb6WQqrVXnH
 xFcPNs87nJHSvNQvxAL0c/kEgUbbk+RLPhwzSsoQe30lUH49jO2uskpCU4/lzFNvTBov
 QOa4/mWI8dBsAaUki3lZ6GhEUEuHCEB/V3wivdTBos3zZ0uNsDp3RjgGAx9Tryr3F52D
 X2vMqqfyeDM2osPs3aFE3tl5vOEKalUIwSGXyZAjHVL7BUnUjYWaiVkKaOTg5eUBDD6M
 3dTg==
X-Gm-Message-State: APjAAAXq0rRfqs2vfsnel2uHLMJpO7kiE1nIr4OZYMiE08c9ELLO2oXy
 +tphV6yf7PsMkhYDh8Y+D4XKm25LuATTyt3DpYc=
X-Google-Smtp-Source: APXvYqw+3qRIWTmWXGfPKfh6gCC8kCPwZ+5YpcF3HQEaQfU+tYMBKfnBc9rAHgV1Sq8HY/jRCwrcqy7zuAF5VWSIdxA=
X-Received: by 2002:ac2:4422:: with SMTP id w2mr1278069lfl.178.1579574080791; 
 Mon, 20 Jan 2020 18:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-2-f4bug@amsat.org>
In-Reply-To: <20200120235159.18510-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 12:34:11 +1000
Message-ID: <CAKmqyKOCx5kc9ZvPCB9nJ6W3UZV6K1ji=zWvgo9_30U6BLQWBA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] hw/arm/raspi: Remove obsolete use of -smp to set
 the soc 'enabled-cpus'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Emilio G . Cota" <cota@braap.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 9:53 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Since we enabled parallel TCG code generation for softmmu (see
> commit 3468b59 "tcg: enable multiple TCG contexts in softmmu")
> and its subsequent fix (commit 72649619 "add .min_cpus and
> .default_cpus fields to machine_class"), the raspi machines are
> restricted to always use their 4 cores:
>
> See in hw/arm/raspi2 (with BCM283X_NCPUS set to 4):
>
>   222 static void raspi2_machine_init(MachineClass *mc)
>   223 {
>   224     mc->desc =3D "Raspberry Pi 2";
>   230     mc->max_cpus =3D BCM283X_NCPUS;
>   231     mc->min_cpus =3D BCM283X_NCPUS;
>   232     mc->default_cpus =3D BCM283X_NCPUS;
>   235 };
>   236 DEFINE_MACHINE("raspi2", raspi2_machine_init)
>
> We can no longer use the -smp option, as we get:
>
>   $ qemu-system-arm -M raspi2 -smp 1
>   qemu-system-arm: Invalid SMP CPUs 1. The min CPUs supported by machine =
'raspi2' is 4
>
> Since we can not set the TYPE_BCM283x SOC "enabled-cpus" with -smp,
> remove the unuseful code.
>
> We can achieve the same by using the '-global bcm2836.enabled-cpus=3D1'
> option.
>
> Reported-by: Laurent Bonnans <laurent.bonnans@here.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Cc: Emilio G. Cota <cota@braap.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/arm/raspi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 6a510aafc1..3996f6c63a 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -192,8 +192,6 @@ static void raspi_init(MachineState *machine, int ver=
sion)
>      /* Setup the SOC */
>      object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ra=
m),
>                                     &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), machine->smp.cpus, "enabled=
-cpus",
> -                            &error_abort);
>      int board_rev =3D version =3D=3D 3 ? 0xa02082 : 0xa21041;
>      object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
>                              &error_abort);
> --
> 2.21.1
>
>

