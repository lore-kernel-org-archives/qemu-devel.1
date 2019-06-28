Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD4C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B572083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uad2o0cM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B572083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguP5-0007Zl-Bp
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44497)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgu1K-0008BM-18
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgu19-0004GV-Le
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:46:34 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:43078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgu16-0004Cp-9E; Fri, 28 Jun 2019 12:46:29 -0400
Received: by mail-lj1-x241.google.com with SMTP id 16so6610067ljv.10;
 Fri, 28 Jun 2019 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lf7WOLdPUXHcz585kTad04mWr7d5k1f/cV/mp/ntXhA=;
 b=uad2o0cMm/v4uFExCn6GXCZ995RWWyRvMxl6iqxIvTXzKYe/qvhdarBojlmCUum6rW
 XySlyxCjKrPpetBffWG2f2H6bc94txIqTFgbBkD4d/Zs5oxjB5i+hPlanRRMSx/rTQ8F
 UImnsTwQZRHF61lu+XXJveu/lF5Zssg2Zl9Aic/LSGwBEDck7O01bcHKZLh4vSX1DdDr
 3jfQlCrwzxsJcnVNmSgIJDciRg7px29I2yKg9eu1U+wZ8JvYaFnp2BEGVL3bQRmtmcsc
 MrVJDm3FsV15tg9+lxIzs9x7fuKcY7+1ulikGwZomvNzBKqEWnZlo29h/BJYlOAlkqe2
 LDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lf7WOLdPUXHcz585kTad04mWr7d5k1f/cV/mp/ntXhA=;
 b=VuEnaOe+Nq5OpPyWwM/hRa9fiUOx/LZfrzBEnlo0FXxIY3u1y4nzU4RMl0tIxe/ghf
 afb2g5HvJefmlOUqf7S1dRrwtDR/v4wVRf0fYib1AJlWvYrlfqqHm+ANBC1ZC3dLhkT3
 ERPmKdHriOrZ2OtHcZ/WAl1Ie3NNbW38EKE0qNtqMBI6EcaA9OkksLeO/O6nXgXDHqrA
 NR2leAv4bSL1aiCr2tLDNLwiN0lAHvjm0c31IhHs2ecxBUNfmQ33zMzwbLMfIB+dBwtf
 4An4SE41kHPP9m9hdoLy+EntDDCf0fojf4Co1Qbqv9vLvApMCGoDz7Gv6ERPyY9O2nFP
 2vBw==
X-Gm-Message-State: APjAAAV4IIFGDSwpBcEuspJbsW+dwDkEDtPN+dHfafezezFBzG0g6ze9
 BJDq10FqknIK/7EHoDmoP4I8Hdr0/EziVgTfvPA=
X-Google-Smtp-Source: APXvYqwvWulw5oOGJ5qVLM6Ryye6q7t53F3cIdvQOqjTI3rsaABEBgkw1nQ4gRKKpCX9ZQNzsSDfSJpzspiORL+BVus=
X-Received: by 2002:a2e:5d5a:: with SMTP id r87mr6777381ljb.196.1561740384800; 
 Fri, 28 Jun 2019 09:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-20-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-20-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:43:20 -0700
Message-ID: <CAKmqyKPdRe5iXDEo6EXse4s5QZ59_dWCRV07qSCOPh9rVNW2Yg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v5 19/28] hw/block/pflash_cfi02: Extract
 pflash_regions_count()
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
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:54 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Extract the pflash_regions_count() function, the code will be
> easier to review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 1f096ec185..a0d3bd60dc 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -157,6 +157,11 @@ static void pflash_register_memory(PFlashCFI02 *pfl,=
 int rom_mode)
>      pfl->rom_mode =3D rom_mode;
>  }
>
> +static size_t pflash_regions_count(PFlashCFI02 *pfl)
> +{
> +    return pfl->cfi_table[0x2c];
> +}
> +
>  static void pflash_timer (void *opaque)
>  {
>      PFlashCFI02 *pfl =3D opaque;
> @@ -192,9 +197,8 @@ static uint64_t pflash_data_read(PFlashCFI02 *pfl, hw=
addr offset,
>  static uint32_t pflash_sector_len(PFlashCFI02 *pfl, hwaddr offset)
>  {
>      assert(offset < pfl->chip_len);
> -    int nb_regions =3D pfl->cfi_table[0x2C];
>      hwaddr addr =3D 0;
> -    for (int i =3D 0; i < nb_regions; ++i) {
> +    for (int i =3D 0; i < pflash_regions_count(pfl); ++i) {
>          uint64_t region_size =3D (uint64_t)pfl->nb_blocs[i] * pfl->secto=
r_len[i];
>          if (addr <=3D offset && offset < addr + region_size) {
>              return pfl->sector_len[i];
> --
> 2.20.1
>
>

