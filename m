Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F6C04AB4
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 03:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2A021783
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 03:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Fk8SHmxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2A021783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRq3A-0001a0-Il
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 23:30:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hRq1V-0000bM-R9
	for qemu-devel@nongnu.org; Fri, 17 May 2019 23:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hRq1U-00036p-U1
	for qemu-devel@nongnu.org; Fri, 17 May 2019 23:28:37 -0400
Received: from m12-18.163.com ([220.181.12.18]:40551)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>)
	id 1hRq1T-00031E-Py; Fri, 17 May 2019 23:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=ZkRZ93Zkgu3En+FaaA
	Yw/AoU28oCCnJZpXGm1pEjk1s=; b=Fk8SHmxyQX4smd841NzyhDTYEPREzPt0jO
	/JT1Rp+dDCuku1SMey7bxbRzSvYNu0V9kKdzCu2ue264REQGSxKExYsxnNlM1Uto
	mC6Dv2dWQi58T0YulnSmpXyUHWqp/5f6JMyEAeAN00R/MBeIkSRNqFXijAwAYlqT
	ZMM75JKPc=
Received: from localhost.localdomain (unknown [183.159.73.182])
	by smtp14 (Coremail) with SMTP id EsCowACXzsrXe99czqL5Gg--.37649S3;
	Sat, 18 May 2019 11:28:29 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: alex.williamson@redhat.com,
	lvivier@redhat.com
Date: Fri, 17 May 2019 20:28:09 -0700
Message-Id: <20190518032811.60341-2-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518032811.60341-1-liq3ea@163.com>
References: <20190518032811.60341-1-liq3ea@163.com>
X-CM-TRANSID: EsCowACXzsrXe99czqL5Gg--.37649S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryfZF4Dtw4UXryUGr13XFb_yoW8uFWxpF
	n7Ja4fWF4jgr4Yvw42k3W5AFZ8GF4kG347K34kCw1ay3W5GrnrZrWUAFWUArZ8Cry5ZFW3
	ZF42yr4rAa1Fvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uj2NNUUUUU=
X-Originating-IP: [183.159.73.182]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBLx24bVUMJXo4KgAAsz
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.18
Subject: [Qemu-devel] [PATCH 2/4] hw: vfio: drop TYPE_FOO MACRO in
 VMStateDescription
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, philmd@redhat.com, liq3ea@gmail.com,
	qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the vmstate structure names aren't related with
the QOM type names.

CC: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/vfio/amd-xgbe.c      | 2 +-
 hw/vfio/ap.c            | 2 +-
 hw/vfio/calxeda-xgmac.c | 2 +-
 hw/vfio/ccw.c           | 2 +-
 hw/vfio/platform.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index ee64a3b4a2..1b06c0f3ea 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -26,7 +26,7 @@ static void amd_xgbe_realize(DeviceState *dev, Error **errp)
 }
 
 static const VMStateDescription vfio_platform_amd_xgbe_vmstate = {
-    .name = TYPE_VFIO_AMD_XGBE,
+    .name = "vfio-amd-xgbe",
     .unmigratable = 1,
 };
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index d8b79ebe53..564751650f 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -155,7 +155,7 @@ static void vfio_ap_reset(DeviceState *dev)
 }
 
 static const VMStateDescription vfio_ap_vmstate = {
-    .name = VFIO_AP_DEVICE_TYPE,
+    .name = "vfio-ap",
     .unmigratable = 1,
 };
 
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index e7767c4b02..6cc608b6ca 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -26,7 +26,7 @@ static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
 }
 
 static const VMStateDescription vfio_platform_calxeda_xgmac_vmstate = {
-    .name = TYPE_VFIO_CALXEDA_XGMAC,
+    .name = "vfio-calxeda-xgmac",
     .unmigratable = 1,
 };
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 31dd3a2a87..d9e39552e2 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -468,7 +468,7 @@ static Property vfio_ccw_properties[] = {
 };
 
 static const VMStateDescription vfio_ccw_vmstate = {
-    .name = TYPE_VFIO_CCW,
+    .name = "vfio-ccw",
     .unmigratable = 1,
 };
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 398db38f14..e59a0234dd 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -697,7 +697,7 @@ out:
 }
 
 static const VMStateDescription vfio_platform_vmstate = {
-    .name = TYPE_VFIO_PLATFORM,
+    .name = "vfio-platform",
     .unmigratable = 1,
 };
 
-- 
2.17.1



