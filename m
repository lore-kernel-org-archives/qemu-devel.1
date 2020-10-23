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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8336C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4733F207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw4rFfgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4733F207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwYo-0004mB-BH
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwQE-0002z1-VR; Fri, 23 Oct 2020 08:43:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:46944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwQC-0004V2-Ns; Fri, 23 Oct 2020 08:43:54 -0400
Received: by mail-pf1-x434.google.com with SMTP id y14so1130964pfp.13;
 Fri, 23 Oct 2020 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=N71JKzU24oBuhTcmBZ9xvzyy7si6JkxguZiAOyAYpEI=;
 b=cw4rFfgOpbOFP76c8Ivq+8AKS9jQZqCr3RhMU37wT3INkI5w1PdydrxbHFcEDEEUBQ
 B7pVJFQvPXJMEI+/N3bsC8UroroxcgSQ9+YhRjTCaoe+s22t1mMLJuG6gIFGkon6kvs5
 XEL6AAQS5xyoTvnXiRcBQHASoNbnA/2u0oj4TzO01gVYsVWOZHXyZ2/OfmZrISF5PBjq
 OCqSQlxLVtohKgNcuPZjf7Oy9TIgBCjyCgX5lBHaF6Pot36s9A6fPI9ndThaDahzax/Y
 q5o7z2UCxNq4BF1xQ7ZrYaobKQZ+9U9COm6S3kbNXAPUo7+GLqWficNLdLluRe7afem2
 EsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=N71JKzU24oBuhTcmBZ9xvzyy7si6JkxguZiAOyAYpEI=;
 b=mpF5iiBC181r3epiCOaN9+SkxVuEEcHn/RC+tIQ1VVWh8E7k8Fu4cQN7XVlkG3cGEP
 IrGUmRLEISa/gSq9odAwJFmzU1fmPdiG8QUVRdJzQr6/4cyH1fOxJH11DzwBQlbNo10e
 SCGde0pvcqOH3ifddVfe+KAtU3GcYh5MJRYjOeXRPEC1zfLbCJjfJzom5X4N1gUYaeJk
 xvD+g42VvcmH6cnXF7QISxYY2MEOzIWegUeDA4Rw7C3wxUKfnde7Ifs458RDPcl8px1r
 WWWvKj9oK9uNuGsogoAbw94KHwWNy7EC9rweCmruW4q4OTYiTvSFso4Ga696pk9y+km+
 IaOg==
X-Gm-Message-State: AOAM531ub9bz0BkPsK5iASWfrma6IzVx9hEg77QaVU5/bVJxcUdBtrxw
 e7vn8OBCFY6kG5wJhUhKYFcjiP0BZA+LLAUj
X-Google-Smtp-Source: ABdhPJyJrcHPNwQrf8471wpkOrP6HR9J4LT4NoOQWJ1Aw4D9qcUof5Tib1n3llAdesnz18ar98Ez1w==
X-Received: by 2002:a17:90a:6ba7:: with SMTP id
 w36mr2304916pjj.12.1603457030503; 
 Fri, 23 Oct 2020 05:43:50 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id w5sm2060155pgf.61.2020.10.23.05.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:43:49 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 29/30] sparc tcg cpus: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:42:35 +0000
Message-Id: <20201023124235.20130-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x434.google.com
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
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
 target/sparc/cc_helper.c    | 2 +-
 target/sparc/cpu.c          | 2 +-
 target/sparc/fop_helper.c   | 2 +-
 target/sparc/gdbstub.c      | 2 +-
 target/sparc/helper.c       | 2 +-
 target/sparc/int32_helper.c | 2 +-
 target/sparc/int64_helper.c | 2 +-
 target/sparc/ldst_helper.c  | 2 +-
 target/sparc/mmu_helper.c   | 2 +-
 target/sparc/translate.c    | 2 +-
 target/sparc/vis_helper.c   | 2 +-
 target/sparc/win_helper.c   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index a410a0b..7ad5b9b 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cf21efd..701e794 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index e6dd3fc..f54fa9b 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 78dc8dc..5d1e808 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 07d87ef..c7bcaa3 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 9a71e1a..e1c4f9f 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index f3e7f32..ba95bf2 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e91cfde..22327d7 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index afbfba7..a44473a 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1a4efd4..30c73f8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -7,7 +7,7 @@
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
-   version 2 of the License, or (at your option) any later version.
+   version 2.1 of the License, or (at your option) any later version.
 
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 8a9b763..f917e59 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 8290a21..5b57892 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
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


