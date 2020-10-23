Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4C3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039FA21D43
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPjl3Svb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039FA21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwUU-0008Oo-Sh
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwRf-0004vK-Ut; Fri, 23 Oct 2020 08:45:25 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwRX-0004e2-JT; Fri, 23 Oct 2020 08:45:21 -0400
Received: by mail-pf1-x444.google.com with SMTP id e15so1159414pfh.6;
 Fri, 23 Oct 2020 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QTuMLsJlr5+H0zsiOIKBSr4VUdkA3oG0IG0F/NE6nyQ=;
 b=JPjl3SvbJcOioCXdxm9bOcYq3NFpaavsMGWkPB6RxIz7ljoyVQLj7n6KfK/PIAGlYA
 FijYMmPasZov+RYYHHznMnUKe/dSqGzcbWtKU4yXyBlt52HKLQPQ3hu9ohGFMjVRb3Pv
 2T38MiCrT0rXRx140tiw3GQDQ1Cr9CanZgAUjtyVmRANM4jGNs8c3WfgdH2eGD+EMEPH
 38TdJNIuXZGXAkqpoCj/2XH2Sn5kP3CK+txxqNLkbd1Zqjfr1pVYgIPU176FPZLfZDgB
 GV0LcwlVcgGUWfAUj8lmunIMTDFKNbNR5zU9Z6J7RXVM81bIfW/x5uLRjUXS9C33iKNQ
 CH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QTuMLsJlr5+H0zsiOIKBSr4VUdkA3oG0IG0F/NE6nyQ=;
 b=EIjMxCCCNXtCO6OYjv+lEqmRGM3l6hQz2BHvbXxkbVjXvfnBPP3wIhIye0O0QM8iI3
 uWe5mAhaXrl2/l/tmcwV3sBC9BxWdZosbaYr+i7gjPaZ40pLsW8o396u0WieVNOLL8zs
 22GCM3YhVTxn3Gbo1l2gce5Nic6WJcfNgoPIEV6jyoLC/fsXHeWtG8zc/zVmLTP5CBre
 srw8a4a1hZ1EnMrJh5DbGzNYm9pBLsJ9GBxopTnF1ONSc7zORTX2H+NXReEFiVw9PHyr
 51eKv35jz5qWmlU9pO6A8e/NPIqWyfHkmE47xnsfcMt7L9t8r/Xf0UjYT7xxZrobT0IQ
 0Guw==
X-Gm-Message-State: AOAM5318GCiGWDeckW6T8D54NhuEvHs7aMFhNBa3qwYt9hIc/kzXva6y
 FzBzX+W6j/ZYAuqG86Mjd6cWU9aGaboKBV3H
X-Google-Smtp-Source: ABdhPJzkgOJg4aoTmWYgS7wft071LSdWP1A2w2cArqb4d/9v2Sgqm0/f7NJDIdyocwlKC6NW49XhSg==
X-Received: by 2002:a63:eb08:: with SMTP id t8mr1923757pgh.8.1603457110010;
 Fri, 23 Oct 2020 05:45:10 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id n203sm2160259pfd.81.2020.10.23.05.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:45:09 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 30/30] nomaintainer: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:44:24 +0000
Message-Id: <20201023124424.20177-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x444.google.com
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
Cc: qemu-devel@nongnu.org, Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

