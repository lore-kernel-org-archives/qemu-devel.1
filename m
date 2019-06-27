Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C81DC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5B9205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5B9205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSuv-0003w5-0g
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37226)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hgSqR-0008RH-Qu
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hgSqN-0002Hp-Fv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:45:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2252 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jonathan.cameron@huawei.com>)
 id 1hgSqJ-00024O-Da; Thu, 27 Jun 2019 07:45:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D6681E3C38229B7D357A;
 Thu, 27 Jun 2019 19:45:17 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 27 Jun 2019
 19:45:11 +0800
Date: Thu, 27 Jun 2019 12:45:02 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20190627124502.0000681e@huawei.com>
In-Reply-To: <c010cba5f307352f3f2b699231286d54d0e029df.1561414240.git.alistair.francis@wdc.com>
References: <cover.1561414240.git.alistair.francis@wdc.com>
 <c010cba5f307352f3f2b699231286d54d0e029df.1561414240.git.alistair.francis@wdc.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: Re: [Qemu-devel] [PATCH v1 4/5] roms: Add OpenSBI version 0.3
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
Cc: alistair23@gmail.com, palmer@sifive.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 15:11:57 -0700
Alistair Francis <alistair.francis@wdc.com> wrote:

> Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Hi Alistair,

Looks like a cut and paste buglet in the Makefile for the roms.

Jonathan

> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 078d3fb705..562ed726fd 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -37,6 +37,8 @@ find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
>  powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
>  powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
>  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> +riscv32_cross_prefix := $(call find-cross-prefix,riscv32)
> +riscv64_cross_prefix := $(call find-cross-prefix,riscv64)
>  
>  # tag our seabios builds
>  SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
> @@ -52,18 +54,21 @@ EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
>  default:
>  	@echo "nothing is build by default"
>  	@echo "available build targets:"
> -	@echo "  bios           -- update bios.bin (seabios)"
> -	@echo "  vgabios        -- update vgabios binaries (seabios)"
> -	@echo "  sgabios        -- update sgabios binaries"
> -	@echo "  pxerom         -- update nic roms (bios only)"
> -	@echo "  efirom         -- update nic roms (bios+efi)"
> -	@echo "  slof           -- update slof.bin"
> -	@echo "  skiboot        -- update skiboot.lid"
> -	@echo "  u-boot.e500    -- update u-boot.e500"
> -	@echo "  u-boot.sam460  -- update u-boot.sam460"
> -	@echo "  efi            -- update UEFI (edk2) platform firmware"
> -	@echo "  clean          -- delete the files generated by the previous" \
> -	                          "build targets"
> +	@echo "  bios               -- update bios.bin (seabios)"
> +	@echo "  vgabios            -- update vgabios binaries (seabios)"
> +	@echo "  sgabios            -- update sgabios binaries"
> +	@echo "  pxerom             -- update nic roms (bios only)"
> +	@echo "  efirom             -- update nic roms (bios+efi)"
> +	@echo "  slof               -- update slof.bin"
> +	@echo "  skiboot            -- update skiboot.lid"
> +	@echo "  u-boot.e500        -- update u-boot.e500"
> +	@echo "  u-boot.sam460      -- update u-boot.sam460"
> +	@echo "  efi                -- update UEFI (edk2) platform firmware"
> +	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
> +	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> +	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> +	@echo "  clean              -- delete the files generated by the previous" \
> +	                              "build targets"
>  
>  bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
>  	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
> @@ -162,6 +167,24 @@ skiboot:
>  efi: edk2-basetools
>  	$(MAKE) -f Makefile.edk2
>  
> +opensbi32-virt:
> +	$(MAKE) -C opensbi \
> +		CROSS_COMPILE=$(riscv32_cross_prefix) \
> +		PLATFORM="qemu/virt"
> +	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
> +
> +opensbi64-virt:
> +	$(MAKE) -C opensbi \
> +		CROSS_COMPILE=$(riscv64_cross_prefix) \
> +		PLATFORM="qemu/virt"
> +	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
> +
> +opensbi64-virt:

Cut and paste bug, 
opensbi64-sifive_u

> +	$(MAKE) -C opensbi \
> +		CROSS_COMPILE=$(riscv64_cross_prefix) \
> +		PLATFORM="qemu/sifive_u"
> +	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> +
>  clean:
>  	rm -rf seabios/.config seabios/out seabios/builds
>  	$(MAKE) -C sgabios clean
> @@ -173,3 +196,4 @@ clean:
>  	$(MAKE) -C u-boot-sam460ex distclean
>  	$(MAKE) -C skiboot clean
>  	$(MAKE) -f Makefile.edk2 clean
> +	$(MAKE) -C opensbi clean
> diff --git a/roms/opensbi b/roms/opensbi
> new file mode 160000
> index 0000000000..ca20ac0cd4
> --- /dev/null
> +++ b/roms/opensbi
> @@ -0,0 +1 @@
> +Subproject commit ca20ac0cd4c099006d4eea4d9ac7bd7b58e2ae0f



