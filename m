Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E963C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AD720882
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AD720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAx3E-0005uO-JR
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAwx0-00078M-JE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAwtc-0003kg-CR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:54:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36437)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAwtc-0003jo-3z; Thu, 19 Sep 2019 09:54:56 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8nnU-1i75WL0mLW-015sVz; Thu, 19 Sep 2019 15:54:47 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:54:36 +0200
Message-Id: <20190919135443.15164-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919135443.15164-1-laurent@vivier.eu>
References: <20190919135443.15164-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LaU9Ntx8Wj5J6fYiZrKRMWlggqOfpZICtTyCp9Nnz0RauefgCEv
 Ogdyb7Yz7AU5GK6pSjEFruzj2wbVRURwbRTXwfIa1RlW0yOUvlKOtoo+kwjOA9BA6LsCzgr
 N1IgA90sS4zVNRXNvRGyU/hl43pp2LpdbCt0ITJz1M6RejfgY+cVe47SxoQqAyE6CMaFyyJ
 Rvdv0JA5GJlymXV2YhADQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X1vlgRN4UyM=:2e+Dtd8xPf5AY60rjUTU6e
 /iO1upK5U38VY6htyEEEyUEQlCy4C6uKcd2nQZC2VNUG9Eku4EKu8Gj9kCdYPyU3WMt9KzQxo
 pq3Bn4lHDLRoYwjGo2WnmiuoTzE3liJALMhR3PdZ74tgnC/55XyRov/eHwAWJLeMzLtsB1gNL
 1tIoLF0ksSpc6M42E0XkRUf/hx3sLMC4K1F/nPNPZb65M4QD5r1ndNPltX48diSAMpi2dDtm1
 0o7Yijl0z8t1F/qtKqBX/yIXAleais34LEzpM07LsmEdlMQf7B2O3g7kqCkwY5yxFMvSlfo+f
 sR8iw2ZPOLR88yFl0ZDqeoz98EtLbECXaGHuR2vhTlKyYkMt+vdUI+34Zqb5l/THtjgqk1vqy
 0n39uNaJ+mfNibgoknPSpbkzm9onGQo6dlo+82mTa6BjG2a0k8R48vLPc/NlibBsRjf0CMZ5l
 o5DK8JUWSjyaUt4so6XKbs7jGsfZ/PapzanLyGBtPIJk7cbJ4T9rEQb4KcDsK8RYrQIpk7azz
 oNEaUTMm0ik1BzemjCuWULtBCuWkyzx4atDDAFzgn0XL17Fe99PvaRhmCCblCP2x7RhpyBPHM
 L1jYEN7Jg3k1tBzq4V4klAbBixv4DBWUi07CRXnGncKepOiz7gAMWSz9IbfE3arm4q6bveZC1
 IJbB1DwPjBSYhwxn3752A6P118pVjU6xuwXnTqGhwzO0Xj7ID7dsFgeES1ntYkw16dOujJmD1
 qxWEim23dla9B5EnET89TYand+Zik40uQLQMe0kEVFkSjt4wsmK3NaRMQCHbYj6iGlShg+BnG
 V6VkBjGgv5QtN7hxBgWAPcUpVlOjTVD4KXc9F7C9/0aQG+7fddEtz6rkL3MADyDRjXZxEO9JQ
 im4GFMkBCfQIl6wUHenCp/GUEqhUeCnJN6AFQe0KM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 1/8] vfio: fix a typo
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cornelia Huck <cohuck@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chen Zhang <tgfbeta@me.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Zhang <tgfbeta@me.com>

Signed-off-by: Chen Zhang <tgfbeta@me.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <8E5A9C27-C76D-46CF-85B0-79121A00B05F@me.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dc3479c374e3..c5e6fe61cb3e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -44,7 +44,7 @@
 #define TYPE_VFIO_PCI "vfio-pci"
 #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
 
-#define TYPE_VIFO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
+#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
@@ -3199,7 +3199,7 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo vfio_pci_nohotplug_dev_info = {
-    .name = TYPE_VIFO_PCI_NOHOTPLUG,
+    .name = TYPE_VFIO_PCI_NOHOTPLUG,
     .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_nohotplug_dev_class_init,
-- 
2.21.0


