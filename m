Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6D7C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C16220868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C16220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTxh-0003BC-RG
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:19:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTn8-0002O3-IK
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTn7-0004Uh-JL
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTmz-00045p-4Z; Wed, 22 May 2019 12:08:25 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MuDTn-1gdaTf45r3-00uZSg; Wed, 22 May 2019 18:07:39 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:07:20 +0200
Message-Id: <20190522160723.31484-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522160723.31484-1-laurent@vivier.eu>
References: <20190522160723.31484-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6/5e76T1+hru2DLQJ56rOSKbhJRipSr30E2IAEPyFGEo9bmDiHC
	TLqHMaIZkD8fI/l3CVWOr0g4N+Xt7N34g24fXLSd476aA23FKd+JOpBgdeBwLlEeRj3U+mx
	Dcrn28jQThU/am7tSB59sfhbo4VeK0E8p7VQtzTk1RXqVncKxYVEk/PSKDGM+S7TlBzKEi/
	pRAFkIv2fP/Gr98tp8G1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l6hggI84yA4=:OUi4ZpRUC00/2bO2CZSbzB
	3y16jgQhxJVWfuqaoylrUI0iAxZChkvrdoMeVUGGIHIFOZGtL0MkTzBZhVEJqfJL2hn7OK4Mb
	X/A8I0jrGuoqn1UXc/+yMA4XNfA/FEax/2+WogbpYQ23Y2y1yWvkd7iXwLP9e8n0/d6tHZqlu
	YV6qXCTESdf0UMCgkBG5P8hrcswHfhUD2MaYWoqROTnRj2uLc+ICr4pj8n/msmjzohskwifFR
	4XaLCy6+qkpjQ3EcA65rtRFUu02VaE0nQa6rED2N07DpRtMrOxJ32usdz3QmTD6fLP2m3C1Z7
	RvWSb/OkfeqAue+1kHDksiul6yb7e1Rff34VLLYHdyxYB7yRQck/ubHtNfabxcArTRJ/GlDEg
	r7y0nOU/JFgpNcJ+0JavSD1BkzgQs8wCZtzUAjK/JP6qkvaoSR4TSqtaaGTQ25lWRhJ1GXiJX
	LvOuvd/2iN7GtQM65Dx3BoNd49FpHN/qlWPcDb2vlkuz0dZ97EWFUW7859TfbbkmxefuqFV8x
	9HmNTswgCuiPb1XiqRWR1woN4/Rm0XulLFHrCzfx6BnJmGN0mu1a9bNaRgjte2yYzBCqJ00GG
	2/zMQluvF+Wo2P99FY6B9tXqhV1XMZJlqR6OiN+ZoA7FJAe5Zzw0EqtJIazQnrx+8nbirKVJb
	0+LkXxThb/G1CRPeBQ6mXqt48VmhJWtbNp7yS5WOxHV9TXDOzMBFSCJKwY/R3ypXg6z9pD0Et
	MF3ly+Z3ysH0/T5QunnTvMn28J0gUGD2bpLZYz1g0iAXiu2EuEgzrXldeAk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 6/9] vfio: pci: make "vfio-pci-nohotplug" as
 MACRO
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

The QOMConventions recommends we should use TYPE_FOO
for a TypeInfo's name. Though "vfio-pci-nohotplug" is not
used in other parts, for consistency we should make this change.

CC: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190521151543.92274-2-liq3ea@163.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/vfio/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8cecb53d5cf6..08729e5875a9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -40,6 +40,8 @@
 #define TYPE_VFIO_PCI "vfio-pci"
 #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
 
+#define TYPE_VIFO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
+
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 
@@ -3304,8 +3306,8 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo vfio_pci_nohotplug_dev_info = {
-    .name = "vfio-pci-nohotplug",
-    .parent = "vfio-pci",
+    .name = TYPE_VIFO_PCI_NOHOTPLUG,
+    .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_nohotplug_dev_class_init,
 };
-- 
2.20.1


