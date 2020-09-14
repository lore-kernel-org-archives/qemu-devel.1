Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E8F20829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwDEg4+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E8F20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpRb-0003Ya-EE
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8U-00032k-IF
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:47058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8S-0007cN-FK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id o5so18849394wrn.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TR7g/XOXg0ArMBsKi4z4nvRcU8XcdUFb0nODVD4YAB4=;
 b=ZwDEg4+hNTjAifVjO7eYSDq1yDJLrkoWo1AtrHgD9am9baWQizQXw7awgF49y8ByOk
 krltMt4lcH7UzGFVcBWORBYCfq0Ru4hfuCQ94VrrKbHMXlevDoRuzbMRuGZcHzCVvyOT
 CcckQBuwepmN8dEkneJnOwL8JU/k536QpASufLhdU2rrOTomvhL+puC8hYgH9GWtunAi
 24VjlQjykn/j7aSagoIw87unPK48IAo/vFL+XLDshzMpx3AVgzmqlC9Lctcka6zZwhBi
 WWgyN2+e+4d4rYcgqk2nWrfZPlGiduiIDkael0IPmBN6zbUYnpRyLspyqajWAbKc7OOU
 /B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TR7g/XOXg0ArMBsKi4z4nvRcU8XcdUFb0nODVD4YAB4=;
 b=t/jc+PqliF9O/Pk9qZctDqUiQ7kGI2A0KlNOoR55WPAgfktkvWgfr/aCCyY9Ayo6KW
 kLZ8pd2WUn+rtDuuoahNXJSqw2Sl8HXC2OBV9ynqQLniM70Q3Wf/loneG0VaEasbgyR0
 28rV/vPjIGAKSpdZ3K75OYfse4xnrOwjcfeMKI2EDEChleWXdn5IHKUv0JOqdTF9XlVl
 H6NYUhrImr2lBtX7a5aW4kYSstzihqOsf6EOQ0eCK0qpRi0KjTmi0Rvc64zB4vyH/Nzr
 iQ1yi0xfO7J2GVcmc74L95qhBE/KV9WAXN8NfjIfqM++ZJ+owULE5p1ZvY5mzT0NGt2q
 lEkg==
X-Gm-Message-State: AOAM531lARjId+fP/USe9Wj3CGR+mCQ0ePhPAJ/pAEYNPsYMcB1yROQO
 57M8INCrNa1hsnP3EEGCkiSYyRj0MJaeYILG
X-Google-Smtp-Source: ABdhPJwsufMMBXBAG1oBEg2CV5wghODLlqaearNB6Y4JkDQaiaVT0Hs91fjgTb06t1tRuIJpJ3iogw==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr16807472wrp.187.1600092430743; 
 Mon, 14 Sep 2020 07:07:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/36] roms: Add virtual Boot ROM for NPCM7xx SoCs
Date: Mon, 14 Sep 2020 15:06:29 +0100
Message-Id: <20200914140641.21369-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Havard Skinnemoen <hskinnemoen@google.com>

This is a minimalistic boot ROM written specifically for use with QEMU.
It supports loading the second-stage loader from SPI flash into RAM, SMP
boot, and not much else.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200911052101.2602693-7-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitmodules                 |   3 +++
 MAINTAINERS                 |   2 ++
 pc-bios/README              |   6 ++++++
 pc-bios/meson.build         |   1 +
 pc-bios/npcm7xx_bootrom.bin | Bin 0 -> 768 bytes
 roms/Makefile               |   7 +++++++
 roms/vbootrom               |   1 +
 7 files changed, 20 insertions(+)
 create mode 100644 pc-bios/npcm7xx_bootrom.bin
 create mode 160000 roms/vbootrom

diff --git a/.gitmodules b/.gitmodules
index ce979398a87..9ffb9f3f4f3 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -61,3 +61,6 @@
 [submodule "meson"]
 	path = meson
 	url = https://github.com/mesonbuild/meson/
+[submodule "roms/vbootrom"]
+	path = roms/vbootrom
+	url = https://github.com/google/vbootrom.git
diff --git a/MAINTAINERS b/MAINTAINERS
index c95a00c12dd..3d17cad19aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -757,6 +757,8 @@ L: qemu-arm@nongnu.org
 S: Supported
 F: hw/*/npcm7xx*
 F: include/hw/*/npcm7xx*
