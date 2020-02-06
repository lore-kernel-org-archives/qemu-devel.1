Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897D6C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516F521775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsAJgebZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516F521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpjV-0003SP-GH
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1izpim-0002qw-1x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1izpil-00072C-1Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:34:03 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1izpii-0006dO-O6; Thu, 06 Feb 2020 17:34:00 -0500
Received: by mail-lj1-x243.google.com with SMTP id d10so7893092ljl.9;
 Thu, 06 Feb 2020 14:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pbd862HwYW69wjnzYROXLhMI6hq2ouoRB9W0g4hsBRI=;
 b=CsAJgebZmEu/mNHsF8e/5fNG0yZu7sL//YZpct8RPeKqcd45+KW7cZgiHdaSGDJDPK
 9VtcjNkmkpjEo2615219aaSABTje2i8i4zUaiL1rHlqbt/XzsnyUdoUuxNxOB8H2uXrP
 Fhx1ICntNnmiP9PIn35+Eq6uS0jsF+XRm93Z/7NsJOUi5VDWRQg8/Y7LBz7RwRvEOlaS
 0r+x0wqVVqSKd97nRy3rUmoAQ3KlMa7Ui6FTiMh3nMfGWGOMtZ9Q4ZiNhYjctwB3d7ez
 NTsqeyhhIXbS/vMqpgbJDfRYb0UOPUCpr64X+FMl+Wc0fLEewgi7vcqN9dNsmhpFVu40
 RlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pbd862HwYW69wjnzYROXLhMI6hq2ouoRB9W0g4hsBRI=;
 b=HMl3PBIv2femK0fugRrZ5PxhpYQj6EIwtJBMYTjkWhNtCWU0VVtU72FyjItae2K+MH
 pwcfReHim8mgAJOj4ecRSVuTxltQxA0ZPXklgnKX/brSl14SCgODXXGelXoxx9+VKB83
 riyF+vvme8yjZ+UxcbE2rRR4MJcaAc/G5kylHnhxA7lXsBJlqehHPtllJi+G+E/XnraY
 0pZqj0qoArtQBTY2munD0v4+WTlM1M63ZvtX3kTR+F+XULcFaZ81+R/m2QLXZHEX4vyl
 HtvZZ3357MiRl1wjR68YwuhyiQakshOHsfbn3BcRfZUlJxB4Z5NzPLtprz32ErV4Da4C
 g9nQ==
X-Gm-Message-State: APjAAAW0xq90w4qQ1qNNfnRknyxLV1lWufJOQP2BStRFXOTWy9qn18/B
 1NXpZcvb+u90Za1+tcfWXLiCFAcUYInSHOVhaqk=
X-Google-Smtp-Source: APXvYqzNOnCtThM5RPqcNfN/iqgNxlDvPpp0/hsMZe3+dYi37F19IaVqr6Jx25nfJv2L9EtX0IgtZTRHMvEyXSZDSvI=
X-Received: by 2002:a2e:8119:: with SMTP id d25mr3437488ljg.76.1581028439077; 
 Thu, 06 Feb 2020 14:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20200206183219.3756-1-linux@roeck-us.net>
 <20200206183219.3756-2-linux@roeck-us.net>
In-Reply-To: <20200206183219.3756-2-linux@roeck-us.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Feb 2020 14:26:46 -0800
Message-ID: <CAKmqyKMNwoTv15J94sm7-DyYXct1j5r6GM8Mqz_t=BcZ1jn0KA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] m25p80: Improve command handling for Jedec commands
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 6, 2020 at 10:33 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> When requesting JEDEC data using the JEDEC_READ command, the Linux kernel
> always requests 6 bytes. The current implementation only returns three
> bytes, and interprets the remaining three bytes as new commands.
> While this does not matter most of the time, it is at the very least
> confusing. To avoid the problem, always report up to 6 bytes of JEDEC
> data. Fill remaining data with 0.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2: Split patch into two parts; improved decription
>
>  hw/block/m25p80.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 5ff8d270c4..53bf63856f 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>          for (i = 0; i < s->pi->id_len; i++) {
>              s->data[i] = s->pi->id[i];
>          }
> +        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
> +            s->data[i] = 0;
> +        }
>
> -        s->len = s->pi->id_len;
> +        s->len = SPI_NOR_MAX_ID_LEN;
>          s->pos = 0;
>          s->state = STATE_READING_DATA;
>          break;
> --
> 2.17.1
>
>

