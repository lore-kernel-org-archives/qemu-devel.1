Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E71C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A76820868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A76820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTpj-0004CR-Q3
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:11:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTnK-0002Zc-Gj
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTnG-0004wG-PR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41293)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTnC-0004ap-QZ; Wed, 22 May 2019 12:08:40 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MrhHm-1gos6y1rvQ-00nhqB; Wed, 22 May 2019 18:07:40 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:07:21 +0200
Message-Id: <20190522160723.31484-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522160723.31484-1-laurent@vivier.eu>
References: <20190522160723.31484-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ISkYsZZcLEhBQxePiuhedggg9+OK6RS/cKPT7v9zPW9vmVCDPZB
	B1nWbPLOfZY+hDFDy4SqutQaiXoZ+r1vI4va8y/MwC86FKQFZeivWyaWlpQyOl4xqm+S/3S
	4nPoaZZKzilkWo65bSrzUKsyk5bPhahTQooJ/fIo1df7Y3h7S2C2Bk4csTYxBvSSr88Vkg6
	gg52exdX5uY7fcZro2q1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6NK3qLo6RIU=:2Kdr/3X4iNL8kDM9kQk8uP
	hMOz/2CGDoJVuTOoRQG2WyqZyofomhNhXJFE2DUh7hlKKYqYigNjH2xWb45zVjbE98PVJTiF8
	/w5ZODp2qA4bdUfs9jqEp1fUkTBkuH6tD6ULCsPLfQNg8hViCpOby3X+zjMso1zudjeIEqFOn
	gZ7v3yAsub8uGfoj6vCiPBaYi0qsX+tlrJlQItVT/OAk2s9cJJCo/Dsqo0l+wV97cs+5ireOk
	shZIM1YjN7SEsDJ7/A8dDp89Izvr9jrrSZV7WWK+DMVdSpfN+hqDSEnpmLLM4YAeFZG2DWQTw
	WpHEvGKPzeszZGhATJK+5AcqgCWqo9v6rQdHE4I6BqJ9Cy9wqIX+GQq2migENf0Srv+qW0WuT
	a6PW5BCP0PCXhYfFInBKc2wn+l+XpTvhV5FFYxD4HU47DiYtXfd5pVho2dWFeFN77SNfxHLFS
	LQiQ7ajFSVrmjs+tHG7bKs4cz6dEQcfN8LBX0xdkeBXBO5FQmPmPKsOlO1WfxmGNyOP9+JFQh
	5jdzC/Xe5p2PZc2MNpWCLHcQGpedXW9aQeebRemTIX2s2sBjclyz4RIPNHlxBS7uxEFMppQBB
	m0FgBO27O7E2qesXngPmpVuTIMGBjR+/6UA5boJPo79xnVeetEjSPMvehxOo0OmbhDQ21RLoT
	NNmRyDCs3lJsqFYA92jkZkEUvz0XmqGw247l629avq6IjXyeEu0v9hyN4GCRkwdBXfDZRv5MZ
	t437ROw62YNSGU74fB19dFiIzy3UIvm/KeooB6Fr83Z/7KYr4aMfn7DewjE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 7/9] hw: vfio: drop TYPE_FOO MACRO in
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
	Li Qiang <liq3ea@163.com>, Cornelia Huck <cohuck@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Alex Williamson <alex.williamson@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

It's recommended that VMStateDescription names are decoupled from QOM
type names as the latter may freely change without consideration of
migration compatibility.

Link: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02175.html

CC: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190521151543.92274-3-liq3ea@163.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/vfio/amd-xgbe.c      | 2 +-
 hw/vfio/ap.c            | 2 +-
 hw/vfio/calxeda-xgmac.c | 2 +-
 hw/vfio/ccw.c           | 2 +-
 hw/vfio/platform.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index ee64a3b4a2e4..1b06c0f3ea9d 100644
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
index d8b79ebe53ae..564751650fc1 100644
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
index e7767c4b021b..6cc608b6cabd 100644
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
index 31dd3a2a87b6..d9e39552e237 100644
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
index 398db38f14d9..e59a0234dd87 100644
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
2.20.1


