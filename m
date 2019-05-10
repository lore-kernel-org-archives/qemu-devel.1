Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62BCC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB732216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB732216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5os-0003kU-UE
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:44:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hP5nV-0002sI-QR
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hP5nT-0007xz-PW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hP5nP-0007fn-W9
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:42:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 300D583F44;
	Fri, 10 May 2019 13:42:42 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.205.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB1411018A2A;
	Fri, 10 May 2019 13:42:22 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 15:42:03 +0200
Message-Id: <20190510134203.24012-4-lvivier@redhat.com>
In-Reply-To: <20190510134203.24012-1-lvivier@redhat.com>
References: <20190510134203.24012-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 10 May 2019 13:42:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/3] virtio-rng: change default backend to
 rng-builtin
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>,
	"Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 backends/rng-builtin.c         |  8 +++-----
 hw/virtio/virtio-rng.c         |  2 +-
 include/hw/virtio/virtio-rng.h |  4 ++--
 include/sysemu/rng-builtin.h   | 17 +++++++++++++++++
 qemu-options.hx                |  5 ++---
 5 files changed, 25 insertions(+), 11 deletions(-)
 create mode 100644 include/sysemu/rng-builtin.h

diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
index b1264b745407..27675301933b 100644
--- a/backends/rng-builtin.c
+++ b/backends/rng-builtin.c
@@ -7,17 +7,15 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/rng.h"
+#include "sysemu/rng-builtin.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
=20
-#define TYPE_RNG_BUILTIN "rng-builtin"
-#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTI=
N)
-
-typedef struct RngBuiltin {
+struct RngBuiltin {
     RngBackend parent;
-} RngBuiltin;
+};
=20
 static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
 {
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 30493a258622..67209f63ddbc 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -189,7 +189,7 @@ static void virtio_rng_device_realize(DeviceState *de=
v, Error **errp)
     }
=20
     if (vrng->conf.rng =3D=3D NULL) {
-        vrng->conf.default_backend =3D RNG_RANDOM(object_new(TYPE_RNG_RA=
NDOM));
+        vrng->conf.default_backend =3D RNG_BUILTIN(object_new(TYPE_RNG_B=
UILTIN));
=20
         user_creatable_complete(USER_CREATABLE(vrng->conf.default_backen=
d),
                                 &local_err);
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rn=
g.h
index 922dce7caccf..f9b6339b19a4 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -13,7 +13,7 @@
 #define QEMU_VIRTIO_RNG_H
=20
 #include "sysemu/rng.h"
-#include "sysemu/rng-random.h"
+#include "sysemu/rng-builtin.h"
 #include "standard-headers/linux/virtio_rng.h"
=20
 #define TYPE_VIRTIO_RNG "virtio-rng-device"
@@ -26,7 +26,7 @@ struct VirtIORNGConf {
     RngBackend *rng;
     uint64_t max_bytes;
     uint32_t period_ms;
-    RngRandom *default_backend;
+    RngBuiltin *default_backend;
 };
=20
 typedef struct VirtIORNG {
diff --git a/include/sysemu/rng-builtin.h b/include/sysemu/rng-builtin.h
new file mode 100644
index 000000000000..a0f75f97dde8
--- /dev/null
+++ b/include/sysemu/rng-builtin.h
@@ -0,0 +1,17 @@
+/*
+ * QEMU Builtin Random Number Generator Backend
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef QEMU_RNG_BUILTIN_H
+#define QEMU_RNG_BUILTIN_H
+
+#include "qom/object.h"
+
+#define TYPE_RNG_BUILTIN "rng-builtin"
+#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTI=
N)
+
+typedef struct RngBuiltin RngBuiltin;
+
+#endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 6ab920f12be4..c9784be83cb5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4285,7 +4285,7 @@ The @option{share} boolean option is @var{on} by de=
fault with memfd.
 Creates a random number generator backend which obtains entropy from
 QEMU builtin functions. The @option{id} parameter is a unique ID that
 will be used to reference this entropy backend from the @option{virtio-r=
ng}
-device.
+device. By default, the @option{virtio-rng} device uses this RNG backend=
.
=20
 @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
=20
@@ -4293,8 +4293,7 @@ Creates a random number generator backend which obt=
ains entropy from
 a device on the host. The @option{id} parameter is a unique ID that
 will be used to reference this entropy backend from the @option{virtio-r=
ng}
 device. The @option{filename} parameter specifies which file to obtain
-entropy from and if omitted defaults to @option{/dev/urandom}. By defaul=
t,
-the @option{virtio-rng} device uses this RNG backend.
+entropy from and if omitted defaults to @option{/dev/urandom}.
=20
 @item -object rng-egd,id=3D@var{id},chardev=3D@var{chardevid}
=20
--=20
2.20.1