This patch contains all the files, whose maintainer I could not get
from ‘get_maintainer.pl’ script.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 block/crypto.c                             | 2 +-
 block/crypto.h                             | 2 +-
 disas/lm32.c                               | 2 +-
 exec-vary.c                                | 2 +-
 exec.c                                     | 2 +-
 hw/acpi/core.c                             | 2 +-
 hw/acpi/hmat.c                             | 2 +-
 hw/acpi/hmat.h                             | 2 +-
 hw/acpi/ich9.c                             | 2 +-
 hw/acpi/pcihp.c                            | 2 +-
 hw/acpi/piix4.c                            | 2 +-
 hw/audio/milkymist-ac97.c                  | 2 +-
 hw/char/lm32_juart.c                       | 2 +-
 hw/char/lm32_uart.c                        | 2 +-
 hw/char/milkymist-uart.c                   | 2 +-
 hw/core/bus.c                              | 2 +-
 hw/core/platform-bus.c                     | 2 +-
 hw/core/qdev.c                             | 2 +-
 hw/core/sysbus.c                           | 2 +-
 hw/display/bcm2835_fb.c                    | 2 +-
 hw/display/milkymist-tmu2.c                | 2 +-
 hw/display/milkymist-vgafb.c               | 2 +-
 hw/display/milkymist-vgafb_template.h      | 2 +-
 hw/gpio/mpc8xxx.c                          | 2 +-
 hw/i2c/pm_smbus.c                          | 2 +-
 hw/ide/ahci.c                              | 2 +-
 hw/ide/ahci_internal.h                     | 2 +-
 hw/ide/ich.c                               | 2 +-
 hw/ide/qdev.c                              | 2 +-
 hw/input/milkymist-softusb.c               | 2 +-
 hw/intc/apic.c                             | 2 +-
 hw/intc/apic_common.c                      | 2 +-
 hw/intc/ioapic.c                           | 2 +-
 hw/intc/ioapic_common.c                    | 2 +-
 hw/intc/lm32_pic.c                         | 2 +-
 hw/isa/apm.c                               | 2 +-
 hw/isa/isa-bus.c                           | 2 +-
 hw/lm32/lm32_boards.c                      | 2 +-
 hw/lm32/lm32_hwsetup.h                     | 2 +-
 hw/lm32/milkymist.c                        | 2 +-
 hw/mem/nvdimm.c                            | 2 +-
 hw/mem/pc-dimm.c                           | 2 +-
 hw/misc/applesmc.c                         | 2 +-
 hw/misc/milkymist-hpdmc.c                  | 2 +-
 hw/misc/milkymist-pfpu.c                   | 2 +-
 hw/net/e1000.c                             | 2 +-
 hw/net/milkymist-minimac2.c                | 2 +-
 hw/pci-bridge/i82801b11.c                  | 2 +-
 hw/pci-host/designware.c                   | 2 +-
 hw/ppc/spapr_iommu.c                       | 2 +-
 hw/ppc/spapr_vio.c                         | 2 +-
 hw/scsi/megasas.c                          | 2 +-
 hw/scsi/mptconfig.c                        | 2 +-
 hw/scsi/mptendian.c                        | 2 +-
 hw/scsi/mptsas.c                           | 2 +-
 hw/sd/milkymist-memcard.c                  | 2 +-
 hw/timer/hpet.c                            | 2 +-
 hw/timer/lm32_timer.c                      | 2 +-
 hw/timer/milkymist-sysctl.c                | 2 +-
 hw/xen/xen_pvdev.c                         | 2 +-
 include/exec/ioport.h                      | 2 +-
 include/exec/memory_ldst.h.inc             | 2 +-
 include/exec/memory_ldst_cached.h.inc      | 2 +-
 include/exec/memory_ldst_phys.h.inc        | 2 +-
 include/exec/tb-context.h                  | 2 +-
 include/exec/user/thunk.h                  | 2 +-
 include/hw/acpi/acpi.h                     | 2 +-
 include/hw/acpi/ich9.h                     | 2 +-
 include/hw/acpi/pcihp.h                    | 2 +-
 include/hw/display/milkymist_tmu2.h        | 2 +-
 include/hw/i386/apic_internal.h            | 2 +-
 include/hw/i386/ioapic.h                   | 2 +-
 include/hw/i386/ioapic_internal.h          | 2 +-
 include/hw/ide/ahci.h                      | 2 +-
 include/hw/loader-fit.h                    | 2 +-
 include/hw/pci-host/designware.h           | 2 +-
 include/hw/pci-host/spapr.h                | 2 +-
 include/hw/platform-bus.h                  | 2 +-
 include/hw/ppc/spapr_vio.h                 | 2 +-
 include/qemu/base64.h                      | 2 +-
 include/qemu/buffer.h                      | 2 +-
 include/qemu/filemonitor.h                 | 2 +-
 memory_ldst.c.inc                          | 2 +-
 qdev-monitor.c                             | 2 +-
 scripts/analyze-migration.py               | 2 +-
 scripts/replay-dump.py                     | 2 +-
 target/lm32/cpu.h                          | 2 +-
 target/lm32/gdbstub.c                      | 2 +-
 target/lm32/helper.c                       | 2 +-
 target/lm32/translate.c                    | 2 +-
 target/tilegx/cpu.h                        | 2 +-
 tests/acceptance/pc_cpu_hotplug_props.py   | 2 +-
 tests/acceptance/x86_cpu_model_versions.py | 2 +-
 tests/io-channel-helpers.c                 | 2 +-
 tests/io-channel-helpers.h                 | 2 +-
 tests/migration/guestperf-batch.py         | 2 +-
 tests/migration/guestperf-plot.py          | 2 +-
 tests/migration/guestperf.py               | 2 +-
 tests/migration/guestperf/comparison.py    | 2 +-
 tests/migration/guestperf/engine.py        | 2 +-
 tests/migration/guestperf/hardware.py      | 2 +-
 tests/migration/guestperf/plot.py          | 2 +-
 tests/migration/guestperf/progress.py      | 2 +-
 tests/migration/guestperf/report.py        | 2 +-
 tests/migration/guestperf/scenario.py      | 2 +-
 tests/migration/guestperf/shell.py         | 2 +-
 tests/migration/guestperf/timings.py       | 2 +-
 tests/migration/stress.c                   | 2 +-
 tests/test-base64.c                        | 2 +-
 tests/test-bufferiszero.c                  | 2 +-
 tests/test-qgraph.c                        | 2 +-
 tests/test-uuid.c                          | 2 +-
 ui/x_keymap.c                              | 2 +-
 util/base64.c                              | 2 +-
 util/buffer.c                              | 2 +-
 util/filemonitor-inotify.c                 | 2 +-
 util/filemonitor-stub.c                    | 2 +-
 util/log.c                                 | 2 +-
 118 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 0807557..aef5a57 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/block/crypto.h b/block/crypto.h
