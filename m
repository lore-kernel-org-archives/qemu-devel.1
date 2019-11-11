Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A6AC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8158E206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZVLSAkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8158E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6H8-0000Ri-LL
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 04:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iU6GM-0008O2-Sh
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iU6GK-0003bl-BB
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:45:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iU6GJ-0003al-Rt
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573465528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AlyO/JqI3kxCTr04SdZxZrtsvOcv0dg4x8rtByrAnws=;
 b=XZVLSAkFYyrUMQJvCD0CqFkp7QkVtvwf+SQ4FWGAbuViOJwUp0XxxAtMiZ+b9S0sl2h0kO
 jDteOeqMyuvJeBFslppWdQ9jirURtDKg1pc55gYBJDmKcW1Kmm/5+1dIjofBhlz4Vhlqh2
 JqhWHf178C2aNZHVdarr+w+3j/WO68Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-bh3kzI7kPNurSuxWYqNzTQ-1; Mon, 11 Nov 2019 04:44:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE1E7107ACC4;
 Mon, 11 Nov 2019 09:44:15 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB81E608EB;
 Mon, 11 Nov 2019 09:44:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: fix rst syntax errors in unbuilt docs
Date: Mon, 11 Nov 2019 09:44:11 +0000
Message-Id: <20191111094411.427174-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bh3kzI7kPNurSuxWYqNzTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The .rst files outside docs/{devel,interop,specs} aren't built yet and
therefore a few syntax errors have slipped through.  Fix them.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
Sent as a separate patch.  This used to be part of "[PATCH 0/3] docs:
build an index page for the HTML docs" but I'm changing the approach in
that series and this is now an independent fix.

 docs/arm-cpu-features.rst    |  6 +++---
 docs/virtio-net-failover.rst |  4 ++--
 docs/virtio-pmem.rst         | 19 ++++++++++---------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
index 1b367e22e1..9b537a75e6 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/arm-cpu-features.rst
@@ -41,9 +41,9 @@ CPU type is possible with the `query-cpu-model-expansion`=
 QMP command.
 Below are some examples where `scripts/qmp/qmp-shell` (see the top comment
 block in the script for usage) is used to issue the QMP commands.
=20
-(1) Determine which CPU features are available for the `max` CPU type
-    (Note, we started QEMU with qemu-system-aarch64, so `max` is
-     implementing the ARMv8-A reference manual in this case)::
+1. Determine which CPU features are available for the `max` CPU type
+   (Note, we started QEMU with qemu-system-aarch64, so `max` is
+   implementing the ARMv8-A reference manual in this case)::
=20
       (QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"max"}
       { "return": {
diff --git a/docs/virtio-net-failover.rst b/docs/virtio-net-failover.rst
index 22f64c7bc8..6002dc5d96 100644
--- a/docs/virtio-net-failover.rst
+++ b/docs/virtio-net-failover.rst
@@ -1,6 +1,6 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 QEMU virtio-net standby (net_failover)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 This document explains the setup and usage of virtio-net standby feature w=
hich
 is used to create a net_failover pair of devices.
diff --git a/docs/virtio-pmem.rst b/docs/virtio-pmem.rst
index e77881b26f..4bf5d00443 100644
--- a/docs/virtio-pmem.rst
+++ b/docs/virtio-pmem.rst
@@ -27,17 +27,18 @@ virtio pmem usage
 -----------------
=20
   A virtio pmem device backed by a memory-backend-file can be created on
-  the QEMU command line as in the following example:
+  the QEMU command line as in the following example::
=20
-  -object memory-backend-file,id=3Dmem1,share,mem-path=3D./virtio_pmem.img=
,size=3D4G
-  -device virtio-pmem-pci,memdev=3Dmem1,id=3Dnv1
+    -object memory-backend-file,id=3Dmem1,share,mem-path=3D./virtio_pmem.i=
mg,size=3D4G
+    -device virtio-pmem-pci,memdev=3Dmem1,id=3Dnv1
=20
-   where:
-   - "object memory-backend-file,id=3Dmem1,share,mem-path=3D<image>, size=
=3D<image size>"
-     creates a backend file with the specified size.
+  where:
=20
-   - "device virtio-pmem-pci,id=3Dnvdimm1,memdev=3Dmem1" creates a virtio =
pmem
-     pci device whose storage is provided by above memory backend device.
+  - "object memory-backend-file,id=3Dmem1,share,mem-path=3D<image>, size=
=3D<image size>"
+    creates a backend file with the specified size.
+
+  - "device virtio-pmem-pci,id=3Dnvdimm1,memdev=3Dmem1" creates a virtio p=
mem
+    pci device whose storage is provided by above memory backend device.
=20
   Multiple virtio pmem devices can be created if multiple pairs of "-objec=
t"
   and "-device" are provided.
@@ -50,7 +51,7 @@ memory backing has to be added via 'object_add'; afterwar=
ds, the virtio
 pmem device can be added via 'device_add'.
=20
 For example, the following commands add another 4GB virtio pmem device to
-the guest:
+the guest::
=20
  (qemu) object_add memory-backend-file,id=3Dmem2,share=3Don,mem-path=3Dvir=
tio_pmem2.img,size=3D4G
  (qemu) device_add virtio-pmem-pci,id=3Dvirtio_pmem2,memdev=3Dmem2
--=20
2.23.0


