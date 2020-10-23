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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851B7C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F932072E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPu/fwe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F932072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVw2f-0002zv-Um
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw1V-000255-Vr; Fri, 23 Oct 2020 08:18:21 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw1T-0000wd-Ah; Fri, 23 Oct 2020 08:18:21 -0400
Received: by mail-pl1-x643.google.com with SMTP id bf6so764804plb.4;
 Fri, 23 Oct 2020 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KSEDqVqpkGzWudkkdFkAWEi+UiMnzbkKsFsg0QviR08=;
 b=cPu/fwe3s78HNI6EArE9PZvUK4TwYizk+svBZcIDzuNCxTnkAl8/9ylXmf91seLJHo
 3ZdqsWq7qzViGE+eRkQCA5tWcUQPwSdekM2Ztk6rr5Hb5swmjCaHHRvrq5KPd8pOuc2G
 sEtDAVvc/phF/yFhcEXyyG2Jydthwl70qDQ39nChyHCdE7cBT83JNMC0gUHeg84NzGsn
 VrHoX9UKMXdniE4K9Iw//8Rq2y4rSIc/ztr0kLh7C4tcQD6F9nPKNt9GJ0CJc5MYKVxT
 mf4r89TRCpv4xJNpp9abFZDoZr2ts0wTM+0lZLiZNvO2wkWXzKdrna3aPrBOjJSgHTw5
 rHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KSEDqVqpkGzWudkkdFkAWEi+UiMnzbkKsFsg0QviR08=;
 b=fcUZyVRACsHpffsRJqFd/q6tE9Mz2UN3gpl4TaFYxac4g7fzTm3rKGK7iSqLATT2EG
 bEcZv9FOFv8rBIdMsn4JK3XXczKGpSDeFoAvriR+0+FYZwpU0U6f1n8Mx1zllrfkF9V9
 RtA6ErTYe/flnkp2lraTRyvQ+231ICDLENkOSLZ+uV/FQ+geetLFisvQxo8WNx3GGyhV
 c3mMb1nFsKBvUcURH/OvV26g7u8H9Y4dOKnkRZPdGFw8cKwBAOun/d6E13ej6FU+P3D/
 Kx7Z0N5Jt2965YWtxi7pMFa9O9ZdITb1f0ZDJQz0UhiSoHapYwMRAP/yRBFmwkhKeY8M
 AdfQ==
X-Gm-Message-State: AOAM533hnRlS9PX3FtKuWlQ1z9+elOxWPG9eHFsRrzYGg/aGxRTJoF8R
 ZVai6q71hPC0dn2ugxAbOHUzodn0wimZwbmZ
X-Google-Smtp-Source: ABdhPJwJjwkj9Qqly+HHRho8N6Lku2YIMzJ9nNGqvKIECxK0cp2YxoNjJ5RKd6e2hM42hb0Oebf8ZQ==
X-Received: by 2002:a17:902:8691:b029:d3:9c6b:d326 with SMTP id
 g17-20020a1709028691b02900d39c6bd326mr2178350plo.60.1603455496468; 
 Fri, 23 Oct 2020 05:18:16 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id l13sm1903430pgq.33.2020.10.23.05.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:18:15 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 9/30] cris tcg cpus: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:16:48 +0000
Message-Id: <20201023121649.19123-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chetan4windows@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
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
 target/cris/cpu.h               | 2 +-
 target/cris/crisv10-decode.h    | 2 +-
 target/cris/crisv32-decode.h    | 2 +-
 target/cris/gdbstub.c           | 2 +-
 target/cris/helper.c            | 2 +-
 target/cris/machine.c           | 2 +-
 target/cris/mmu.c               | 2 +-
 target/cris/op_helper.c         | 2 +-
 target/cris/translate.c         | 2 +-
 target/cris/translate_v10.c.inc | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8f08d76..d3b6492 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/crisv10-decode.h b/target/cris/crisv10-decode.h
index 028179b..9c531f3 100644
--- a/target/cris/crisv10-decode.h
+++ b/target/cris/crisv10-decode.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/crisv32-decode.h b/target/cris/crisv32-decode.h
index cdc2f8c..fa0a7f0 100644
--- a/target/cris/crisv32-decode.h
+++ b/target/cris/crisv32-decode.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index b01b2aa..2418d57 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b5159b8..ed45c3d 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/machine.c b/target/cris/machine.c
index be38a89..f370f33 100644
--- a/target/cris/machine.c
+++ b/target/cris/machine.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/mmu.c b/target/cris/mmu.c
index 2acbcfd..a279b7f 100644
--- a/target/cris/mmu.c
+++ b/target/cris/mmu.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index 6b1e7ae..d55a18a 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/translate.c b/target/cris/translate.c
index c312e6f..c893f87 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index 7f38fd2..86d78a8 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -7,7 +7,7 @@
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


