Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69547C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9E120578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9E120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZAt-00015L-HA
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxZ1G-0004W5-C5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxZ1E-0002dl-5s
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxZ1D-0002dQ-U0
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 443F2309BDA3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 15:47:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 403C834693;
 Tue, 13 Aug 2019 15:47:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB587113645F; Tue, 13 Aug 2019 17:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 17:46:48 +0200
Message-Id: <20190813154653.20568-25-armbru@redhat.com>
In-Reply-To: <20190813154653.20568-1-armbru@redhat.com>
References: <20190813154653.20568-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 13 Aug 2019 15:47:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 24/29] Include sysemu/hostmem.h less
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the HostMemoryBackend typedef from sysemu/hostmem.h to
qemu/typedefs.h.  This renders a few inclusions of sysemu/hostmem.h
superfluous; drop them.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190812052359.30071-25-armbru@redhat.com>
---
 include/hw/mem/pc-dimm.h        | 1 -
 include/hw/virtio/virtio-pmem.h | 1 -
 include/qemu/typedefs.h         | 1 +
 include/sysemu/hostmem.h        | 1 -
 hw/mem/nvdimm.c                 | 1 +
 hw/virtio/virtio-pmem.c         | 1 +
 6 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 47b246f95c..289edc0f3d 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -17,7 +17,6 @@
 #define QEMU_PC_DIMM_H
=20
 #include "exec/memory.h"
-#include "sysemu/hostmem.h"
 #include "hw/qdev-core.h"
=20
 #define TYPE_PC_DIMM "pc-dimm"
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-p=
mem.h
index 8bf2ae780f..33f1999320 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -16,7 +16,6 @@
=20
 #include "hw/virtio/virtio.h"
 #include "qapi/qapi-types-misc.h"
-#include "sysemu/hostmem.h"
=20
 #define TYPE_VIRTIO_PMEM "virtio-pmem"
=20
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 9e1283aacf..f569f5f270 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -33,6 +33,7 @@ typedef struct FWCfgEntry FWCfgEntry;
 typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
+typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 92fa0e458c..afeb5db1b1 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -27,7 +27,6 @@
 #define MEMORY_BACKEND_CLASS(klass) \
     OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_BACK=
END)
=20
-typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct HostMemoryBackendClass HostMemoryBackendClass;
=20
 /**
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 6fefd65092..375f9a588a 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -30,6 +30,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/qdev-properties.h"
 #include "hw/mem/memory-device.h"
+#include "sysemu/hostmem.h"
=20
 static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *n=
ame,
                                   void *opaque, Error **errp)
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index ff1a2ddb36..c0c9395e55 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -21,6 +21,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pmem.h"
+#include "sysemu/hostmem.h"
 #include "block/aio.h"
 #include "block/thread-pool.h"
=20
--=20
2.21.0


