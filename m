Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F1FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB58222245
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqLGrKE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB58222245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmFC-0002Ad-In
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQm5R-0000qp-3w; Fri, 09 Oct 2020 02:41:05 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:32784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQm5K-0000mF-24; Fri, 09 Oct 2020 02:41:04 -0400
Received: by mail-pf1-x441.google.com with SMTP id q123so6043262pfb.0;
 Thu, 08 Oct 2020 23:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=kl4RldwHvqm7s5RNmcKmSdI5LkNKTJPHMG/4l3i2UMk=;
 b=WqLGrKE+PnCMi08bS+dr8P/oi6WwmJkgCUXtZO1ATzWKSTK78rpCUc+PpMWLLFWN24
 gUUL7JPhSJ5BPagd9e36BDN6ILR3+aLdZLo0BnIx5EA2Uqn6vmJjkTCTv+fmlJF3rqIw
 CiC2GiRV5M6yT27zXYXK5Zc9R+Byyh3nT1pN5qvXUqjSx5ooH2cLn1y+iDwSH6nCCrPG
 a0PUnNmA2RqlhBT0L9PKUqm0KB58U+yArgSxkFKKko7Yfn0q0QtrOArphIYkUOoCRTiB
 YXTb3LxghWXcYEjTdQXX14fiooAQVHlfZFdlqMTJ/FBiRcF68OSdJPJ5FJ/DjEjflbVU
 F7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kl4RldwHvqm7s5RNmcKmSdI5LkNKTJPHMG/4l3i2UMk=;
 b=PUE3qlwOuGj6H6/5U1kpFfdnhG5z648w8MTi5gRajQV8Aidtt/grlk9UX38BEgzT1f
 +LRRLra0V40zHbi1e7vGKy1UoupMadzu4wKYJ++Tg9Ccs7zkwxFcHN7u0wg8FnAWv7Ni
 lNxyBZ1VmUPf19XiP3FrWQf9+PEyPHnrku/R7eTPKkW2S5C1+goakOeA5cI814S7hK6n
 e6+VW6qH2ruJS93ilGlsEu5Xz1uBIutHqi1vkdHdXdh/XGiRn4hujYQXw9p8MJWRnPFB
 pJ+jptyXeslT06PT6J+aaDDRQyyidmfGJ31f6wP9l+1kRujtPw96mP46cK/bs7Pv28TM
 bTkg==
X-Gm-Message-State: AOAM530DiE/pWrhXOAkTpARKusa6YS9hGqoepu82fEmM+XCF2Iyi5LCc
 aLd+EMelCiNle6RhY8e5rNsGNCtUcG6y36AE
X-Google-Smtp-Source: ABdhPJxPjPWx4aUrrxUlP+Nl8M8czcxpPfb5Rgj7ifrOoqJ6lQ3294oixafDYiqhMvD+FNykaILgkQ==
X-Received: by 2002:aa7:86ce:0:b029:152:1702:d791 with SMTP id
 h14-20020aa786ce0000b02901521702d791mr10860549pfo.13.1602225653160; 
 Thu, 08 Oct 2020 23:40:53 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id y12sm9417051pga.53.2020.10.08.23.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 23:40:52 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 2/5] Fixing Lesser GPL version number [2/5]
Date: Fri,  9 Oct 2020 06:39:34 +0000
Message-Id: <20201009063934.2679-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License. It is
either "GPL version 2.0" or "Lesser GPL version 2.1". This patch replaces all
occurrences of "Lesser GPL version 2" with "Lesser GPL version 2.1" in comment section.
Also, It came to notice that some of the files that were edited for the change
were not following latest comment rules. For example using "//" to mark comment
instead of "/*". That is also fixed in this patch.

This patch is divided in 5 parts, directory wise, in order to make reviewing process easier.
Below listed are the parts of the patch, where asterisk denotes the part you are currently viewing.

	[ ] Files in authz/backends/block/linux-user/tests/migration directory (82 Files)
	[*] Files in hw/include/disas (100 files)
	[ ] Files inside target/ 'alpha,arm,cris,hppa,i386' (96 files)
	[ ] Files inside target/ 'lm32,microblaze,mips,ppc,rx,sparc,tilegx,tricore,xtensa' (63 files)
	[ ] Files in ui/util/include/scripts and QEMU root directory (76 Files)

