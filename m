Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D56EC47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6874320862
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fj+kjyic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6874320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGm4p-00049b-I0
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 11:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGm3t-0003U1-8Z
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGm3s-0007B5-5H
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:33:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGm3s-0007Ar-0Z
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:33:36 -0400
Received: by mail-ot1-x343.google.com with SMTP id m19so7744508otp.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zcDw5Wojp2disLArdDnJ1udwER4o7kyqmyFawSbiQBs=;
 b=fj+kjyick3KHHVb+Q8zUUt5HsAK9EKXv2H9suI83RB17sHRHhYjR6awi1dnlQnpizJ
 jDUv07cR8SVBnvpaUFgcGuTZMeiYslqRATtC9MdXZHN1UMxbes11Uf6ry7P4od5/LyHL
 9JkGJn7aURTGZ4KRiaQD2ppBpLENSTf+rRxfzmXDdaOKHGYIxj2lSUsPsovUHxJPGtzd
 uzwa2JMxYBorCJ82L4brfB5qTIB3R2hahm+6TNjE1FhMvg6dRCpEyi0RwQPuEUGKW7R9
 jqk0YL0cjfX5ujNTfVXLQd6vnXjv/zB1Yk4YtDH4Ds9J4njINIk4EJCKsW5Y9XeOLTWc
 FxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zcDw5Wojp2disLArdDnJ1udwER4o7kyqmyFawSbiQBs=;
 b=ahLWDPKZVfVN+wL4UR0xZk7nb4xizZdRzrRjCOWM5U7Igwst5CgeVmkc8BG7YdDun0
 wKIyK+GfjLu5klAASmEjsEHI59RSkI83oLV4lQWA8M8yS3yfRjLKQPmviFbbywVa3lX7
 +wfCI4Ep888kgq1snQY4KgTtFNFcNaDev9LsPSBqpgluTAtBjQ2r1MVRCAVfo7LEiGCm
 MaRsoRX2Ba+8VjtZSlxAusJVXIRczsrhdZQCcceQ6UBq9YDZ8AKN8lREZia9+Zl/1n5Z
 xZla1T1Ji/q/Urf40BiLgMaMePb2aWPjGQtUbTsYfemW+1RuOFy7DnDjco8WDL1Vdy5D
 1ePg==
X-Gm-Message-State: APjAAAVq3uz1qqLZB9i8WtExK4QImYSaFMigka++wDIpkpcisGY/zXiu
 GLchszsY5nX7FOKkFhrZATL1XmQIQB3tjm0SG8zkIA==
X-Google-Smtp-Source: APXvYqxgXoieFhc4b4sbELf5KJ0aT1aMofhxlPF6X+VnSuBNWfxZS1SBxbPZCBmLCT7ahJWn85StRnbC+vO4fJ4cv34=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr13929748ote.97.1570289615037; 
 Sat, 05 Oct 2019 08:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191005150311.16373-1-f4bug@amsat.org>
In-Reply-To: <20191005150311.16373-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Oct 2019 16:33:23 +0100
Message-ID: <CAFEAcA-ZaabfZpaMbAV1zSNqVqzQFCQaJJo3dru7TWcNL-AShQ@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/etraxfs_dma: Simplify using MemoryRegionOps::impl
 access_size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 5 Oct 2019 at 16:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> This device implementation is clearly restricted to 32-bit
> accesses. Set the MemoryRegionOps::impl min/max access_size
> fields to simplify the code, and remove the hw_error() call.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/dma/etraxfs_dma.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
>
> @@ -701,6 +680,10 @@ static const MemoryRegionOps dma_ops =3D {
>         .read =3D dma_read,
>         .write =3D dma_write,
>         .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
>         .valid =3D {
>                 .min_access_size =3D 1,
>                 .max_access_size =3D 4

Unless I've forgotten how the memory layer works, doesn't this
mean we'll now try to synthesize 1 and 2 byte accesses by
making 4 byte accesses ? Would it be better to just set the
.valid.min_access_size to 4 ?

(The indent on the change looks a bit suspect but that's
because the whole file is tab-indent.)

thanks
-- PMM

