Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2B0C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6D72075C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKHT7HUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6D72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51351 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT15R-0004X6-VP
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iT13d-00033h-SG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iT13c-0002p0-Ju
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iT13c-0002oq-GK
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573207196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umIrZIG9AS0Nt7/2OGXULYv8N+vCjN5xNv+pE94xXYg=;
 b=AKHT7HULugOaY0d8YMF0Iob5vCPdAMpPpnTntux9PpgrOYCt3SbPlvpp+7OSwS0flscz/H
 AX6pBTYsrIQqw/N0o7tJZdA8MdHCmP9YjazR+wmroAUJRKArL+/oArcdMUHIrncnBoT/xT
 7vOykH15LHvUfx3Qf9jGqwxMrdFDkIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-QBP403k_O-qjUhYV1Nc_vw-1; Fri, 08 Nov 2019 04:59:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A5FA800A1A;
 Fri,  8 Nov 2019 09:59:51 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75B3E271B2;
 Fri,  8 Nov 2019 09:59:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] docs: fix rst syntax errors in unbuilt docs
Date: Fri,  8 Nov 2019 10:59:40 +0100
Message-Id: <20191108095942.401225-2-stefanha@redhat.com>
In-Reply-To: <20191108095942.401225-1-stefanha@redhat.com>
References: <20191108095942.401225-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: QBP403k_O-qjUhYV1Nc_vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The .rst files outside docs/{devel,interop,specs} aren't built yet and
therefore a few syntax errors have slipped through.  Fix them.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
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