index c72c3de..72e792c 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
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
diff --git a/exec-vary.c b/exec-vary.c
index ff905f2..a603b1b 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/exec.c b/exec.c
index 3f5deb3..268b10c 100644
--- a/exec.c
+++ b/exec.c
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
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 97feb29..e34f668 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 272c20f..46e6c22 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/exec/memory_ldst_cached.h.inc
index fd4bbb4..5565a08 100644
--- a/include/exec/memory_ldst_cached.h.inc
+++ b/include/exec/memory_ldst_cached.h.inc
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index 91f7297..b9dd53c 100644
--- a/include/exec/memory_ldst_phys.h.inc
+++ b/include/exec/memory_ldst_phys.h.inc
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index feb585e..ec4c13b 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index b281dfa..300a840 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index 4bef575..22b0b65 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 28a5318..54571c7 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 02f4665..dfd3758 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -10,7 +10,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/display/milkymist_tmu2.h b/include/hw/display/milkymist_tmu2.h
index e3394ff..fdce953 100644
--- a/include/hw/display/milkymist_tmu2.h
+++ b/include/hw/display/milkymist_tmu2.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index da38541..c175e7e 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/i386/ioapic.h b/include/hw/i386/ioapic.h
index 59fcb15..06bfaae 100644
--- a/include/hw/i386/ioapic.h
+++ b/include/hw/i386/ioapic.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_internal.h
index 0ac9e24..0f9002a 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index b1bdf64..210e5e7 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/loader-fit.h b/include/hw/loader-fit.h
index 0284c3e..0832e37 100644
--- a/include/hw/loader-fit.h
+++ b/include/hw/loader-fit.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index 79869c7..6d9b51a 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 04917f3..4f58f02 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index 1f3d1ce..44f30c5 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 356751e..4bea87f 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/qemu/base64.h b/include/qemu/base64.h
index 0a3c5c9..46a75fb 100644
--- a/include/qemu/base64.h
+++ b/include/qemu/base64.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/qemu/buffer.h b/include/qemu/buffer.h
index 3a909ae..d34d2c8 100644
--- a/include/qemu/buffer.h
+++ b/include/qemu/buffer.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/qemu/filemonitor.h b/include/qemu/filemonitor.h
index a41ceb0..8715d5c 100644
--- a/include/qemu/filemonitor.h
+++ b/include/qemu/filemonitor.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/memory_ldst.c.inc b/memory_ldst.c.inc
index c54aee4..9fac37e 100644
--- a/memory_ldst.c.inc
+++ b/memory_ldst.c.inc
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/qdev-monitor.c b/qdev-monitor.c
index e9b7228..62bf0fa 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index d70ec7d..d7177b2 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 4cbc1e4..3ba97a6 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -8,7 +8,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 01d408e..ea7c01c 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index b6fe12e..56f508a 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 1130fc8..7c52ae7 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index e583d52..030b232 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index c194c1a..7d8e44d 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/acceptance/pc_cpu_hotplug_props.py b/tests/acceptance/pc_cpu_hotplug_props.py
index 08b7e63..e49bf33 100644
--- a/tests/acceptance/pc_cpu_hotplug_props.py
+++ b/tests/acceptance/pc_cpu_hotplug_props.py
@@ -9,7 +9,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/x86_cpu_model_versions.py
index 01ff614..2b7461b 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -9,7 +9,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/io-channel-helpers.c b/tests/io-channel-helpers.c
index ab988ef..ff156ed 100644
--- a/tests/io-channel-helpers.c
+++ b/tests/io-channel-helpers.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/io-channel-helpers.h b/tests/io-channel-helpers.h
index bb2de6f..3d14043 100644
--- a/tests/io-channel-helpers.h
+++ b/tests/io-channel-helpers.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf-batch.py b/tests/migration/guestperf-batch.py
index f1e9009..ab6bdb9 100755
--- a/tests/migration/guestperf-batch.py
+++ b/tests/migration/guestperf-batch.py
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf-plot.py b/tests/migration/guestperf-plot.py
index 9071510..32977b4 100755
--- a/tests/migration/guestperf-plot.py
+++ b/tests/migration/guestperf-plot.py
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf.py b/tests/migration/guestperf.py
index ba1c4bc..e8cc127 100755
--- a/tests/migration/guestperf.py
+++ b/tests/migration/guestperf.py
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/comparison.py b/tests/migration/guestperf/comparison.py
index d0b7df9..ba2edbe 100644
--- a/tests/migration/guestperf/comparison.py
+++ b/tests/migration/guestperf/comparison.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index fd63c66..e2a214b 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/hardware.py b/tests/migration/guestperf/hardware.py
index a66c9dd..3145785 100644
--- a/tests/migration/guestperf/hardware.py
+++ b/tests/migration/guestperf/hardware.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/plot.py b/tests/migration/guestperf/plot.py
index 34cebd5..30b3f66 100644
--- a/tests/migration/guestperf/plot.py
+++ b/tests/migration/guestperf/plot.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/progress.py b/tests/migration/guestperf/progress.py
index 46d2157..ab1ee57 100644
--- a/tests/migration/guestperf/progress.py
+++ b/tests/migration/guestperf/progress.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/report.py b/tests/migration/guestperf/report.py
index 6a1f971..1efd40c 100644
--- a/tests/migration/guestperf/report.py
+++ b/tests/migration/guestperf/report.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/scenario.py b/tests/migration/guestperf/scenario.py
index 705c2e8..28ef36c 100644
--- a/tests/migration/guestperf/scenario.py
+++ b/tests/migration/guestperf/scenario.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
index 5bcc066..f838888 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/guestperf/timings.py b/tests/migration/guestperf/timings.py
index f94d809..2374010 100644
--- a/tests/migration/guestperf/timings.py
+++ b/tests/migration/guestperf/timings.py
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index 0c72a42..de45e8e 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-base64.c b/tests/test-base64.c
index a7f722c..3012d7b 100644
--- a/tests/test-base64.c
+++ b/tests/test-base64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-bufferiszero.c b/tests/test-bufferiszero.c
index 42d194c..e45fd31 100644
--- a/tests/test-bufferiszero.c
+++ b/tests/test-bufferiszero.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-qgraph.c b/tests/test-qgraph.c
index 267291c..ae2f7b2 100644
--- a/tests/test-qgraph.c
+++ b/tests/test-qgraph.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
+ * License version 2.1 as published by the Free Software Foundation.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-uuid.c b/tests/test-uuid.c
index 22b4b07..c111de5 100644
--- a/tests/test-uuid.c
+++ b/tests/test-uuid.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/ui/x_keymap.c b/ui/x_keymap.c
index 2bc0143..555086f 100644
--- a/ui/x_keymap.c
+++ b/ui/x_keymap.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2017 Red Hat, Inc
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU Lesser General Public License version 2 as
+ * it under the terms of the GNU Lesser General Public License version 2.1 as
  * published by the Free Software Foundation.
  */
 
diff --git a/util/base64.c b/util/base64.c
index 9d3c46c..811111a 100644
--- a/util/base64.c
+++ b/util/base64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/buffer.c b/util/buffer.c
index d8bb874..743eaa9 100644
--- a/util/buffer.c
+++ b/util/buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index b5f4b93..2c45f7f 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/filemonitor-stub.c b/util/filemonitor-stub.c
index 2c0e97e..93fef65 100644
--- a/util/filemonitor-stub.c
+++ b/util/filemonitor-stub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/util/log.c b/util/log.c
index 4b42306..2ee1500 100644
--- a/util/log.c
+++ b/util/log.c
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


