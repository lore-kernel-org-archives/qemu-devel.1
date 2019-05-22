Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D575C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A3520868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A3520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTzN-0004Gl-EH
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:21:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTnK-0002Zh-KX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTnH-0004z9-UU
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:46 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTn5-0004KQ-KP; Wed, 22 May 2019 12:08:32 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1Mwwm5-1gjc5k1Idf-00yPCy; Wed, 22 May 2019 18:07:43 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:07:23 +0200
Message-Id: <20190522160723.31484-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522160723.31484-1-laurent@vivier.eu>
References: <20190522160723.31484-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Zm70E0oI1ZM4VhuVrV6GSk5Zq65TW0Q3iF4E6XyH5HYqU2h0Zao
	p4Gh7WkJ1AE9pUSvPRL1YlWNjrdzSYh8FdCjmvRMoLCfw9KPU6Sok0uV4hNy7xUIW5nVKVy
	kgkuWwcQ1s8zkijGCMNf5/Uv+hnybRRMj1xn1q4Qt3h6JkXZOaXqh9QjxGORSu44MxI8AS9
	EEGIaFA2aQgx2F7Zb5H0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VV0Ai4aLcXk=:8ScUNQP4QVS+RbxOT+RGB1
	DiH86TvntWrDcy6rkHA7MLa0q2RhoJ12YrN9iwFQyBaxqw3jlFoyQjYB2lDw5vsGEuJraMWFO
	izMyWb2xxbEhPbUe4gdPINcujXzFXZPsOBBfoZpG0ESB6iixJlMCsOtVTnAtdsdSFpNklt57H
	kH7UYP61j4KR2X2N4xPtTbBNFu5vu0b6sk5yfSoOcmVni0chi8PKms5djeeXxJme6cUA1hFP0
	ZCwpXwqt30loKwCQNPHFK73AIpJ+rxK8CAFhnzVbzsiwoxVnsQjLoYLp6ixKDBcXs9v2MHBwT
	7huYWRKS1hxe6LznLJynCIbkYz+KSQkVmaJv/IR230HiRaJfUzl+TxyrOjzUcjjVRYfVirJCZ
	RKqXlAJrJizmxyLedx+qb1xLDUtMSqrtfyBOeoROHjOK286vIFNi/BfNNL5aLt86Ul303hCof
	naf0G/OUEoXH2EKkccneqxqwXtveUERP7VVQ1gQbLgBGMywcl6YaD6dle4A0RaqdnPkOwyNhb
	dfh9z59kJczNq8IYTRXLlfBVz7QKNCB6CL6tHKX2vnXXyIpUkaKsrzq0yLS9oLWGNZS2emHw2
	s+I9IqZj9NtzEF9sGofEwg1Tf1aTaMILtCE1q1tN2WUM5D4nkljRp68yvW6aJ/r3MhkKVYMvY
	FNGqAGH5WAO0zUxXZeUG60i0eBJtYzhrUHQp96z9cUWZ2dudwUoNXlqP33IcKe27jk9KU+cfI
	EHPESqNzJ0yrQIc+sXd2VVnW5kW3ijnKGioTYgsjd1ajNDDrt3bkmwR369g=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 9/9] pci: msix: move 'MSIX_CAP_LENGTH' to header
 file
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

'MSIX_CAP_LENGTH' is defined in two .c file. Move it
to hw/pci/msix.h file to reduce duplicated code.

CC: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190521151543.92274-5-liq3ea@163.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/pci/msix.c         | 2 --
 hw/vfio/pci.c         | 2 --
 include/hw/pci/msix.h | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 4e336416a78a..d39dcf32e8c9 100644
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
index 08729e5875a9..8e555db12ec0 100644
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
index 1f27658d352f..08acfa836e49 100644
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
2.20.1


