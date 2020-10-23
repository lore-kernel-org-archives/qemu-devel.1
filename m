Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727FFC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C79208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx4zEgUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C79208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwKz-0003Ca-Nf
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwHr-0008Tj-9q; Fri, 23 Oct 2020 08:35:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwHm-0003H1-Kn; Fri, 23 Oct 2020 08:35:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id 126so710502pfu.4;
 Fri, 23 Oct 2020 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EbW4nnTc8husuNBIbJYp/5azynngGg6HcFeD2OchX8s=;
 b=Sx4zEgURVAj6cZKzVuKRUW8MMLPeKlkPgdtktoyCfOwAsoXZk8QwC1DulpzA33daFB
 cGS4JU+kStnHLHZPUB2EkEvOX/WIPM8zt2ThpSX1ElswVB0pDMj3971xsbdLgB3O8fTF
 mHyubVEI6wXAXLbIeGHFdizAQeEQKWreu/WPfNuL5TX+TYPl/pmdkcjh3OoH4YviMnQR
 cKNpt1iytmwdAXfF6wJrEenAzMirkY5tRtR5WckeNQ+1UwJL08S4KrCb5Iz4LE9Kxytb
 L3FgodwXuhXxwaLdOhK2ShsiIrUQWRO35uwBHCmwQmVa4F+jNJzSnzjWcZY5hXZIA73I
 7HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EbW4nnTc8husuNBIbJYp/5azynngGg6HcFeD2OchX8s=;
 b=T/BH0DdkPV8DcaVoi4/vj3f+BTK4bhs3cJTw/aWIXuVFQiTnHNSu/mV6oeO+in759h
 KfQIBona9fwkGg169f3MIe5gp+ndLXPMywFxBZBwV/uv8N32L7/7ay6HxoF+XA3/Mrg/
 V7vRq/dYL+QaGtc6WNf31m0fVFc7jOU6FLM7Xg1WtrptDczcnmVL+jgTuBvCc2pbQ7RU
 n2l6qMiXkSxEMXLYC/wREi7sfHrJr5sMqWySVL+h8C2+Nzi/5KHZ6Uj+aZkeD9tAG8Af
 kNCF/3+qpZVxPihYMCghSC2HPICkhVjASEjI/P1/5HJGjL8N6RUsxXSH7mjKUiCQSsCw
 JihA==
X-Gm-Message-State: AOAM530P9/eI7QQ1JIbCCz5Obs5uB5L3O9yTMurH3YEDqPUG97a31O90
 yLBvy57vd6ocOPO0YVTAz9to5jD5kWlHqeQz
X-Google-Smtp-Source: ABdhPJxvItw5jGISKBzmmH/+N+wz3YZnvDeAHqvXofp/TMrOOP2A7KZfkI2n+ffccmMr10kRCbsUxA==
X-Received: by 2002:a63:481d:: with SMTP id v29mr1792935pga.448.1603456508131; 
 Fri, 23 Oct 2020 05:35:08 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id f7sm1981754pfd.111.2020.10.23.05.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:35:07 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 22/30] overall/alpha tcg cpus|hppa: Fix Lesser GPL version
 number
Date: Fri, 23 Oct 2020 12:33:53 +0000
Message-Id: <20201023123353.19796-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x443.google.com
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
Cc: Chetan Pant <chetan4windows@gmail.com>, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 cpus-common.c             | 2 +-
 include/exec/cpu-all.h    | 2 +-
 include/exec/cpu-defs.h   | 2 +-
 include/exec/cpu_ldst.h   | 2 +-
 include/exec/cputlb.h     | 2 +-
 include/exec/exec-all.h   | 2 +-
 include/exec/tb-hash.h    | 2 +-
 scripts/decodetree.py     | 2 +-
 target/alpha/cpu.h        | 2 +-
 target/alpha/fpu_helper.c | 2 +-
 target/alpha/gdbstub.c    | 2 +-
 target/alpha/helper.c     | 2 +-
 target/alpha/int_helper.c | 2 +-
 target/alpha/mem_helper.c | 2 +-
 target/alpha/sys_helper.c | 2 +-
 target/alpha/translate.c  | 2 +-
 target/alpha/vax_helper.c | 2 +-
 target/hppa/cpu.h         | 2 +-
 target/hppa/gdbstub.c     | 2 +-
 target/hppa/helper.c      | 2 +-
 target/hppa/insns.decode  | 2 +-
 target/hppa/int_helper.c  | 2 +-
 target/hppa/machine.c     | 2 +-
 target/hppa/mem_helper.c  | 2 +-
 target/hppa/op_helper.c   | 2 +-
 target/hppa/translate.c   | 2 +-
 26 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 83475ef..6e73d3e 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index f6439c4..1c92ab6 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9185632..d1f5e3f 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 30605ed..ef54cb7 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index a62cfb2..19b16e5 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 1fe28d5..5ebe5d4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 805235d..0a273d9 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 60fd3b5..157b1e8 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -4,7 +4,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index be29bdd..82df108 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index df8b589..3ff8bb4 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 0cd76dd..7db14f4 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 55d7274..4f56fe4 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
index e43b50a..5672696 100644
--- a/target/alpha/int_helper.c
+++ b/target/alpha/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 934faa1..75e72bc 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 3922923..25f6cb8 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 8870284..ba5bba7 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/vax_helper.c b/target/alpha/vax_helper.c
index 2b0c178..f94fb51 100644
--- a/target/alpha/vax_helper.c
+++ b/target/alpha/vax_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index fb6c59d..61178fa 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index a6428a2..729c37b 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 0dcd105..1ccff57 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index dceaad6..d4eefc0 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 462747b..349495d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 7030101..b60b654 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 5a465db..afc5b56 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 39361d3..7ae31e1 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f5765ef..64af1e0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
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


