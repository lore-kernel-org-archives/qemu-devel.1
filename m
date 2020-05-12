Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00236C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE08720673
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMLDC0up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE08720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWSB-0008TL-PE
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jYWQs-0006VV-Eg; Tue, 12 May 2020 11:02:58 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jYWQr-00023j-DD; Tue, 12 May 2020 11:02:58 -0400
Received: by mail-io1-xd42.google.com with SMTP id k6so14271082iob.3;
 Tue, 12 May 2020 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CfDQNyiETGNBtCmjx4EXW+SurAQLFwlDq8FpjGI7evc=;
 b=hMLDC0uprZy4vUP6itTSCJrfzbKBDjKuk6O57DtoA2KLdzvpZezKkQwB7u5WuYy81G
 bw/kxCNMKHo4cEGrHVkQkOIZlBsn2puIS8njmxzF+TPbHYou8PeL5RYEr8FCrl11b3x6
 XymvI6OKPFBdY8DyRpqhn0D1okvkRuglbIGzNdnoI+XpR6N4SQ01PV0Qzc9IGtWrlpjA
 Rd50yS3z6yIPYSDJ+A6gw+edLxv0UCkJxtOQ12ir9PZmqqgl8dnSCoPPU2GwReAWydKg
 ArEPPZEmTOxtn76WZu6pMkTz/nW6QaBMK+/gYY9jndXTPcI41unpnO28U/HwBPzNTJL1
 Bqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CfDQNyiETGNBtCmjx4EXW+SurAQLFwlDq8FpjGI7evc=;
 b=cBwR9x1jBvDLlfyyMguH3F4lmHozDMoJWNLyT5+2n64lHsgZwIXbM4T6z4+rfiwig8
 ZDWLAEeHyZfFpwwlV2ywoRRkWuuxOJ6j4EJ8AqZ0WwWtXql4Q0KKm1uW7+py3cYNGcbh
 nsvSdYGw+X5KW9ve48evQY0XERsiTxUWnQ9CSgB+w/7ouJQwFZ7GDDtGSYN37Moxhv3w
 GLLkI6/nOEmX5aiixEpI2xWxPoWP9v9Yly6eSugE/1Co/jLd/9r1Ynmikol+B+/U2+Sq
 5GAw81PYHdtleZsAVm7gF9FuI4I3O2pQO1TYm/K4X0R29M9LJH5klKspWcBROb4HDITM
 G3gw==
X-Gm-Message-State: AGi0PuYOx/4RA6zsVQ5Thdi/pTJpX2bqsk3ul5X2uwpoofA7ZKRiHR/q
 QibsldMRynyy2ql3LtjbWWAJvL9zN21d8gjCr5w=
X-Google-Smtp-Source: APiQypLoSNWK+kYjVmQwJn8gYtSeeFI1GgCQDngSgP0mGsh452kuplj23NK56Sx1OEkqzfpVxsGz8ahxGMGUpshN1E4=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr21396125iol.105.1589295774659; 
 Tue, 12 May 2020 08:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200511205246.24621-1-philmd@redhat.com>
In-Reply-To: <20200511205246.24621-1-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 12 May 2020 07:54:08 -0700
Message-ID: <CAKmqyKNoMtXp5ApsA3GVsjWbg5R1-Yz3MvdDWTbq4c7j9ivd=A@mail.gmail.com>
Subject: Re: [PATCH] hw: Use QEMU_IS_ALIGNED() on parallel flash block size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <rth@twiddle.net>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 1:54 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Use the QEMU_IS_ALIGNED() macro to verify the flash block size
> is properly aligned. It is quicker to process when reviewing.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/sbsa-ref.c       | 2 +-
>  hw/arm/virt.c           | 2 +-
>  hw/block/pflash_cfi01.c | 2 +-
>  hw/block/pflash_cfi02.c | 2 +-
>  hw/i386/pc_sysfw.c      | 2 +-
>  hw/riscv/virt.c         | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 8409ba853d..b379e4a76a 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -241,7 +241,7 @@ static void sbsa_flash_map1(PFlashCFI01 *flash,
>  {
>      DeviceState *dev =3D DEVICE(flash);
>
> -    assert(size % SBSA_FLASH_SECTOR_SIZE =3D=3D 0);
> +    assert(QEMU_IS_ALIGNED(size, SBSA_FLASH_SECTOR_SIZE));
>      assert(size / SBSA_FLASH_SECTOR_SIZE <=3D UINT32_MAX);
>      qdev_prop_set_uint32(dev, "num-blocks", size / SBSA_FLASH_SECTOR_SIZ=
E);
>      qdev_init_nofail(dev);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 634db0cfe9..0a99fddb3d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -978,7 +978,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
>  {
>      DeviceState *dev =3D DEVICE(flash);
>
> -    assert(size % VIRT_FLASH_SECTOR_SIZE =3D=3D 0);
> +    assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
>      assert(size / VIRT_FLASH_SECTOR_SIZE <=3D UINT32_MAX);
>      qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZ=
E);
>      qdev_init_nofail(dev);
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index f586bac269..11922c0f96 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -964,7 +964,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>      if (blk) {
>          qdev_prop_set_drive(dev, "drive", blk, &error_abort);
>      }
> -    assert(size % sector_len =3D=3D 0);
> +    assert(QEMU_IS_ALIGNED(size, sector_len));
>      qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
>      qdev_prop_set_uint64(dev, "sector-length", sector_len);
>      qdev_prop_set_uint8(dev, "width", bank_width);
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index c6b6f2d082..895f7daee3 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -1003,7 +1003,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
>      if (blk) {
>          qdev_prop_set_drive(dev, "drive", blk, &error_abort);
>      }
> -    assert(size % sector_len =3D=3D 0);
> +    assert(QEMU_IS_ALIGNED(size, sector_len));
>      qdev_prop_set_uint32(dev, "num-blocks", size / sector_len);
>      qdev_prop_set_uint32(dev, "sector-length", sector_len);
>      qdev_prop_set_uint8(dev, "width", width);
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index f5f3f466b0..fad41f0e73 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -168,7 +168,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
>                           blk_name(blk), strerror(-size));
>              exit(1);
>          }
> -        if (size =3D=3D 0 || size % FLASH_SECTOR_SIZE !=3D 0) {
> +        if (size =3D=3D 0 || !QEMU_IS_ALIGNED(size, FLASH_SECTOR_SIZE)) =
{
>              error_report("system firmware block device %s has invalid si=
ze "
>                           "%" PRId64,
>                           blk_name(blk), size);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index daae3ebdbb..71481d59c2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -112,7 +112,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
>  {
>      DeviceState *dev =3D DEVICE(flash);
>
> -    assert(size % VIRT_FLASH_SECTOR_SIZE =3D=3D 0);
> +    assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
>      assert(size / VIRT_FLASH_SECTOR_SIZE <=3D UINT32_MAX);
>      qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZ=
E);
>      qdev_init_nofail(dev);
> --
> 2.21.3
>
>