Below is how the license version was corrected:

1. To find the number of file having "Lesser GPL version 2 ":
	grep -l Lesser $(grep -rl "version 2 " * ) > result.dat
   Total of 417 files were found (After manually exluding the files like COPYING and COPYING.LIB from the result)

2. To find the number of occurences of "version 2 " in the resulted files:
	egrep -c "version 2 " $(cat result.dat)
   410 files had "version 2" occurence 1 time (name of those files was saved in one_timers.dat)
   and in 7 files "version 2" occurences were multiple times.

3. Files having occurence exactly 1 time were corrected using below command:
	sed -i "s/version 2 /version 2.1 /g" $(cat one_timers.dat)
   For rest of 7 files, correction was done manually.

Note:
During validating this patch (2/5), It was noticed that "hw/i2c/mpc_i2c.c" file had below license text mentioned:
"You should have received a copy of the GNU Lesser General Public"
But the file was actually using "GNU General Public License, version 2 or later," which was confusing
so I've not included the that change in this patch. So in fact, only 99 files are changed in this patch.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 disas/lm32.c                          |  2 +-
 hw/acpi/core.c                        |  2 +-
 hw/acpi/hmat.c                        |  2 +-
 hw/acpi/hmat.h                        |  2 +-
 hw/acpi/ich9.c                        |  2 +-
 hw/acpi/nvdimm.c                      |  2 +-
 hw/acpi/pcihp.c                       |  2 +-
 hw/acpi/piix4.c                       |  2 +-
 hw/audio/milkymist-ac97.c             |  2 +-
 hw/block/pflash_cfi01.c               |  2 +-
 hw/block/pflash_cfi02.c               |  2 +-
 hw/char/lm32_juart.c                  |  2 +-
 hw/char/lm32_uart.c                   |  2 +-
 hw/char/milkymist-uart.c              |  2 +-
 hw/core/bus.c                         |  2 +-
 hw/core/loader-fit.c                  |  2 +-
 hw/core/platform-bus.c                |  2 +-
 hw/core/qdev.c                        |  2 +-
 hw/core/sysbus.c                      |  2 +-
 hw/display/bcm2835_fb.c               |  2 +-
 hw/display/milkymist-tmu2.c           |  2 +-
 hw/display/milkymist-vgafb.c          |  2 +-
 hw/display/milkymist-vgafb_template.h |  2 +-
 hw/gpio/mpc8xxx.c                     |  2 +-
 hw/i2c/pm_smbus.c                     |  2 +-
 hw/ide/ahci.c                         |  2 +-
 hw/ide/ahci_internal.h                |  2 +-
 hw/ide/ich.c                          |  2 +-
 hw/ide/qdev.c                         |  2 +-
 hw/input/milkymist-softusb.c          |  2 +-
 hw/intc/apic.c                        |  2 +-
 hw/intc/apic_common.c                 |  2 +-
 hw/intc/arm_gicv2m.c                  |  2 +-
 hw/intc/arm_gicv3_its_kvm.c           |  2 +-
 hw/intc/ioapic.c                      |  2 +-
 hw/intc/ioapic_common.c               |  2 +-
 hw/intc/lm32_pic.c                    |  2 +-
 hw/intc/xics_pnv.c                    |  2 +-
 hw/isa/apm.c                          |  2 +-
 hw/isa/i82378.c                       |  2 +-
 hw/isa/isa-bus.c                      |  2 +-
 hw/lm32/lm32_boards.c                 |  2 +-
 hw/lm32/lm32_hwsetup.h                |  2 +-
 hw/lm32/milkymist.c                   |  2 +-
 hw/mem/nvdimm.c                       |  2 +-
 hw/mem/pc-dimm.c                      |  2 +-
 hw/mips/boston.c                      |  2 +-
 hw/mips/cps.c                         |  2 +-
 hw/misc/applesmc.c                    |  2 +-
 hw/misc/milkymist-hpdmc.c             |  2 +-
 hw/misc/milkymist-pfpu.c              |  2 +-
 hw/misc/mips_cpc.c                    |  2 +-
 hw/misc/mips_itu.c                    |  2 +-
 hw/net/e1000.c                        |  2 +-
 hw/net/e1000e.c                       | 66 +++++++++++++--------------
 hw/net/e1000e_core.c                  | 66 +++++++++++++--------------
 hw/net/e1000e_core.h                  | 66 +++++++++++++--------------
 hw/net/e1000x_common.c                | 44 +++++++++---------
 hw/net/e1000x_common.h                | 44 +++++++++---------
 hw/net/milkymist-minimac2.c           |  2 +-
 hw/pci-bridge/i82801b11.c             |  2 +-
 hw/pci-host/designware.c              |  2 +-
 hw/pci-host/xilinx-pcie.c             |  2 +-
 hw/ppc/pnv.c                          |  2 +-
 hw/ppc/pnv_core.c                     |  2 +-
 hw/ppc/pnv_lpc.c                      |  2 +-
 hw/ppc/pnv_psi.c                      |  2 +-
 hw/ppc/pnv_xscom.c                    |  2 +-
 hw/ppc/ppce500_spin.c                 |  2 +-
 hw/ppc/spapr_iommu.c                  |  2 +-
 hw/ppc/spapr_vio.c                    |  2 +-
 hw/scsi/megasas.c                     |  2 +-
 hw/scsi/mptconfig.c                   |  2 +-
 hw/scsi/mptendian.c                   |  2 +-
 hw/scsi/mptsas.c                      |  2 +-
 hw/sd/milkymist-memcard.c             |  2 +-
 hw/timer/hpet.c                       |  2 +-
 hw/timer/lm32_timer.c                 |  2 +-
 hw/timer/milkymist-sysctl.c           |  2 +-
 hw/tpm/tpm_prop.h                     |  2 +-
 hw/tricore/tricore_testboard.c        |  2 +-
 hw/usb/hcd-ohci.c                     |  2 +-
 hw/usb/hcd-xhci-nec.c                 |  2 +-
 hw/usb/hcd-xhci-pci.c                 |  2 +-
 hw/usb/hcd-xhci-pci.h                 |  2 +-
 hw/usb/hcd-xhci.c                     |  2 +-
 hw/usb/hcd-xhci.h                     |  2 +-
 hw/xen/xen_pvdev.c                    |  2 +-
 io/channel-buffer.c                   |  2 +-
 io/channel-command.c                  |  2 +-
 io/channel-file.c                     |  2 +-
 io/channel-socket.c                   |  2 +-
 io/channel-tls.c                      |  2 +-
 io/channel-util.c                     |  2 +-
 io/channel-watch.c                    |  2 +-
 io/channel-websock.c                  |  2 +-
 io/channel.c                          |  2 +-
 io/dns-resolver.c                     |  2 +-
 io/task.c                             |  2 +-
 99 files changed, 237 insertions(+), 237 deletions(-)

