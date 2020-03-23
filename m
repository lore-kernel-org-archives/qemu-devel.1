Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CDDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EE22072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfnLXSZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EE22072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMXY-00051N-GT
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jGMWP-0003lz-UW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jGMWO-0000rf-Hq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jGMWO-0000rO-EF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584967776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VQ7BbtB+1AFo6p4ueEj9iJMoZbx51iqM2lDAspD+Uw=;
 b=BfnLXSZ4Cw2seJs+0c5UToyjsJwwc1NkiqTaCgPOHtfgY6OYjuCm8vEja953j0OCS8+jIf
 QZ02TfZ1/ooyNotOVI6bt35ZIeEHcgjWXGizHdOiBUaX56rJsLdnvLXUO1kyeqf0qvex7R
 3iq7vG9nOghfpG1xr7Ah+ew1cE17sDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-y3GI-rHVO9KqWXWFJ2C-Nw-1; Mon, 23 Mar 2020 08:49:33 -0400
X-MC-Unique: y3GI-rHVO9KqWXWFJ2C-Nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F07801E74;
 Mon, 23 Mar 2020 12:49:31 +0000 (UTC)
Received: from localhost (ovpn-113-18.ams2.redhat.com [10.36.113.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7142210027B6;
 Mon, 23 Mar 2020 12:49:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL for-5.0 1/2] Documentation: create/move s390x documentation
Date: Mon, 23 Mar 2020 13:49:22 +0100
Message-Id: <20200323124923.24014-2-cohuck@redhat.com>
In-Reply-To: <20200323124923.24014-1-cohuck@redhat.com>
References: <20200323124923.24014-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a subdirectory for s390x under docs/system/ and move the
existing vfio-ap documentation there.

Create an initial document describing s390x system emulation.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200318103940.1169-1-cohuck@redhat.com>
---
 MAINTAINERS                         |  5 +++--
 docs/system/index.rst               |  1 -
 docs/system/{ =3D> s390x}/vfio-ap.rst |  0
 docs/system/target-s390x.rst        | 26 ++++++++++++++++++++++++++
 docs/system/targets.rst             |  1 +
 5 files changed, 30 insertions(+), 3 deletions(-)
 rename docs/system/{ =3D> s390x}/vfio-ap.rst (100%)
 create mode 100644 docs/system/target-s390x.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b46f3c6a831..b5c86ec4946d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -101,7 +101,8 @@ F: include/hw/watchdog/wdt_diag288.h
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: target/s390x/
-F: docs/vfio-ap.txt
+F: docs/system/target-s390x.rst
+F: docs/system/s390x/
 F: tests/migration/s390x/
 K: ^Subject:.*(?i)s390x?
 T: git https://github.com/cohuck/qemu.git s390-next
@@ -1611,7 +1612,7 @@ F: hw/s390x/ap-bridge.c
 F: include/hw/s390x/ap-device.h
 F: include/hw/s390x/ap-bridge.h
 F: hw/vfio/ap.c
-F: docs/system/vfio-ap.rst
+F: docs/system/s390x/vfio-ap.rst
 L: qemu-s390x@nongnu.org
=20
 vhost
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 6e5f20fa1333..c0f685b818e5 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -30,7 +30,6 @@ Contents:
    managed-startup
    targets
    security
-   vfio-ap
    deprecated
    build-platforms
    license
diff --git a/docs/system/vfio-ap.rst b/docs/system/s390x/vfio-ap.rst
similarity index 100%
rename from docs/system/vfio-ap.rst
rename to docs/system/s390x/vfio-ap.rst
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
new file mode 100644
index 000000000000..4c8b7cdd6615
--- /dev/null
+++ b/docs/system/target-s390x.rst
@@ -0,0 +1,26 @@
+.. _s390x-System-emulator:
+
+s390x System emulator
+---------------------
+
+QEMU can emulate z/Architecture (in particular, 64 bit) s390x systems
+via the ``qemu-system-s390x`` binary. Only one machine type,
+``s390-ccw-virtio``, is supported (with versioning for compatibility
+handling).
+
+When using KVM as accelerator, QEMU can emulate CPUs up to the generation
+of the host. When using the default cpu model with TCG as accelerator,
+QEMU will emulate a subset of z13 cpu features that should be enough to ru=
n
+distributions built for the z13.
+
+Device support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+QEMU will not emulate most of the traditional devices found under LPAR or
+z/VM; virtio devices (especially using virtio-ccw) make up the bulk of
+the available devices. Passthrough of host devices via vfio-pci, vfio-ccw,
+or vfio-ap is also available.
+
+.. toctree::
+   s390x/vfio-ap
+
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
index eba3111247f6..0d8f91580aa5 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -17,3 +17,4 @@ Contents:
    target-arm
    target-m68k
    target-xtensa
+   target-s390x
--=20
2.21.1


