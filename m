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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B0C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B352168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW6KvjzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B352168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwAp-0001LB-HR
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw9F-0008PZ-Au; Fri, 23 Oct 2020 08:26:21 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw9C-00028C-9k; Fri, 23 Oct 2020 08:26:21 -0400
Received: by mail-pg1-x544.google.com with SMTP id t14so1135232pgg.1;
 Fri, 23 Oct 2020 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Qk++Havo5a7x1XhP71VgweImBwTNNlzf70nIPD2Uobk=;
 b=KW6KvjzNjNRn50ipEpFGHXFVkyC9jo7fFX4aE9bFoSFlqVVxYm9PqgQFMRmDcAmWXx
 cMfj0okUjxubKc1ISPY+hZRKYnLI/YviDrvKcOyXEo9Cs3m006uNI6cJ6tnKagBsGtKZ
 r2hteDtyU53d9Kay/5eCg8fR7m6q7d8pZptMKpqJSOXKtNlMGLM4fxj+TiMStc0BCY0k
 /Msxp0vhX1yPOh7oMrUnyAGxqDXt9kp5zXwA9tB14RrnFFpCbP1hz0qjzTwOHkw/gnm6
 2vuq21YyR2Go85jbdaEK4WN/mLwsw4IOdheyBxINsKwXMtTNEgbRktgLHT7aaAexFxVd
 ePyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Qk++Havo5a7x1XhP71VgweImBwTNNlzf70nIPD2Uobk=;
 b=OtQ9k4Yf6cODXx7YmeutM3TOuZx++W2jib3mIBr+6M10urUpAJC9tQWcZyz8JYo3ES
 6kGolpqts5+bRnHWThioawFt4T4aZP4IHmSMp1mUhRHaMyCM+MUcPrEqlkgsG3W0qdmG
 tbSwuBUHskV2OkkNiWmzSesiTx2FWWUjodIUQvYDXaz1dH0PavPS/cM87pOsd9U0hGqi
 VwExkuo7BbDkBGV0vz6jvqjmR8fcNaNF/sjjgGRiFnnE6SBXsRrbdZWd7aV3Zw84HGr2
 G0QE7YslkI8eamjimIfSh5a4kwE+5QrdVtUxn4Mw2/UhseQ2KjKf9D30XEIOtnIqeht4
 6xVg==
X-Gm-Message-State: AOAM533ljxOkEsZ4IWNkywGTHthaBT7TWQQHEB0o8vbJZs3zOAFVKO4r
 T4VeetfWCY4J9LcrngGBdEs6GYEuQ/P/LWCd
X-Google-Smtp-Source: ABdhPJyNm3SYa+MzXVCOITde5NcMV77tfCn9Mw8PrFfrOcD7O3if9yF8KtRkOCV0IBCapwqPNk0dRA==
X-Received: by 2002:a63:5312:: with SMTP id h18mr1797428pgb.75.1603455975441; 
 Fri, 23 Oct 2020 05:26:15 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id f4sm2414251pjs.8.2020.10.23.05.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:26:14 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 15/30] linux user: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:24:55 +0000
Message-Id: <20201023122455.19417-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=chetan4windows@gmail.com; helo=mail-pg1-x544.google.com
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
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 linux-user/aarch64/target_cpu.h        | 2 +-
 linux-user/aarch64/target_structs.h    | 2 +-
 linux-user/alpha/target_cpu.h          | 2 +-
 linux-user/alpha/target_structs.h      | 2 +-
 linux-user/arm/target_cpu.h            | 2 +-
 linux-user/arm/target_structs.h        | 2 +-
 linux-user/cris/target_cpu.h           | 2 +-
 linux-user/cris/target_structs.h       | 2 +-
 linux-user/hppa/target_cpu.h           | 2 +-
 linux-user/hppa/target_structs.h       | 2 +-
 linux-user/i386/target_cpu.h           | 2 +-
 linux-user/i386/target_structs.h       | 2 +-
 linux-user/microblaze/target_cpu.h     | 2 +-
 linux-user/microblaze/target_structs.h | 2 +-
 linux-user/mips/target_cpu.h           | 2 +-
 linux-user/mips/target_structs.h       | 2 +-
 linux-user/mips64/target_cpu.h         | 2 +-
 linux-user/nios2/target_cpu.h          | 2 +-
 linux-user/nios2/target_structs.h      | 2 +-
 linux-user/ppc/target_cpu.h            | 2 +-
 linux-user/ppc/target_structs.h        | 2 +-
 linux-user/ppc/target_syscall.h        | 2 +-
 linux-user/s390x/target_structs.h      | 2 +-
 linux-user/sparc/target_cpu.h          | 2 +-
 linux-user/sparc/target_structs.h      | 2 +-
 linux-user/sparc64/target_structs.h    | 2 +-
 linux-user/tilegx/target_cpu.h         | 2 +-
 linux-user/tilegx/target_structs.h     | 2 +-
 linux-user/x86_64/target_structs.h     | 2 +-
 29 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index 6cc02e7..97a477b 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/aarch64/target_structs.h b/linux-user/aarch64/target_structs.h
