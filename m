Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDCCC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 06:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2353C2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 06:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2353C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsLvY-0000gP-Ch
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 02:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hsLuy-0008E3-MG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hsLux-0008Pp-K3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hsLux-0008P9-DO
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:47:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDCDAC024AED;
 Tue, 30 Jul 2019 06:47:26 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-177.sin2.redhat.com
 [10.67.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BBC6600CD;
 Tue, 30 Jul 2019 06:47:21 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 12:16:58 +0530
Message-Id: <20190730064658.27369-2-pagupta@redhat.com>
In-Reply-To: <20190730064658.27369-1-pagupta@redhat.com>
References: <20190730064658.27369-1-pagupta@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 30 Jul 2019 06:47:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] virtio pmem: user document
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
Cc: aarcange@redhat.com, pagupta@redhat.com, cohuck@redhat.com,
 david@redhat.com, mst@redhat.com, lcapitulino@redhat.com, stefanha@redhat.com,
 riel@surriel.com, nilal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch documents the steps to use virtio pmem.
It also documents other useful information about
virtio pmem e.g use-case, comparison with Qemu NVDIMM
backend and current limitations.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 docs/virtio-pmem.txt | 65 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 docs/virtio-pmem.txt

diff --git a/docs/virtio-pmem.txt b/docs/virtio-pmem.txt
new file mode 100644
index 0000000000..fc61eebb20
--- /dev/null
+++ b/docs/virtio-pmem.txt
@@ -0,0 +1,65 @@
+
+QEMU virtio pmem
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ This document explains the usage of virtio pmem device=20
+ which is available since QEMU v4.1.0.
+
+ The virtio pmem is paravirtualized persistent memory device
+ on regular(non-NVDIMM) storage.=20
+
+Usecase
+--------
+  Allows to bypass the guest page cache and directly use host page cache=
.
+  This reduces guest memory footprint as host can make efficient memory
+  reclaim decisions under memory pressure.
+
+o How does virtio-pmem compare to the nvdimm emulation supported by QEMU=
?
+
+  NVDIMM emulation on regular(non-NVDIMM) host storage does not persists
+  the guest writes as there are no defined semantecs in the device speci=
fication.
+  With virtio pmem device, guest write persistence on non-NVDIMM storage=
 is
+  supported.
+
+virtio pmem usage
+-----------------
+  virtio pmem device is created with a memory-backend-file with the belo=
w
+  options:
+
+  -machine pc -m 8G,slots=3D$N,maxmem=3D$MAX_SIZE
+  -object memory-backend-file,id=3Dmem1,share,mem-path=3D$PATH,size=3D$S=
IZE
+  -device virtio-pmem-pci,memdev=3Dmem1,id=3Dnv1
+
+   where:
+   - "object memory-backend-file,id=3Dmem1,share,mem-path=3D$PATH,size=3D=
$VIRTIO_PMEM_SIZE"
+     creates a backend storage of size $SIZE on a file $PATH. All
+     accesses to the virtio pmem device go to the file $PATH.
+
+   - "device virtio-pmem-pci,id=3Dnvdimm1,memdev=3Dmem1" creates a virti=
o pmem
+     device whose storage is provided by above memory backend device.
+
+  Multiple virtio pmem devices can be created if multiple pairs of "-obj=
ect"
+  and "-device" are provided.
+
+Hotplug
+-------
+Accomplished by two monitor commands "object_add" and "device_add".
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
+Guest data persistence on non-NVDIMM requires guest userspace applicatio=
n to=20
+perform fsync/msync. This is different than real nvdimm backend where no=
 additional
+fsync/msync is required for data persistence.
+
+Limitations
+------------
+- Real nvdimm device backend is not supported.
+- virtio pmem hotunplug is not supported.
+- ACPI NVDIMM features like regions/namespaces are not supported.
+- ndctl command is not supported.
--=20
2.21.0


