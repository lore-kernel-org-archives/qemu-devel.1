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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C676C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086E721D43
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPncezgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086E721D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwHl-0007qn-Tc
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwBo-0002d4-Ii; Fri, 23 Oct 2020 08:29:00 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:32768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwBl-0002QF-Cq; Fri, 23 Oct 2020 08:29:00 -0400
Received: by mail-pg1-x52e.google.com with SMTP id l18so1145717pgg.0;
 Fri, 23 Oct 2020 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=I8TcJcetukylqtSiwaulLXqKDBZmUVsoTY3dwBK47u8=;
 b=gPncezgguCstemAzmqd5TMN4wj1M8vAjMEs55wAvHQSNFnZOiN8e3sjVwoZJt/NVy+
 YbukPkmNX2Pyd75ylnB4LceQ1Uv0mUgBmj/k0Fn3NkqHTy2bxRwh1wugPer5NstF5oDm
 aRVQbLmNHq4WQfuzKgk4/2RlWJI0oMvPFRJphdTbjiEesy8IgpQ0DAuVsVtV2eZhqvIr
 SqGNUyIgw/YX49WlCUuVkIOaqhaLkL0lITqKGkhFxaG8DOuT5RV7Yw4YwlVGOA/UPdWT
 emMktDBeQX6x5AAIgHZawrdgbXRQmJ1eZacavOFWcG17CC9QmvlVghI5KT1l6wrM3mGJ
 brDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=I8TcJcetukylqtSiwaulLXqKDBZmUVsoTY3dwBK47u8=;
 b=XdJ2GrB/mngXy5oaLPNTy2x9LrgV/x0e8q9NxJBHoE2AOJdgr3jJJgxZZHycmY0X5h
 E7NUEDhAZ8msS2Oa7bUk0lnYeXfguIB2CMw8Weumgp6R6hSrH9ZePRhubaIZNh72HfDx
 nCWV/4wQT3WDnNsZrUjsJyD/IbLoBac0eeMsk795qv6Rz25YSfVbJAAiK/gpxhvBoyBz
 vodHTnkBOz8vf9IKW3DdtgEjFkJp434vFyJpe251+cxS+kvR6uLaN1qR2s96uyz+BE50
 4O61AWAAXn8H1OXNq4mHvWck3Jb3AidQECcWAx0bqiPnPcuV0D7XfOK6sij653J9wQyD
 fc6w==
X-Gm-Message-State: AOAM5312hTi0zQhokKHth6ixB5atWdah8XGvDCLwsVd4r9A3jVkzjDTV
 yigH8TUhxGu01JFbmjgTRV4NZY87C08I/KdO
X-Google-Smtp-Source: ABdhPJzcRCPnk9zLi3vhY9aMAn8aOpXP+RTDD7VNTrN2JkK+vK6ykTcD07ZdRGuCF8b5ZqhOV2MVTw==
X-Received: by 2002:a17:90b:3798:: with SMTP id
 mz24mr2189004pjb.46.1603456134978; 
 Fri, 23 Oct 2020 05:28:54 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id q4sm1916868pgj.44.2020.10.23.05.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:28:54 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 17/30] x86 tcg cpus: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:28:01 +0000
Message-Id: <20201023122801.19514-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=chetan4windows@gmail.com; helo=mail-pg1-x52e.google.com
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
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
 target/i386/bpt_helper.c            | 2 +-
 target/i386/cc_helper.c             | 2 +-
 target/i386/cc_helper_template.h    | 2 +-
 target/i386/cpu.c                   | 2 +-
 target/i386/cpu.h                   | 2 +-
 target/i386/excp_helper.c           | 2 +-
 target/i386/fpu_helper.c            | 2 +-
 target/i386/gdbstub.c               | 2 +-
 target/i386/helper.c                | 2 +-
 target/i386/int_helper.c            | 2 +-
 target/i386/mem_helper.c            | 2 +-
 target/i386/misc_helper.c           | 2 +-
 target/i386/mpx_helper.c            | 2 +-
 target/i386/ops_sse.h               | 2 +-
 target/i386/ops_sse_header.h        | 2 +-
 target/i386/seg_helper.c            | 2 +-
 target/i386/shift_helper_template.h | 2 +-
 target/i386/smm_helper.c            | 2 +-
 target/i386/svm_helper.c            | 2 +-
 target/i386/tcg-stub.c              | 2 +-
 target/i386/translate.c             | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/i386/bpt_helper.c b/target/i386/bpt_helper.c
index c3a8ea7..e6cc292 100644
--- a/target/i386/bpt_helper.c
+++ b/target/i386/bpt_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cc_helper.c b/target/i386/cc_helper.c
index c9c90e1..924dd3c 100644
--- a/target/i386/cc_helper.c
+++ b/target/i386/cc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cc_helper_template.h b/target/i386/cc_helper_template.h
index 607311f..bb611fe 100644
--- a/target/i386/cc_helper_template.h
+++ b/target/i386/cc_helper_template.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ffd877..3ff1cdf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f519d2b..97f2b4b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index b10c7ec..1914717 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 4ea7387..03b3544 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 9ae43bd..4a3de5f 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e..d46999b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/int_helper.c b/target/i386/int_helper.c
index 334469c..4f89436 100644
--- a/target/i386/int_helper.c
+++ b/target/i386/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 3a6d3ae..21ca3e3 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index b6b1d41..ae259d9 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/mpx_helper.c b/target/i386/mpx_helper.c
index ade5d24..fd96617 100644
--- a/target/i386/mpx_helper.c
+++ b/target/i386/mpx_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index c7614f8..6f1fc17 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 094aafc..6c0c849 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index b96de06..16311e5 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/shift_helper_template.h b/target/i386/shift_helper_template.h
index cf91a2d..54f15d6 100644
--- a/target/i386/shift_helper_template.h
+++ b/target/i386/shift_helper_template.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/smm_helper.c b/target/i386/smm_helper.c
index eb5aa6e..d20e8ed 100644
--- a/target/i386/smm_helper.c
+++ b/target/i386/smm_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 6224387..3893158 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/tcg-stub.c b/target/i386/tcg-stub.c
index b00e23d..8d45579 100644
--- a/target/i386/tcg-stub.c
+++ b/target/i386/tcg-stub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/translate.c b/target/i386/translate.c
index caea6f5..4c57307 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
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