index a4998a7..7c74834 100644
--- a/linux-user/aarch64/target_structs.h
+++ b/linux-user/aarch64/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index ad408ab..dc2dd65 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/alpha/target_structs.h b/linux-user/alpha/target_structs.h
index db2bfe2..d91cebd 100644
--- a/linux-user/alpha/target_structs.h
+++ b/linux-user/alpha/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 2747211..709d19b 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/arm/target_structs.h b/linux-user/arm/target_structs.h
index 9a3dbce..339b070 100644
--- a/linux-user/arm/target_structs.h
+++ b/linux-user/arm/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index 74ead55..7f6cade 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/cris/target_structs.h b/linux-user/cris/target_structs.h
index 76f9653..f949d23 100644
--- a/linux-user/cris/target_structs.h
+++ b/linux-user/cris/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 71654b3..aacf3e9 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/hppa/target_structs.h b/linux-user/hppa/target_structs.h
index b560b18..b7cf4a3 100644
--- a/linux-user/hppa/target_structs.h
+++ b/linux-user/hppa/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index 2207d24..52caf78 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/i386/target_structs.h b/linux-user/i386/target_structs.h
index 25388a7..e22847f 100644
--- a/linux-user/i386/target_structs.h
+++ b/linux-user/i386/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index ce7b22e..dcae2ab 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/microblaze/target_structs.h b/linux-user/microblaze/target_structs.h
index 70dbdb6..d08f6a5 100644
--- a/linux-user/microblaze/target_structs.h
+++ b/linux-user/microblaze/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 758ae4d..c375616 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/mips/target_structs.h b/linux-user/mips/target_structs.h
index 909ba89..c1150fd 100644
--- a/linux-user/mips/target_structs.h
+++ b/linux-user/mips/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/mips64/target_cpu.h b/linux-user/mips64/target_cpu.h
index f16991b..2857a76 100644
--- a/linux-user/mips64/target_cpu.h
+++ b/linux-user/mips64/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index 50f0381..2d2008f 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/nios2/target_structs.h b/linux-user/nios2/target_structs.h
index 7145251..daa2886 100644
--- a/linux-user/nios2/target_structs.h
+++ b/linux-user/nios2/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index 76b67d2..51ee148 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/ppc/target_structs.h b/linux-user/ppc/target_structs.h
index 6b1f579..520e326 100644
--- a/linux-user/ppc/target_structs.h
+++ b/linux-user/ppc/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/ppc/target_syscall.h b/linux-user/ppc/target_syscall.h
index c461f87..b9c4b81 100644
--- a/linux-user/ppc/target_syscall.h
+++ b/linux-user/ppc/target_syscall.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/s390x/target_structs.h b/linux-user/s390x/target_structs.h
index cadff6d..aab716e 100644
--- a/linux-user/s390x/target_structs.h
+++ b/linux-user/s390x/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 14b2158..1fa1011 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/sparc/target_structs.h b/linux-user/sparc/target_structs.h
index ee24c3b..9953540 100644
--- a/linux-user/sparc/target_structs.h
+++ b/linux-user/sparc/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/sparc64/target_structs.h b/linux-user/sparc64/target_structs.h
index 1808132..4a8ed48 100644
--- a/linux-user/sparc64/target_structs.h
+++ b/linux-user/sparc64/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index 316b7a6..5fa9e2a 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/tilegx/target_structs.h b/linux-user/tilegx/target_structs.h
index de8b1f2..1df000c 100644
--- a/linux-user/tilegx/target_structs.h
+++ b/linux-user/tilegx/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/x86_64/target_structs.h b/linux-user/x86_64/target_structs.h
index b6e82a8..ce367b2 100644
--- a/linux-user/x86_64/target_structs.h
+++ b/linux-user/x86_64/target_structs.h
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


