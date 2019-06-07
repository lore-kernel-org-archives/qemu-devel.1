Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54131C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326EE208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326EE208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJ4U-0001zi-G7
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54779)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZH0Q-0004Xb-LN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZGlq-0000Th-Ur
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZGlq-0008PQ-4N
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:27:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A195A9FFC2
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 15:26:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7436180DBB
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 15:26:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 196221138538; Fri,  7 Jun 2019 17:26:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 17:26:43 +0200
Message-Id: <20190607152646.4822-10-armbru@redhat.com>
In-Reply-To: <20190607152646.4822-1-armbru@redhat.com>
References: <20190607152646.4822-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 15:26:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/12] Clean up a header guard symbols (again)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit d52c454aad "contrib: add vhost-user-gpu" and "c68082c43a
virtio-gpu: split virtio-gpu-pci & virtio-vga" created headers with
unusual header guard symbols.  Clean them up

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190607141321.9726-1-armbru@redhat.com>
---
 contrib/vhost-user-gpu/virgl.h | 5 +++--
 contrib/vhost-user-gpu/vugbm.h | 5 +++--
 contrib/vhost-user-gpu/vugpu.h | 5 +++--
 hw/display/virtio-vga.h        | 6 +++---
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/contrib/vhost-user-gpu/virgl.h b/contrib/vhost-user-gpu/virg=
l.h
index f952bc9d4f..17078783a5 100644
--- a/contrib/vhost-user-gpu/virgl.h
+++ b/contrib/vhost-user-gpu/virgl.h
@@ -11,8 +11,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
-#ifndef VUGPU_VIRGL_H_
-#define VUGPU_VIRGL_H_
+
+#ifndef VUGPU_VIRGL_H
+#define VUGPU_VIRGL_H
=20
 #include "vugpu.h"
=20
diff --git a/contrib/vhost-user-gpu/vugbm.h b/contrib/vhost-user-gpu/vugb=
m.h
index c0bf27af9b..07e698fcd7 100644
--- a/contrib/vhost-user-gpu/vugbm.h
+++ b/contrib/vhost-user-gpu/vugbm.h
@@ -6,8 +6,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
-#ifndef VHOST_USER_GPU_GBM_H
-#define VHOST_USER_GPU_GBM_H
+
+#ifndef VHOST_USER_GPU_VUGBM_H
+#define VHOST_USER_GPU_VUGBM_H
=20
 #include "qemu/osdep.h"
=20
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugp=
u.h
index 458e92a1b3..3153c9a6de 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -11,8 +11,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
-#ifndef VUGPU_H_
-#define VUGPU_H_
+
+#ifndef VUGPU_H
+#define VUGPU_H
=20
 #include "qemu/osdep.h"
=20
diff --git a/hw/display/virtio-vga.h b/hw/display/virtio-vga.h
index c10bf390aa..c41281a010 100644
--- a/hw/display/virtio-vga.h
+++ b/hw/display/virtio-vga.h
@@ -1,5 +1,5 @@
-#ifndef VIRTIO_VGA_H_
-#define VIRTIO_VGA_H_
+#ifndef VIRTIO_VGA_H
+#define VIRTIO_VGA_H
=20
 #include "hw/virtio/virtio-gpu-pci.h"
 #include "vga_int.h"
@@ -29,4 +29,4 @@ typedef struct VirtIOVGABaseClass {
     DeviceReset parent_reset;
 } VirtIOVGABaseClass;
=20
-#endif /* VIRTIO_VGA_H_ */
+#endif /* VIRTIO_VGA_H */
--=20
2.21.0


