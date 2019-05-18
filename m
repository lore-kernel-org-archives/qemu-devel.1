Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1DAC04AB4
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 03:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AF821783
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 03:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="UW5PnO7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AF821783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRq3F-0001dw-Tn
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 23:30:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hRq1X-0000bc-IH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 23:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hRq1W-000380-NB
	for qemu-devel@nongnu.org; Fri, 17 May 2019 23:28:39 -0400
Received: from m12-18.163.com ([220.181.12.18]:41004)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>)
	id 1hRq1W-00036t-51; Fri, 17 May 2019 23:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=lEt432YQhPlz0GLMEz
	gULiVC576SIEeGv9BeGhl/DjA=; b=UW5PnO7d5QCNDiQEBvgy3QarxwLpNpYKfX
	haoNYQXLuHLeFsky/ytbo2mBSWqedWCy1haE2MI68B76NiqVIPmAwsROz+XlooGP
	vkgxUUVjzfA9Ma9Q3sC2kQWDAVPRoD3GqN2fzIjLVm0DidYD0e8Qptm6S55xtcei
	qX+DWFNZI=
Received: from localhost.localdomain (unknown [183.159.73.182])
	by smtp14 (Coremail) with SMTP id EsCowACXzsrXe99czqL5Gg--.37649S5;
	Sat, 18 May 2019 11:28:35 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: alex.williamson@redhat.com,
	lvivier@redhat.com
Date: Fri, 17 May 2019 20:28:11 -0700
Message-Id: <20190518032811.60341-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518032811.60341-1-liq3ea@163.com>
References: <20190518032811.60341-1-liq3ea@163.com>
X-CM-TRANSID: EsCowACXzsrXe99czqL5Gg--.37649S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF15ur4DJFy7tFWkAw4xZwb_yoW8Gw1rpF
	Z8CF9Ykr4Fqw1xCrsavr4avF17JF4kWr129F4vg3yjya1xGas5Jw4DKFy7u348XFZYvFyF
	9r9rA345tF1rZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UN6p9UUUUU=
X-Originating-IP: [183.159.73.182]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBawG4bVetvcf8zAABsO
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.18
Subject: [Qemu-devel] [PATCH 4/4] pci: msix: move 'MSIX_CAP_LENGTH' to
 header file
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

CC: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/pci/msix.c         | 2 --
 hw/vfio/pci.c         | 2 --
 include/hw/pci/msix.h | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 4e336416a7..d39dcf32e8 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -24,8 +24,6 @@
 #include "qapi/error.h"
 #include "trace.h"
 
-#define MSIX_CAP_LENGTH 12
-
 /* MSI enable bit and maskall bit are in byte 1 in FLAGS register */
 #define MSIX_CONTROL_OFFSET (PCI_MSIX_FLAGS + 1)
 #define MSIX_ENABLE_MASK (PCI_MSIX_FLAGS_ENABLE >> 8)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 08729e5875..8e555db12e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -35,8 +35,6 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-#define MSIX_CAP_LENGTH 12
-
 #define TYPE_VFIO_PCI "vfio-pci"
 #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
 
diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 1f27658d35..08acfa836e 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -4,6 +4,8 @@
 #include "qemu-common.h"
 #include "hw/pci/pci.h"
 
+#define MSIX_CAP_LENGTH 12
+
 void msix_set_message(PCIDevice *dev, int vector, MSIMessage msg);
 MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector);
 int msix_init(PCIDevice *dev, unsigned short nentries,
-- 
2.17.1



