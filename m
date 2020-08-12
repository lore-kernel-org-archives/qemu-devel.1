Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB95520781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZemO2lLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB95520781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zXZ-0005Zr-2Z
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQZ-0002Q6-Li
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQW-0005mK-7H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272056; x=1628808056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VvjsleFZqisVB4685AuqOjnASi/Ep7JRd4WeJhekExw=;
 b=ZemO2lLVdvuuRQA+f/9WdG9vCEelEu6LsQa/9VDwBIefACZKVn7BK05r
 85Sj/J4C16AhEAhdK3zDQ1ONTLKnW99ALfdH/KVBNm0A0rSY/o9svizaq
 v1STTbodHab45ChhsplSWu0kmnPB6pKky++NF+PkpRnrf3qceFGb3my6z
 NSxN/DS8sFIPWPaj2VfhT3UYa/hbaLcB7lvdiYRENl7bZ/ljkfr5wRi3B
 SuNvxBGhl62QWYG3cZiDrNmsz/yB1AnapFb4WXr9yn7205RI9++hkG+ZC
 SW5ff7GtI1XaQhxjhjETDS02P2IOrgS9WMhLZUXWNRUPRe/XPSTLiBH9W w==;
IronPort-SDR: gkEILbBpaSvI28E2LiMmtzTqbfwvkRUpZidOW9Ed4y0jKRYqpgzO4gECdyGI30exBNHKrRI0bK
 sGHJjxg/JmGKpuTRVtO1Ifo1dvTWWjLIdq2ceSkDmdqxHpevsx1HeWPejF3ckgIK7G0+U7BDdg
 Ta4GSU7wyUPEp7dR7gnpVyuA3Alv0rgs7jgG4niOppjoL9Bja3VHC67iqIO1C0zN6nCaG6pVm+
 0nTldCn4ZmVjZ0sBKVIHyJ0z3Ew9p1M6J5gDi1OhEpf+9vodyPc2XAvxIepVSnrb3FGC/9WHcu
 Uhg=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144853397"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:50 +0800
IronPort-SDR: qJMojfGiJg7NGw2qohjDDk7YrhnxGCiofsxfrnGnR4K6nNHDdbVfeGJgNkt7sXgRdP9bAH3iUd
 V5QQxv59HhDw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:41 -0700
IronPort-SDR: SxIZrDgRoo8s4AWhbBB/xoKjygjhXbGcHhMdXkvh92iK5c7v+uhNNr/p3rRG7fq0fGmvIJytUX
 PCYu+btlbVeQ==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] roms/Makefile: Build the generic platform for RISC-V
 OpenSBI firmware
Date: Wed, 12 Aug 2020 15:30:37 -0700
Message-Id: <20200812223045.96803-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

The RISC-V generic platform is a flattened device tree (FDT) based
platform where all platform specific functionality is provided based
on FDT passed by previous booting stage. The support was added in
the upstream OpenSBI v0.8 release recently.

Update our Makefile to build the generic platform instead of building
virt and sifive_u separately for RISC-V OpenSBI firmware, and change
to use fw_dynamic type images as well.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1596439832-29238-4-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 roms/Makefile | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index f9acf39954..5d9f15b677 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -64,10 +64,8 @@ default help:
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
-	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
-	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
-	@echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
-	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
+	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
+	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
 	@echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
 	@echo "  clean              -- delete the files generated by the previous" \
 	                              "build targets"
@@ -170,29 +168,19 @@ skiboot:
 efi: edk2-basetools
 	$(MAKE) -f Makefile.edk2
 
-opensbi32-virt:
+opensbi32-generic:
 	$(MAKE) -C opensbi \
 		CROSS_COMPILE=$(riscv32_cross_prefix) \
-		PLATFORM="qemu/virt"
-	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
+		PLATFORM="generic"
+	cp opensbi/build/platform/generic/firmware/fw_dynamic.bin ../pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
+	cp opensbi/build/platform/generic/firmware/fw_dynamic.elf ../pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
 
-opensbi64-virt:
+opensbi64-generic:
 	$(MAKE) -C opensbi \
 		CROSS_COMPILE=$(riscv64_cross_prefix) \
-		PLATFORM="qemu/virt"
-	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
-
-opensbi32-sifive_u:
-	$(MAKE) -C opensbi \
-		CROSS_COMPILE=$(riscv32_cross_prefix) \
-		PLATFORM="sifive/fu540"
-	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
-
-opensbi64-sifive_u:
-	$(MAKE) -C opensbi \
-		CROSS_COMPILE=$(riscv64_cross_prefix) \
-		PLATFORM="sifive/fu540"
-	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
+		PLATFORM="generic"
+	cp opensbi/build/platform/generic/firmware/fw_dynamic.bin ../pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
+	cp opensbi/build/platform/generic/firmware/fw_dynamic.elf ../pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
 
 bios-microvm:
 	$(MAKE) -C qboot
-- 
2.27.0


