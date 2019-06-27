Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F15C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782DB20659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782DB20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgX2k-0000OS-Mo
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHa-0003Dl-Fk
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHP-0008R2-MI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHK-0007VB-Rn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so1473467plb.12
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=/AbKC3W967glqX7fEHe6XFcDjjA19hTCDxxWC3KIo84=;
 b=hyggX91Bxba2Eq83vhqy+5sH5h4Q2tQ8GlOZYiD2hc8YCYvmMgos4eneSKF4sj2zbZ
 Sd0WB4RsSkpO3GzjQwDKcjPjbxjTzAU7Qvzv6836b2kZuQPmoNrZoVcwiq7lFU6JN3zp
 WRkocM2rZJCsPgPaZuiTEU/u4+v7G8hbraJPs5PFx48RF5QXE0UW+ZjLSMAnKqSOXNsY
 9866IBcBHtORF+xEIlwrvSK0dLvKb1RDGwbGBsts+Iwr5AbfHnStwRVWLIIltvn6heHT
 G0XsQrMvkBFXpZkj4AfUgVs9dVGZCcLzMG65hYKpqqB8iU8bUI8MKUSEtlN4emp1c3JM
 dbBw==
X-Gm-Message-State: APjAAAUqGsXCRqeKdDgF6TxAINcCsm7NdnHaMGGE3emmE73PHYcWwkln
 BipGca8bjFZ2PuLGOZDXulzA1w==
X-Google-Smtp-Source: APXvYqzA9pWj78wRoOiqDJ5lddtK0V+UXYRWaSZ2zUHPswaCA7Aanjltftk1nNbz+Tuaei9GxlpKCw==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr5267719plz.191.1561649084937; 
 Thu, 27 Jun 2019 08:24:44 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id t2sm2485179pgo.61.2019.06.27.08.24.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:44 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:20:10 -0700
Message-Id: <20190627152011.18686-34-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
Subject: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Add OpenSBI version 0.3 as a git submodule and as a prebult binary.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 .gitmodules                                  |   3 ++
 Makefile                                     |   5 +-
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 28848 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 28904 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 28904 bytes
 roms/Makefile                                |  48 ++++++++++++++-----
 roms/opensbi                                 |   1 +
 7 files changed, 44 insertions(+), 13 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
 create mode 160000 roms/opensbi

diff --git a/.gitmodules b/.gitmodules
index 2857eec76377..7a10e72e09cd 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -55,3 +55,6 @@
 [submodule "slirp"]
 	path = slirp
 	url = https://git.qemu.org/git/libslirp.git
+[submodule "roms/opensbi"]
+	path = roms/opensbi
+	url = https://github.com/riscv/opensbi.git
diff --git a/Makefile b/Makefile
index cfb18f152544..c74e5ba91402 100644
--- a/Makefile
+++ b/Makefile
@@ -761,7 +761,10 @@ palcode-clipper \
 u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
-hppa-firmware.img
+hppa-firmware.img \
+opensbi-riscv32-virt-fw_jump.bin \
+opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
+
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
 60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
new file mode 100644
index 0000000000000000000000000000000000000000..c3e2aaa5148930754d3f88dcc9c6efdb961774d8
GIT binary patch
literal 28848
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

literal 0
HcmV?d00001

diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
new file mode 100644
index 0000000000000000000000000000000000000000..530d53f3c84632f2170fe0ea0b4a29019153de65
GIT binary patch
literal 28904
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
Sm*0P*&^-!0qP%~95dGibo|Df2

literal 0
HcmV?d00001

diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
new file mode 100644
index 0000000000000000000000000000000000000000..e6c1986b72081ecf3607b2110628cf8214fa8f00
GIT binary patch
literal 28904
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
Y%Heh;{l6>W+X_9d&~wWBcZbmb0Xhc<(f|Me

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index 078d3fb70563..562ed726fd6b 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -37,6 +37,8 @@ find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
 powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
 powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
 x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
+riscv32_cross_prefix := $(call find-cross-prefix,riscv32)
+riscv64_cross_prefix := $(call find-cross-prefix,riscv64)
 
 # tag our seabios builds
 SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
@@ -52,18 +54,21 @@ EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
 default:
 	@echo "nothing is build by default"
 	@echo "available build targets:"
-	@echo "  bios           -- update bios.bin (seabios)"
-	@echo "  vgabios        -- update vgabios binaries (seabios)"
-	@echo "  sgabios        -- update sgabios binaries"
-	@echo "  pxerom         -- update nic roms (bios only)"
-	@echo "  efirom         -- update nic roms (bios+efi)"
-	@echo "  slof           -- update slof.bin"
-	@echo "  skiboot        -- update skiboot.lid"
-	@echo "  u-boot.e500    -- update u-boot.e500"
-	@echo "  u-boot.sam460  -- update u-boot.sam460"
-	@echo "  efi            -- update UEFI (edk2) platform firmware"
-	@echo "  clean          -- delete the files generated by the previous" \
-	                          "build targets"
+	@echo "  bios               -- update bios.bin (seabios)"
+	@echo "  vgabios            -- update vgabios binaries (seabios)"
+	@echo "  sgabios            -- update sgabios binaries"
+	@echo "  pxerom             -- update nic roms (bios only)"
+	@echo "  efirom             -- update nic roms (bios+efi)"
+	@echo "  slof               -- update slof.bin"
+	@echo "  skiboot            -- update skiboot.lid"
+	@echo "  u-boot.e500        -- update u-boot.e500"
+	@echo "  u-boot.sam460      -- update u-boot.sam460"
+	@echo "  efi                -- update UEFI (edk2) platform firmware"
+	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
+	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
+	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
+	@echo "  clean              -- delete the files generated by the previous" \
+	                              "build targets"
 
 bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
 	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
@@ -162,6 +167,24 @@ skiboot:
 efi: edk2-basetools
 	$(MAKE) -f Makefile.edk2
 
+opensbi32-virt:
+	$(MAKE) -C opensbi \
+		CROSS_COMPILE=$(riscv32_cross_prefix) \
+		PLATFORM="qemu/virt"
+	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
+
+opensbi64-virt:
+	$(MAKE) -C opensbi \
+		CROSS_COMPILE=$(riscv64_cross_prefix) \
+		PLATFORM="qemu/virt"
+	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
+
+opensbi64-virt:
+	$(MAKE) -C opensbi \
+		CROSS_COMPILE=$(riscv64_cross_prefix) \
+		PLATFORM="qemu/sifive_u"
+	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C sgabios clean
@@ -173,3 +196,4 @@ clean:
 	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
 	$(MAKE) -f Makefile.edk2 clean
+	$(MAKE) -C opensbi clean
diff --git a/roms/opensbi b/roms/opensbi
new file mode 160000
index 000000000000..ca20ac0cd4c0
--- /dev/null
+++ b/roms/opensbi
@@ -0,0 +1 @@
+Subproject commit ca20ac0cd4c099006d4eea4d9ac7bd7b58e2ae0f
-- 
2.21.0


