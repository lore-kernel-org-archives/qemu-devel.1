Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3371C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F2D2222F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoGw4q5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F2D2222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSh0j-0003De-Td
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kSgzh-0002DV-1G; Wed, 14 Oct 2020 09:39:05 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kSgzf-0006vf-00; Wed, 14 Oct 2020 09:39:04 -0400
Received: by mail-pl1-x643.google.com with SMTP id w21so1788085plq.3;
 Wed, 14 Oct 2020 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=sRtlPAI1V8wLrxSirkSZ/JV+HdhX3ELhryBZ8+gA0N0=;
 b=aoGw4q5l5+FWTHf6xUHUn80N1T23w7Oi776eBzlXP1l6W/ijaWBfkcLvOwB7RHTWFF
 JInozaugArupUdWDW8VwM/Ki1o0qCtWqA8aPcUSEWIt42q5x4QHlVLI/+bOz7m05nDOY
 XfA/443Md0VuJM9zI17sWq0ua29wsAM7Z3xH3TAoldAsIw3tUKGKtpyfe7Fi59yijWPj
 e1PUNzxPEFV5j2BCybepM1sVLGsamSulU8Uw8KNkkX/8mncn/TMyPsP5CUuJhQeN6/qN
 I8IHDzmHSl2EKB7CVrjvCzJC//6WFTVGcd9M9x6YpTle5bEDzWY/W7v3zGzrqYvFIROv
 8tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=sRtlPAI1V8wLrxSirkSZ/JV+HdhX3ELhryBZ8+gA0N0=;
 b=sgl3QyjTKkO8MIaZxgxEIR7AiolWrQhQQfvim9JLYKDJtjaMt/URTCR573FQYK/bdW
 aDK/EPwiB2MnGli9V9v7o+mGG078blMp9y7YevjK5xEZeqIIWTLoNnB9yvOrAjbCpq2H
 2Ub0o8c1RzIGpArmIlbcCrJzS2zUKH3d0kgskHXkxciygWacDVRQurZmV5sr4+18XwW0
 Mxf0zGqGgIfnEbd/kkgFa/dZe6Mp7+tTwDZQFDWT/2IbaWxiblMU/Dk5c4wHLISMG+Ng
 AIYk0DsIVhSKcycPeuRPWtxSXGttCoKqbK+glOYHdY52Y4oqjn19Aeu1UBzDKTIfBgbF
 T0vg==
X-Gm-Message-State: AOAM532bhK7w6XTnQyE1tCmx4LUBIfnK+ILCtjrvMSus1DQsw/yPPehz
 tZ3iFtAbu30O92khJKECQqaYGeOE4t9B4Iuk
X-Google-Smtp-Source: ABdhPJwGo4O8gMFLIpcVkizzNmw4WYU5+EpKYABF3+SkIgwdjYyEdGRnLERUsiYItH77MULkL0VX7w==
X-Received: by 2002:a17:90b:11d1:: with SMTP id
 gv17mr3532011pjb.3.1602682740298; 
 Wed, 14 Oct 2020 06:39:00 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id y137sm3521812pfc.77.2020.10.14.06.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 06:38:59 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 1/30] cryptodev: Fix Lesser GPL version number
Date: Wed, 14 Oct 2020 13:37:22 +0000
Message-Id: <20201014133722.14041-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org,
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
 backends/cryptodev-builtin.c          | 2 +-
 backends/cryptodev-vhost-user.c       | 2 +-
 backends/cryptodev-vhost.c            | 2 +-
 backends/cryptodev.c                  | 2 +-
 include/sysemu/cryptodev-vhost-user.h | 2 +-
 include/sysemu/cryptodev-vhost.h      | 2 +-
 include/sysemu/cryptodev.h            | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index c6edb1b..0671bf9 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index e1df073..bedb452 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 8337c9a..8231e7f 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 3f141f6..bf52476 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/cryptodev-vhost-user.h
index 0d3421e..6071050 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
index f42824f..e8cab13 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index b458aa4..f4d4057 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -9,7 +9,7 @@
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


