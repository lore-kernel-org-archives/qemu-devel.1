Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2650DC4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E775520732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYW3zHJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E775520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j713m-0002Xa-4Y
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j712i-0001lf-8h
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j712h-0006N2-6K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:04:20 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j712g-0006I0-UU; Wed, 26 Feb 2020 13:04:19 -0500
Received: by mail-lf1-x144.google.com with SMTP id z5so2658403lfd.12;
 Wed, 26 Feb 2020 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qixnKNDx/RlczFUjx2kQ4GPdxbg9OO/em4zJMw/98xY=;
 b=WYW3zHJahNRFNx36YyFvX9VuUOmpfB0jWolHG541Oxf1+46H9eN5X1a5rm4tHXT2Jn
 3+zrNn22JuQpVPex/0u5RVUmVf/z7HC8BeSNxX60HZcfr4PNQtmF5eRDpr9bzB2Xm2Rj
 Mq10/UV/KQS8O6hskJc5IcJGcuJSVe1rzr9cgxLK5ea/PSTfmmCMletmP/HZk7mRGX1f
 8H2PYw3PgumRuBdMAIFmG1EeYNKY7nGCcqJBh3olb08N28ln1qxbqcoskVr+yQ2SX6+s
 4cCu4vVpvj3LgLtttSQk0CSptFEXws5kKydSOrK4Yf4zlrizgTiJcrzT3cyxJL75oB8c
 69dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qixnKNDx/RlczFUjx2kQ4GPdxbg9OO/em4zJMw/98xY=;
 b=OiFh3louYkLPZABc6GYk1+bDIG4+45zRqwRoiVUc2+sD2fAtenRlq6Vawv0NHqv55z
 al+wNPNvleNbNXDOi/66dVcHtP5e5Goe3HB2qJSmJsgJt7ni6J8w+9jkn4T8mCrdkLgv
 GA9vA+SoagUuiJJJJ3kt3mNMxRleI81Pu0u4wwNjtYTGDzwQUHZvB1qJfG8HMeSWFL3b
 ey6DKiGGzobdlWSIwva3tAtHkrGqUlpxwcVNErqJsrqwZ/3Uj3MSkdCe7KatHrm7j6Ic
 EvML13uHhg/XVHBP4+QYVvYPQ7CuxGjoraw6PvipHlN+O1x+7v271//Y6PHbsiel64Fo
 +cXg==
X-Gm-Message-State: APjAAAXb3qO/80SQ9tTF3g3qu9WR7Uo2/n2v7cYvCapK5i67JrmcWLid
 XX2XwONVpCuCH9+hVXJVTGbG9GheIlIdvpfPcCY=
X-Google-Smtp-Source: APXvYqyDanTj6CItMlrP64oyBagwZRXSbl/vGnd7PIN+4JPKOk9K3Vwq46hSueuBS/6BUAtFoatDpvloQJ8wbhsttn8=
X-Received: by 2002:ac2:5111:: with SMTP id q17mr1159513lfb.51.1582740257474; 
 Wed, 26 Feb 2020 10:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-10-kuhn.chenqun@huawei.com>
In-Reply-To: <20200226084647.20636-10-kuhn.chenqun@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 09:56:38 -0800
Message-ID: <CAKmqyKNLKkjxwEZaL88a1PY2ZMOF9oZQvOWzrMFyCUz84-bjbA@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] dma/xlnx-zdma: Remove redundant statement in
 zdma_write_dst()
To: kuhn.chenqun@huawei.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, zhang.zhanghailiang@huawei.com,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 12:52 AM <kuhn.chenqun@huawei.com> wrote:
>
> From: Chen Qun <kuhn.chenqun@huawei.com>
>
> Clang static code analyzer show warning:
> hw/dma/xlnx-zdma.c:399:13: warning: Value stored to 'dst_type' is never r=
ead
>             dst_type =3D FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR=
_WORD3,
>             ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> v1->v2: move the 'dst_type' declaration.(Base on Philippe's suggestion).
> ---
>  hw/dma/xlnx-zdma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 8fb83f5b07..eeacad59ce 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -373,7 +373,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, b=
ool type,
>  static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
>  {
>      uint32_t dst_size, dlen;
> -    bool dst_intr, dst_type;
> +    bool dst_intr;
>      unsigned int ptype =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POIN=
T_TYPE);
>      unsigned int rw_mode =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, MO=
DE);
>      unsigned int burst_type =3D ARRAY_FIELD_EX32(s->regs, ZDMA_CH_DATA_A=
TTR,
> @@ -387,17 +387,17 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *bu=
f, uint32_t len)
>      while (len) {
>          dst_size =3D FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WO=
RD2,
>                                SIZE);
> -        dst_type =3D FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WO=
RD3,
> -                              TYPE);
>          if (dst_size =3D=3D 0 && ptype =3D=3D PT_MEM) {
>              uint64_t next;
> +            bool dst_type =3D FIELD_EX32(s->dsc_dst.words[3],
> +                                       ZDMA_CH_DST_DSCR_WORD3,
> +                                       TYPE);
> +
>              next =3D zdma_update_descr_addr(s, dst_type,
>                                            R_ZDMA_CH_DST_CUR_DSCR_LSB);
>              zdma_load_descriptor(s, next, &s->dsc_dst);
>              dst_size =3D FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSC=
R_WORD2,
>                                    SIZE);
> -            dst_type =3D FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSC=
R_WORD3,
> -                                  TYPE);
>          }
>
>          /* Match what hardware does by ignoring the dst_size and only us=
ing
> --
> 2.23.0
>
>
>