diff --git a/disas/lm32.c b/disas/lm32.c
index c0ef816..4fbb124 100644
--- a/disas/lm32.c
+++ b/disas/lm32.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ade9158..b77b202 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 7c24bb5..37806f7 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -13,7 +13,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 437dbc6..e9031ca 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -13,7 +13,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 95cb0f9..5ff4e01 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -10,7 +10,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8f7cc16..e17734d 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -15,7 +15,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 32ae8b2..245bdd8 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -10,7 +10,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 894d357..842bc38 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 04b39f8..7d2e057 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f0fcd63..daae965 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index eb02fcc..1b3d94e 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index b97aacb..aced357 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 0e8b4e4..2f58e29 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 1e83dbc..a817c51 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 6b987b6..c547f8e 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index c465921..b7c7b3b 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 5037ca2..b8487b2 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 96772a1..69b882d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 68e8dc8..aaae8e2 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 986c994..2be77bd 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 64636db..02a28c8 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 6f2b11d..e2c587e 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/display/milkymist-vgafb_template.h b/hw/display/milkymist-vgafb_template.h
index 4883780..96137f9 100644
--- a/hw/display/milkymist-vgafb_template.h
+++ b/hw/display/milkymist-vgafb_template.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index e60c919..cb42acb 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 4728540..06e1e53 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -6,7 +6,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ee1d47f..71b0678 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index ac9bdea..7f32e87 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 51cd2f3..1007a51 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 27ff1f7..1086b7a 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 5acd7a6..d885c70 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index b6a05e5..1c8be40 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 81addd6..502e94e 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 596fa66..d564b85 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 4ee9875..057cb53 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index bca71b5..a3021a4 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 5538b5b..3cccfc1 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index 0c48a9c..991a90b 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index 35f3811..753c067 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2 of
+ * as published by the Free Software Foundation; either version 2.1 of
  * the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful, but
diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index bce266b..dfe9020 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -6,7 +6,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 8285b06..2a2ff05 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 10bb7ff..7820068 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index b842f74..b5d97dd 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
index de94de1..e6cd30a 100644
--- a/hw/lm32/lm32_hwsetup.h
+++ b/hw/lm32/lm32_hwsetup.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 9f8fe9f..9ef9488 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index e1574bc..03c2201 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index c303510..50a04dd 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1b3f69e..0e9c771 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 23c0f87..ea58d82 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index a4deb3e..1b9acaf 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index 5e26d90..09a3875 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 83491db..e4ee209 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 2f7b2c9..692c0db 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 3540985..1333995 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 83347cb..d7d05ae 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -13,7 +13,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index b6f1ae3..2beb150 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -1,37 +1,37 @@
 /*
-* QEMU INTEL 82574 GbE NIC emulation
-*
-* Software developer's manuals:
-* http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
-*
-* Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
-* Developed by Daynix Computing LTD (http://www.daynix.com)
-*
-* Authors:
-* Dmitry Fleytman <dmitry@daynix.com>
-* Leonid Bloch <leonid@daynix.com>
-* Yan Vugenfirer <yan@daynix.com>
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2008 Qumranet
-* Based on work done by:
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * QEMU INTEL 82574 GbE NIC emulation
+ *
+ * Software developer's manuals:
+ * http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
+ *
+ * Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ * Dmitry Fleytman <dmitry@daynix.com>
+ * Leonid Bloch <leonid@daynix.com>
+ * Yan Vugenfirer <yan@daynix.com>
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2008 Qumranet
+ * Based on work done by:
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index bcfd466..93f377a 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1,37 +1,37 @@
 /*
-* Core code for QEMU e1000e emulation
-*
-* Software developer's manuals:
-* http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
-*
-* Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
-* Developed by Daynix Computing LTD (http://www.daynix.com)
-*
-* Authors:
-* Dmitry Fleytman <dmitry@daynix.com>
-* Leonid Bloch <leonid@daynix.com>
-* Yan Vugenfirer <yan@daynix.com>
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2008 Qumranet
-* Based on work done by:
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * Core code for QEMU e1000e emulation
+ *
+ * Software developer's manuals:
+ * http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
+ *
+ * Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ * Dmitry Fleytman <dmitry@daynix.com>
+ * Leonid Bloch <leonid@daynix.com>
+ * Yan Vugenfirer <yan@daynix.com>
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2008 Qumranet
+ * Based on work done by:
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index aee32f7..b8f38c4 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -1,37 +1,37 @@
 /*
-* Core code for QEMU e1000e emulation
-*
-* Software developer's manuals:
-* http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
-*
-* Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
-* Developed by Daynix Computing LTD (http://www.daynix.com)
-*
-* Authors:
-* Dmitry Fleytman <dmitry@daynix.com>
-* Leonid Bloch <leonid@daynix.com>
-* Yan Vugenfirer <yan@daynix.com>
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2008 Qumranet
-* Based on work done by:
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * Core code for QEMU e1000e emulation
+ *
+ * Software developer's manuals:
+ * http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
+ *
+ * Copyright (c) 2015 Ravello Systems LTD (http://ravellosystems.com)
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ * Dmitry Fleytman <dmitry@daynix.com>
+ * Leonid Bloch <leonid@daynix.com>
+ * Yan Vugenfirer <yan@daynix.com>
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2008 Qumranet
+ * Based on work done by:
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #ifndef HW_NET_E1000E_CORE_H
 #define HW_NET_E1000E_CORE_H
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 717f9df..83ffb76 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -1,26 +1,26 @@
 /*
-* QEMU e1000(e) emulation - shared code
-*
-* Copyright (c) 2008 Qumranet
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * QEMU e1000(e) emulation - shared code
+ *
+ * Copyright (c) 2008 Qumranet
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 19c56f4..bc1ee75 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -1,26 +1,26 @@
 /*
-* QEMU e1000(e) emulation - shared code
-*
-* Copyright (c) 2008 Qumranet
-*
-* Based on work done by:
-* Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
-* Copyright (c) 2007 Dan Aloni
-* Copyright (c) 2004 Antony T Curtis
-*
-* This library is free software; you can redistribute it and/or
-* modify it under the terms of the GNU Lesser General Public
-* License as published by the Free Software Foundation; either
-* version 2 of the License, or (at your option) any later version.
-*
-* This library is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-* Lesser General Public License for more details.
-*
-* You should have received a copy of the GNU Lesser General Public
-* License along with this library; if not, see <http://www.gnu.org/licenses/>.
-*/
+ * QEMU e1000(e) emulation - shared code
+ *
+ * Copyright (c) 2008 Qumranet
+ *
+ * Based on work done by:
+ * Nir Peleg, Tutis Systems Ltd. for Qumranet Inc.
+ * Copyright (c) 2007 Dan Aloni
+ * Copyright (c) 2004 Antony T Curtis
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 
 #ifndef HW_NET_E1000X_COMMON_H
 #define HW_NET_E1000X_COMMON_H
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 78c20c9..5826944 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 2b39076..f28181e 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -30,7 +30,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 8492c18..f9fb97a 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 3b32142..38d5901 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6670967..79d322e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 4724ddf..bd2bf2e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2 of
+ * as published by the Free Software Foundation; either version 2.1 of
  * the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful, but
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 23f1e09..5903590 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 6a479ca..3e868c8 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index b681c72..e9ae156 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 25c9ce7..d57b199 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 0fecabc..0790239 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 731080d..32cdc36 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index e90c008..ebcbab3 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 3b2a857..19d01f3 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
index 313f40e..0d5abb4 100644
--- a/hw/scsi/mptendian.c
+++ b/hw/scsi/mptendian.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 135e7d9..f866165 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 8cde320..a1235aa 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 05fd86a..9520471 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index be87c65..eeaf0ad 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 950437b..9ecea63 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
index 85e1ae5..d19e40c 100644
--- a/hw/tpm/tpm_prop.h
+++ b/hw/tpm/tpm_prop.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 8ec2b5b..12ea149 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8b912e9..f8c64c8 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 2efa6fa..65fde63 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a6d746e..3920099 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -12,7 +12,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index aa2e890..c193f79 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5e8bed9..e68ae2a 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index f859a17..fbe9981 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index 43a336a..8ab4589 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 5402e0c..baa4e2b 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-command.c b/io/channel-command.c
index 368dd62..b2a9e27 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-file.c b/io/channel-file.c
index 2ed3b75..c4bf799 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-socket.c b/io/channel-socket.c
index e1b4667..de259f7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7ec8cef..388f019 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-util.c b/io/channel-util.c
index 423d798..848a7a4 100644
--- a/io/channel-util.c
+++ b/io/channel-util.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-watch.c b/io/channel-watch.c
index 8640d1c..0289b36 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 47a0e94..bb545fa 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel.c b/io/channel.c
index e4376eb..93d449d 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index b55d8cc..743a0ef 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/task.c b/io/task.c
index 53c0bed..451f26f 100644
--- a/io/task.c
+++ b/io/task.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


