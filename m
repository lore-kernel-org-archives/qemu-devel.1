Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C283C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A772074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A772074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRb5G-0008IP-4h
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRb3O-0006NO-Ja
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRb3O-0004Bo-7X
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:34:06 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRb3I-000413-0Q; Thu, 23 Apr 2020 08:34:01 -0400
Received: by mail-yb1-f196.google.com with SMTP id a9so3038840ybc.8;
 Thu, 23 Apr 2020 05:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nEDf5mxj4Ya/1xWAyK0uMzyWdgw+j9J1oE1Euva5YQE=;
 b=EIfWtAtCQB/JXi7ds3T9d5DyCCEnnoXlYyzLWi17ZSJ4Hamf7EiIGiZ5YZg+O2f4CS
 cckcmxF41mleQmvb8ihnZxhZWkNJCLJRZrx3fp/kKhHdoCSN51rQo+jeYaEmc8A5IBc0
 +uwefPI0n6FtkOCtqsQPMo1IwqOjXZZJQxetVs660F9ecB3OV8ooJYbmLk4YfDsDhml6
 5vTQ6+/izYM4NOCBLKitEisfNaldaU2rcfavkJ4WlZz2R2tZ5MQwY/U4vie7mTM3dn8p
 2uPcC6zS8HgLojA9uLSjYRA6QAnlal+1/W78b211PqPdzIHI76vqgZInZBcZTwQCYAoL
 SO7Q==
X-Gm-Message-State: AGi0PuY0fx0/RDTbcZe8wtS/rDqhIKwBV37cIcQNWExzJDhAWDiNM+0J
 N4SFXm6u7i8PlrR2VNZhyK75Ldq11+f7dFjD1dcnz6dr6W4=
X-Google-Smtp-Source: APiQypKFI+sd/z0FZ/cBMpHhPvSqHXkRYP2p0KaRzKAoQ3QMwsLzzi6GwYpgHx4GMNhIudJFVZkTs3vy+t86gTFgL+Q=
X-Received: by 2002:a25:6a09:: with SMTP id f9mr4502446ybc.316.1587645238123; 
 Thu, 23 Apr 2020 05:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200423110915.10527-1-peter.maydell@linaro.org>
In-Reply-To: <20200423110915.10527-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 23 Apr 2020 14:33:46 +0200
Message-ID: <CAAdtpL4nHgtrVNvAEOOba75vj6JcsfMPyicUmMSH9SOs3ovAZQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 ID_AA64DFR0
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.196;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-yb1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 08:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 209.85.219.196
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 1:09 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> In aarch64_max_initfn() we update both 32-bit and 64-bit ID
> registers.  The intended pattern is that for 64-bit ID registers we
> use FIELD_DP64 and the uint64_t 't' register, while 32-bit ID
> registers use FIELD_DP32 and the uint32_t 'u' register.

Variable names could be improved...

>  For
> ID_AA64DFR0 we accidentally used 'u', meaning that the top 32 bits of
> this 64-bit ID register would end up always zero.

-Wconversion CPPFLAG helps but there are so many places to fix that we
are not using it:

target/arm/cpu64.c:711:13: error: conversion from =E2=80=98uint64_t=E2=80=
=99 {aka
=E2=80=98long unsigned int=E2=80=99} to =E2=80=98uint32_t=E2=80=99 {aka =E2=
=80=98unsigned int=E2=80=99} may change
value [-Werror=3Dconversion]
  711 |         u =3D cpu->isar.id_aa64dfr0;
      |             ^~~
target/arm/cpu64.c:712:13: note: in expansion of macro =E2=80=98FIELD_DP64=
=E2=80=99
  712 |         u =3D FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
      |             ^~~~~~~~~~

>  Luckily at the
> moment that's what they should be anyway, so this bug has no visible
> effects.
>
> Use the right-sized variable.
>
> Fixes: 3bec78447a958d481991
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/arm/cpu64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 95d0c8c101a..4c7105ea1a1 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -708,9 +708,9 @@ static void aarch64_max_initfn(Object *obj)
>          u =3D FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
>          cpu->isar.id_mmfr4 =3D u;
>
> -        u =3D cpu->isar.id_aa64dfr0;
> -        u =3D FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
> -        cpu->isar.id_aa64dfr0 =3D u;
> +        t =3D cpu->isar.id_aa64dfr0;
> +        t =3D FIELD_DP64(t, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
> +        cpu->isar.id_aa64dfr0 =3D t;
>
>          u =3D cpu->isar.id_dfr0;
>          u =3D FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
> --
> 2.20.1
>
>

