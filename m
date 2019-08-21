Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D65C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7643522D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7643522D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Lab-0008V1-Br
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pagupta@redhat.com>) id 1i0LAy-00084E-AO
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1i0LAv-0004Dw-Oc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1i0LAu-0004Bj-GA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:36:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6107D308A98C;
 Wed, 21 Aug 2019 07:36:53 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-177.sin2.redhat.com
 [10.67.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDC9D1001B12;
 Wed, 21 Aug 2019 07:36:35 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:06:30 +0530
Message-Id: <20190821073630.2561-1-pagupta@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 21 Aug 2019 07:36:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] virtio pmem: user document
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
Cc: pagupta@redhat.com, david@redhat.com, cohuck@redhat.com,
 lcapitulino@redhat.com, mst@redhat.com, stefanha@redhat.com, riel@surriel.com,
 nilal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch documents the steps to use virtio pmem.
It also documents other useful information about
virtio pmem e.g use-case, comparison with Qemu NVDIMM
backend and current limitations.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
v1->v2
 - Fixes on text format and 'Guest Data persistence'
   section - Cornelia

 docs/virtio-pmem.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 docs/virtio-pmem.rst

diff --git a/docs/virtio-pmem.rst b/docs/virtio-pmem.rst
new file mode 100644
index 0000000000..0346e61674
--- /dev/null
+++ b/docs/virtio-pmem.rst
@@ -0,0 +1,75 @@
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+QEMU virtio pmem
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ This document explains the setup and usage of virtio pmem device
+ which is available since QEMU v4.1.0.
+
+ The virtio pmem is a paravirtualized persistent memory device on
+ regular(i.e non-NVDIMM) storage.
+
+Usecase
+--------
+
+  Allows to bypass the guest page cache and directly use host page cache=
.
+  This reduces guest memory footprint as the host can make efficient
+  memory reclaim decisions under memory pressure.
+
+o How does virtio-pmem compare to the nvdimm emulation supported by QEMU=
?
+
+  NVDIMM emulation on regular(i.e. non-NVDIMM) host storage does not
+  persist the guest writes as there are no defined semantics in the devi=
ce
+  specification. The virtio pmem device provides guest write persistence
+  on non-NVDIMM host storage.
+
+virtio pmem usage
+-----------------
+
+  A virtio pmem device backed by a memory-backend-file can be created on
+  the QEMU command line as in the following example:
+
+  -object memory-backend-file,id=3Dmem1,share,mem-path=3D./virtio_pmem.i=
mg,size=3D4G
+  -device virtio-pmem-pci,memdev=3Dmem1,id=3Dnv1
+
+   where:
+   - "object memory-backend-file,id=3Dmem1,share,mem-path=3D<image>, siz=
e=3D<image size>"
+     creates a backend file of size on a mem-path.
+
+   - "device virtio-pmem-pci,id=3Dnvdimm1,memdev=3Dmem1" creates a virti=
o pmem
+     pci device whose storage is provided by above memory backend device=
.
+
+  Multiple virtio pmem devices can be created if multiple pairs of "-obj=
ect"
+  and "-device" are provided.
+
+Hotplug
+-------
+
+"Virtio pmem devices can be hotplugged via the QEMU monitor. First, the
+memory backing has to be added via 'object_add'; afterwards, the virtio
+pmem device can be added via 'device_add'."
+
+For example, the following commands add another 4GB virtio pmem device t=
o
+the guest:
+
+ (qemu) object_add memory-backend-file,id=3Dmem2,share=3Don,mem-path=3Dv=
irtio_pmem2.img,size=3D4G
+ (qemu) device_add virtio-pmem-pci,id=3Dvirtio_pmem2,memdev=3Dmem2
+
+Guest Data Persistence
+----------------------
+
+ Guest data persistence on non-NVDIMM requires guest userspace applicati=
on to
+ perform fsync/msync. This is different from a real nvdimm backend where=
 no
+ additional fsync/msync is required. This is to persist guest writes in =
host
+ backing file which otherwise remains in host page cache and there is ri=
sk of
+ losing the data in case of power failure.
+
+ With virtio pmem device, MAP_SYNC mmap flag is not supported. This prov=
ides
+ a hint to application to perform fsync for write persistence.
+
+Limitations
+------------
+- Real nvdimm device backend is not supported.
+- virtio pmem hotunplug is not supported.
+- ACPI NVDIMM features like regions/namespaces are not supported.
+- ndctl command is not supported.
--=20
2.21.0


