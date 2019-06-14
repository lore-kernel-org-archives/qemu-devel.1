Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4CBC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 05:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7552220851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 05:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p13fkqLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7552220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48464 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbegX-0000Wa-3c
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 01:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41486)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbefg-00005h-LP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbeff-0007Wa-DW
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:22:40 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hbeff-0007WN-7v
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:22:39 -0400
Received: by mail-oi1-x242.google.com with SMTP id j184so1090770oih.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 22:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=UEM0DPq4VzLWOyLGqQ23BCNhq2v+l75aEg56200Rzfk=;
 b=p13fkqLDm88qaGvEgJoZl4afhk1viMzbrrS8qe509pRykODIKDCKGAB7r9Zrn4iixO
 iyCWAAMQE+f19pLWFBZgnLiBLz/elRTHUmZuFVf9D1gxwOAoW7XmpVBkoNpWCJeyLfDT
 PmMO9chkvyFDcyeJswBgtvSYPrQWR1eP1YOlvOozBXnY8EQd0Hn8+bzKNAyWoWXe0RRK
 5s3SC27ij8JnGcOhUaAIg1w4yBdu/0eoV19iNmLd+/vP0Ry/bm3R9qJYoK5fH3xZVkvQ
 /+x2fmgVgJ0vOX4VBlIT5k7vLmbahtNZ+CJPQsJg8CbRsO1tVH7i0NRG0C3IL9SAi0RE
 4mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=UEM0DPq4VzLWOyLGqQ23BCNhq2v+l75aEg56200Rzfk=;
 b=jRI3uqjoxnBjs7TAX4Af7EGc9VaQSJ5Zh3qWNbuC5wQx6E7nTk2YuXDoHUEFKvZHYC
 atL0P1v2r7RIn05l0w4tw4cu3wB5c8AIvuBF/uSOUL95N3la6kXHD944s9Rtq6WInXYC
 R3xPzWIVfEz8i3QBWdNFODpeHOtX3f+SYZYeEJAiKAj/UHTpP+W9hyVKTuCEx/DN1hhj
 cEcXpTlHBHDGPlFIyD4kmgLSjYhaY1TaFJX5sx2RWajHfOMZcjDrHpelDLJH5IumztNE
 XzGcTvGhEClX6PuZ9LesjLD5Fme8jbSOu9tb4R3zybWpEOgbJxUEi/pR7Y4QaCGzBZqw
 qJtw==
X-Gm-Message-State: APjAAAVItcGDF6DW3KWfAvan6A20hewD+maYIVnEM2T3Z1YRYCF8j8mx
 cizas0iMJveynS0YBOWKeZSyb2ApcVYGKuLtkSw=
X-Google-Smtp-Source: APXvYqxzlcSF0NpIpkH494ZWNyq4ucAyG2XpHjAw4y3bu4prDkUag7QPVC9irlWWClCXGvCtbQUrWyp+Do5B3ebDj4k=
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr668358oif.79.1560489758265; 
 Thu, 13 Jun 2019 22:22:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 22:22:37
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 22:22:37
 -0700 (PDT)
In-Reply-To: <20190613041619.32102-2-richard.henderson@linaro.org>
References: <20190613041619.32102-1-richard.henderson@linaro.org>
 <20190613041619.32102-2-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 14 Jun 2019 07:22:37 +0200
Message-ID: <CAL1e-=iHb5khAaQeV1za8SnW=9O8mP-xg=t2Eaw818Yc9zdPPw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/1] tcg: Fix typos in helper_gvec_sar{8, 32,
 64}v
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 13, 2019 6:16 AM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> The loop is written with scalars, not vectors.
> Use the correct type when incrementing.
>
> Fixes: 5ee5c14cacd
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

This is certainly not a case of =E2=80=9Ctypo=E2=80=9D (which would mean th=
at you
accidentally typed =E2=80=9Cvec8=E2=80=9D instead od =E2=80=9Cint8_t=E2=80=
=9D). So, change the title to
=E2=80=9Ctcg: Fix loop step in
helper_gvec_sar{8, 32, 64}v=E2=80=9D or similar.

>  accel/tcg/tcg-runtime-gvec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index 3b6052fe97..51cb29ca79 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -874,7 +874,7 @@ void HELPER(gvec_sar8v)(void *d, void *a, void *b,
uint32_t desc)
>      intptr_t oprsz =3D simd_oprsz(desc);
>      intptr_t i;
>
> -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec8)) {
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int8_t)) {
>          uint8_t sh =3D *(uint8_t *)(b + i) & 7;
>          *(int8_t *)(d + i) =3D *(int8_t *)(a + i) >> sh;
>      }
> @@ -898,7 +898,7 @@ void HELPER(gvec_sar32v)(void *d, void *a, void *b,
uint32_t desc)
>      intptr_t oprsz =3D simd_oprsz(desc);
>      intptr_t i;
>
> -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec32)) {
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int32_t)) {
>          uint8_t sh =3D *(uint32_t *)(b + i) & 31;
>          *(int32_t *)(d + i) =3D *(int32_t *)(a + i) >> sh;
>      }
> @@ -910,7 +910,7 @@ void HELPER(gvec_sar64v)(void *d, void *a, void *b,
uint32_t desc)
>      intptr_t oprsz =3D simd_oprsz(desc);
>      intptr_t i;
>
> -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int64_t)) {
>          uint8_t sh =3D *(uint64_t *)(b + i) & 63;
>          *(int64_t *)(d + i) =3D *(int64_t *)(a + i) >> sh;
>      }
> --
> 2.17.1
>
>