+F: pc-bios/npcm7xx_bootrom.bin
+F: roms/vbootrom
 
 nSeries
 M: Andrzej Zaborowski <balrogg@gmail.com>
diff --git a/pc-bios/README b/pc-bios/README
index 2e49be607e0..33f9754ad30 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -71,3 +71,9 @@
   ("Simplified BSD License" or "FreeBSD License", SPDX: BSD-2-Clause). OpenSBI
   source code also contains code reused from other projects desribed here:
   https://github.com/riscv/opensbi/blob/master/ThirdPartyNotices.md.
+
+- npcm7xx_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for Nuvoton
+  NPCM7xx BMC devices. It currently implements the bare minimum to load, parse,
+  initialize and run boot images stored in SPI flash, but may grow more
+  features over time as needed. The source code is available at:
+  https://github.com/google/vbootrom
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 8087e5c0a7a..182d5ebb35d 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -81,6 +81,7 @@ blobs = files(
   'opensbi-riscv64-generic-fw_dynamic.bin',
   'opensbi-riscv32-generic-fw_dynamic.elf',
   'opensbi-riscv64-generic-fw_dynamic.elf',
+  'npcm7xx_bootrom.bin',
 )
 
 if install_blobs
diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
new file mode 100644
index 0000000000000000000000000000000000000000..38f89d1b97b0c2e133af2a9fbed0521be132065b
GIT binary patch
literal 768
zcmd5)JxClu6n-<aczPbVhZYusb8wKx;7TklHfmuZdYT9pDRLwd1p_t-DFpWpyA+8(
zwKtZg3J4a0aCM3_X(ZL&4g;46VVk5e$K;z;L99|b@aE%v^S$rQ8)h(Vm@cB9IYc+2
z2SHd4^NwTIGE%w>9S05p1#kf90Sj5Z(jG8}+)IZIp~iXK=T&)dL`%d-q*8aR#mq{7
z9`=6;Dr(H0ACe72R5x?!)^86Qj-X%{+!K9iZNA@*wkBAV&iZ(l^I9?!Gz=S2I_*1d
zr+tTQDHjvyzKnw(hu00yX`u!Fv<!~XVcX?@kr#<B0(gGU?$W{gSsQa}CF^8Cfzp2X
z@P}yDV-bci(K9XL$FU!som2C`c)?Uc&294s^}Wzumap{hg1X^jN|V25M5tQZ=<9lN
z%(zKz#t-qCwHKb;HygOCpvCNL_4@1tXV1YGf^XUE_$zr{g8zWh-6gz-teI(eibtxo
z?0OZI4%rU0741PgUD`2xq@H|*4=+Rs?%N)Ox5G+q>C;DilBe_YlkeSUVHA-crNk+k
jtiF_MudA<CB(}8|fqYwCf3re&=&@_s761P#-ID$TwgmBa

literal 0
HcmV?d00001

diff --git a/roms/Makefile b/roms/Makefile
index d3a32283591..3726f06fe7e 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -34,6 +34,7 @@ find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld
 # finally strip off path + toolname so we get the prefix
 find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
 
+arm_cross_prefix := $(call find-cross-prefix,arm)
 powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
 powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
 x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
@@ -63,6 +64,7 @@ default help:
 	@echo "  skiboot            -- update skiboot.lid"
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
+	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
 	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
 	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
@@ -185,6 +187,10 @@ bios-microvm:
 	$(MAKE) -C qboot
 	cp qboot/bios.bin ../pc-bios/bios-microvm.bin
 
+npcm7xx_bootrom:
+	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
+	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C sgabios clean
@@ -198,3 +204,4 @@ clean:
 	$(MAKE) -f Makefile.edk2 clean
 	$(MAKE) -C opensbi clean
 	$(MAKE) -C qboot clean
+	$(MAKE) -C vbootrom clean
diff --git a/roms/vbootrom b/roms/vbootrom
new file mode 160000
index 00000000000..0c37a43527f
--- /dev/null
+++ b/roms/vbootrom
@@ -0,0 +1 @@
+Subproject commit 0c37a43527f0ee2b9584e7fb2fdc805e902635ac
-- 
2.20.1


