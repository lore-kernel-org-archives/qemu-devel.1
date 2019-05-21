Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A6C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CC62173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="XMe/Ant6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CC62173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6dW-0004sZ-Dj
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:25:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hT6VV-0007Yx-0H
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hT6VU-0001ce-1i
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:16:48 -0400
Received: from m12-16.163.com ([220.181.12.16]:57339)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>)
	id 1hT6VR-0001VI-UR; Tue, 21 May 2019 11:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=JmlbMI8+rNjltu5NEn
	UC7kK/0d8byMc075r+nhfmo6c=; b=XMe/Ant6o7Wm413n39LYWjdl5r1IuZO/hU
	OEWiG2efN9NSKuOL7OHRnnbCXapi6pdmD0do1spJt3611sSXiJ66eK7TdWY7/c6z
	qMPjr2I9EUvWUXu8dZW1pUdAagaQ8mJ/z6OgpWzIzgYuAkvgoZeXMs62EobCmgXH
	UGqXiiiJw=
Received: from localhost.localdomain (unknown [115.192.71.0])
	by smtp12 (Coremail) with SMTP id EMCowAC31lxJFuRcie7uGw--.4521S6;
	Tue, 21 May 2019 23:16:37 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: alex.williamson@redhat.com,
	lvivier@redhat.com
Date: Tue, 21 May 2019 08:15:43 -0700
Message-Id: <20190521151543.92274-5-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521151543.92274-1-liq3ea@163.com>
References: <20190521151543.92274-1-liq3ea@163.com>
X-CM-TRANSID: EMCowAC31lxJFuRcie7uGw--.4521S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4fAF15Wr15Gw1rXw1UZFb_yoW8XFykpF
	Z8CF9a9r4Fqw17Crsayw4avF17JF4DWr12vF4vg3y7ta1xGF1ktr4DtFy7u34xXFW0vFyr
	Gr9rZ345tF1UZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBWl9UUUUU=
X-Originating-IP: [115.192.71.0]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBZhW7bVaD1l5SdQAAsf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.16
Subject: [Qemu-devel] [PATCH v2 4/4] pci: msix: move 'MSIX_CAP_LENGTH' to
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

'MSIX_CAP_LENGTH' is defined in two .c file. Move it
to hw/pci/msix.h file to reduce duplicated code.

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



