Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D81EC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C249F2085B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3H1Zze+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C249F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwG1-0005o2-JJ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwDO-0003v7-Sc; Fri, 23 Oct 2020 08:30:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwDG-0002lX-Ep; Fri, 23 Oct 2020 08:30:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id b26so1130915pff.3;
 Fri, 23 Oct 2020 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NRIZRi2MAM+swYkhfaLNGWMr36WjA4DgGmzubb5Bs+Y=;
 b=j3H1Zze+vdsCPe/0beZDhf94UM8a8bZ6IXNMZumPaaxkn7xxwRCMux96lLSeWGDrPm
 BmikDV/69aJGaw1op/AoFJfsR7pqOaAlQSGCeWQwvmRZnH/RXtpkLeQfgzU3dmCxHm98
 Jj9H3LT6vwR33tgswQsxS3UB92zEvp31Aathzvg2oBRKjrK9/L4oBVnNERMkWS1HhN/n
 hhcRxikqFST3Z9CEU87F5Som9NzdvdM8gyDA47TGyAjgoB9oXA2xpPeZiY8sYWSuQStK
 STiGOMJ6QbM05lRkgTNDHb8HVooaOHh7rY6XF66ZizyYcnzpT2yS7YFxiSmj5bgcc9ye
 ZbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NRIZRi2MAM+swYkhfaLNGWMr36WjA4DgGmzubb5Bs+Y=;
 b=if3/GvIyXquCAMRpYKfwqolnry1MhmAYQBq8vy3QtpBrDg0uon/tileYd3cLXJDQbA
 p1AlR4QMcSPUGCjDQj+LkWyTVKHppc56yGVHOZ0H7mQNiqh1qa6svrwgOCmIl/LYjAMi
 sAQwcez9RbNX8DhkgCx6HgTmLUOSFwjdXB0m3UUH3eNNWw8Q0t9xKnuSAdUT/i9yMqTF
 LMBFJc1muL2rJztIDdepRhAmBYyUnh1c3ZJsKDiX+klmswLXWgcKMkfZpE0vlWdExeLw
 n9JbpgI2A8W88V8vHBk35jS9IXSl2pRFBdZJxGAf1f+86QRWt8+9EM+FxHwhlyC0hOXd
 BL6g==
X-Gm-Message-State: AOAM533ft6LC+PkN9RMk2qI0lAMCyKUCcpuLwfQNxZM5L7n4MocZ+bEo
 HhlcYXo65n52nUsTg6UaNJH9VBvi6jGrX4bZ
X-Google-Smtp-Source: ABdhPJzYnn869m0iEPNEvgBFGSpoVewV7CCc0J6UC3nTFi1gS8uxj7GpkLB25rMA427UrfO1G38dYA==
X-Received: by 2002:a63:731e:: with SMTP id o30mr1857234pgc.179.1603456227716; 
 Fri, 23 Oct 2020 05:30:27 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id p188sm1845321pgp.65.2020.10.23.05.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:30:27 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 18/30] arm tcg cpus: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:29:13 +0000
Message-Id: <20201023122913.19561-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 hw/intc/arm_gicv2m.c            | 2 +-
 hw/intc/arm_gicv3_its_kvm.c     | 2 +-
 target/arm/a32-uncond.decode    | 2 +-
 target/arm/a32.decode           | 2 +-
 target/arm/arm_ldst.h           | 2 +-
 target/arm/cpu.h                | 2 +-
 target/arm/crypto_helper.c      | 2 +-
 target/arm/gdbstub.c            | 2 +-
 target/arm/gdbstub64.c          | 2 +-
 target/arm/helper-a64.c         | 2 +-
 target/arm/helper-a64.h         | 2 +-
 target/arm/helper-sve.h         | 2 +-
 target/arm/iwmmxt_helper.c      | 2 +-
 target/arm/neon-dp.decode       | 2 +-
 target/arm/neon-ls.decode       | 2 +-
 target/arm/neon-shared.decode   | 2 +-
 target/arm/op_helper.c          | 2 +-
 target/arm/pauth_helper.c       | 2 +-
 target/arm/sve.decode           | 2 +-
 target/arm/sve_helper.c         | 2 +-
 target/arm/t16.decode           | 2 +-
 target/arm/t32.decode           | 2 +-
 target/arm/translate-a64.c      | 2 +-
 target/arm/translate-a64.h      | 2 +-
 target/arm/translate-neon.c.inc | 2 +-
 target/arm/translate-sve.c      | 2 +-
 target/arm/translate-vfp.c.inc  | 2 +-
 target/arm/translate.c          | 2 +-
 target/arm/vec_helper.c         | 2 +-
 target/arm/vec_internal.h       | 2 +-
 target/arm/vfp-uncond.decode    | 2 +-
 target/arm/vfp.decode           | 2 +-
 32 files changed, 32 insertions(+), 32 deletions(-)

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
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 60ccfc5..2339de2 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 4dfd913..fcd8cd4 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index 45edb10..057160e 100644
--- a/target/arm/arm_ldst.h
+++ b/target/arm/arm_ldst.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6036f61..36205a9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index c76806d..28a84c2 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  */
 
 #include "qemu/osdep.h"
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ecfa88f..866595b 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 35d0b80..251539e 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 0308214..30b2ad1 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 5b0b699..7bd6aed 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4411c47..e4cadd2 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/iwmmxt_helper.c b/target/arm/iwmmxt_helper.c
index 24244d0..610b1b2 100644
--- a/target/arm/iwmmxt_helper.c
+++ b/target/arm/iwmmxt_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 51aa0f0..ec83f10 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
index c7b03a7..c17f501 100644
--- a/target/arm/neon-ls.decode
+++ b/target/arm/neon-ls.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index a9d0108..ca0c699 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b106521..b84d6d5 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 6dbab03..564c48f 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6425396..5c90603 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4758d46..5f037c3 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 43b9a26..646c749 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7069d82..06d16b3 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7188808..6cb8d5a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 2e0d16d..3668b67 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 4d1a292..0c6db4d 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e4cd6b6..bf1ce67 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 28e0dba..4a05312 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d34c1d3..0329648 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index a973454..86ad8b1 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vec_internal.h b/target/arm/vec_internal.h
index 00a8277..e3eb3e7 100644
--- a/target/arm/vec_internal.h
+++ b/target/arm/vec_internal.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 8891ab3..5c50447 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 51f143b..1300ba0 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


