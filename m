Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA96C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8629423102
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZvvyjSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8629423102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zD8-00038K-PX
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6zCS-0002dF-6s; Sat, 15 Aug 2020 12:38:32 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6zCQ-0006LN-PH; Sat, 15 Aug 2020 12:38:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id k12so10119384otr.1;
 Sat, 15 Aug 2020 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6x8ZgXFNj8hCFkssNg2uV681vQahkWv9jYTpIedwZ/4=;
 b=cZvvyjSg6bNTpoyEYxGlFZonbx3JpNsomRoxGxNk+xTecYhnsan+d6bxSmOjm/N2NJ
 htjTsibb5ft3xQ1rW3mhnM/WzL6818jTzRtGwXNHm7PixNjF+jx9tzSmI/jUq689Swl1
 Z11mxhvX6FzLOmL67OXYpvXS41G8/v0n3AC7V8AKldKIWe6dkj7PV8r/EzZ09zykW0jV
 4eM2Jj34RzWM/5wRY1MNDj32fXU0Jzq/3goY3YRBR4z96thRjvVAc+bZv5isYEJZewq3
 cOhcKsbIPpq6iK2ggevtw2F2Xga9oE9IeA0YR0SZcJ18J2KgTi6BiNlKgEVkqLnb/QLn
 tx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6x8ZgXFNj8hCFkssNg2uV681vQahkWv9jYTpIedwZ/4=;
 b=JgwA0kpRDrei/ZLdw5+gPAyl4xb7g3ny+CSw6kvEV4Oz35fmWeY2mikGdyrvGVe1QW
 NdyF4e4qs6NtWBnjljjnL51qaHLFYk8Qor08Gg+Sj6jdhSld4reG1gGxh8C/uCSzFpOg
 +67VyL/6m5g8rhcqnxcdjqvRU8BR8tDltTNcEOs5HM84Oehq8NJlxdYh0nxawE05+TH8
 bRFmr7dcz8zHAySiulgU6jYJ2ir3SIS8nKF1VE2rdGMru1+ez0MWocGAEE0VNh8prJH3
 lfwoxGE5hnARs5SMp74kt52QWwTyK+K0k1dGBR0BNmrWULTCXn1jrwuH+vlOD1Hpu7t/
 00VQ==
X-Gm-Message-State: AOAM531c5wAkK829qDAHORuF34D1GgUrYTfYsdMHnn6J0X1flHcvMChP
 48X6hzatbHPMQ8KM9BB/MIOWWTgRfU80wzDcZCNnpsa8nFw=
X-Google-Smtp-Source: ABdhPJwCPpQrHBOZbhwDh8t1l9RqMOcHwwSk2FqJjeLb0Mmy4cOOR6a3c8GH8s3VAIltZnm1rT9UTlkAKlTchq1ZMOk=
X-Received: by 2002:a9d:2926:: with SMTP id d35mr3843883otb.181.1597461350344; 
 Fri, 14 Aug 2020 20:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-2-f4bug@amsat.org>
In-Reply-To: <20200814082841.27000-2-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 15 Aug 2020 11:15:14 +0800
Message-ID: <CAKXe6S+X0ALv9RFOHs+gzYeWX_u2x3qMA3Y+jiMxA+1Rm3cD3A@mail.gmail.com>
Subject: Re: [PATCH 1/7] block/null: Make more explicit the driver default
 size is 1GiB
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B48=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:29=E5=86=99=E9=81=93=
=EF=BC=9A
>
> As it is not obvious the default size for the null block driver
> is 1 GiB, replace the obfuscated '1 << 30' magic value by a
> definition using IEC binary prefixes.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  block/null.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/null.c b/block/null.c
> index 15e1d56746..8354def367 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
> @@ -21,6 +22,7 @@
>
>  #define NULL_OPT_LATENCY "latency-ns"
>  #define NULL_OPT_ZEROES  "read-zeroes"
> +#define NULL_OPT_SIZE    (1 * GiB)
>
>  typedef struct {
>      int64_t length;
> @@ -86,7 +88,7 @@ static int null_file_open(BlockDriverState *bs, QDict *=
options, int flags,
>      opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>      qemu_opts_absorb_qdict(opts, options, &error_abort);
>      s->length =3D
> -        qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 1 << 30);
> +        qemu_opt_get_size(opts, BLOCK_OPT_SIZE, NULL_OPT_SIZE);
>      s->latency_ns =3D
>          qemu_opt_get_number(opts, NULL_OPT_LATENCY, 0);
>      if (s->latency_ns < 0) {
> --
> 2.21.3
>
>

