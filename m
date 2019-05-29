Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0368C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F0D23A5A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F0D23A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVziW-0006vd-0G
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 10:38:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hVzcP-0002ud-Pv
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hVzcO-0004ja-Ap
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hVzcN-0004Qn-Qs
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:31:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B37C81123;
	Wed, 29 May 2019 14:31:29 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-181.brq.redhat.com
	[10.40.204.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0369217CDF;
	Wed, 29 May 2019 14:31:25 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 16:31:05 +0200
Message-Id: <20190529143106.11789-4-lvivier@redhat.com>
In-Reply-To: <20190529143106.11789-1-lvivier@redhat.com>
References: <20190529143106.11789-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 29 May 2019 14:31:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v7 3/4] virtio-rng: Keep the default backend
 out of VirtIORNGConf
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
	Kashyap Chamarthy <kchamart@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

The default backend is only used within virtio_rng_device_realize().
Replace VirtIORNGConf member default_backend by a local variable.
Adjust its type to reduce conversions.

While there, pass &error_abort instead of NULL when failure would be a
programming error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/virtio-rng.c         | 20 +++++++++-----------
 include/hw/virtio/virtio-rng.h |  2 --
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 30493a258622..73ffb476e030 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -16,6 +16,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
+#include "sysemu/rng-random.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
=20
@@ -189,27 +190,24 @@ static void virtio_rng_device_realize(DeviceState *=
dev, Error **errp)
     }
=20
     if (vrng->conf.rng =3D=3D NULL) {
-        vrng->conf.default_backend =3D RNG_RANDOM(object_new(TYPE_RNG_RA=
NDOM));
+        Object *default_backend =3D object_new(TYPE_RNG_RANDOM);
=20
-        user_creatable_complete(USER_CREATABLE(vrng->conf.default_backen=
d),
+        user_creatable_complete(USER_CREATABLE(default_backend),
                                 &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            object_unref(OBJECT(vrng->conf.default_backend));
+            object_unref(default_backend);
             return;
         }
=20
-        object_property_add_child(OBJECT(dev),
-                                  "default-backend",
-                                  OBJECT(vrng->conf.default_backend),
-                                  NULL);
+        object_property_add_child(OBJECT(dev), "default-backend",
+                                  default_backend, &error_abort);
=20
         /* The child property took a reference, we can safely drop ours =
now */
-        object_unref(OBJECT(vrng->conf.default_backend));
+        object_unref(default_backend);
=20
-        object_property_set_link(OBJECT(dev),
-                                 OBJECT(vrng->conf.default_backend),
-                                 "rng", NULL);
+        object_property_set_link(OBJECT(dev), default_backend,
+                                 "rng", &error_abort);
     }
=20
     vrng->rng =3D vrng->conf.rng;
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rn=
g.h
index 922dce7caccf..28ff752c4096 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -13,7 +13,6 @@
 #define QEMU_VIRTIO_RNG_H
=20
 #include "sysemu/rng.h"
-#include "sysemu/rng-random.h"
 #include "standard-headers/linux/virtio_rng.h"
=20
 #define TYPE_VIRTIO_RNG "virtio-rng-device"
@@ -26,7 +25,6 @@ struct VirtIORNGConf {
     RngBackend *rng;
     uint64_t max_bytes;
     uint32_t period_ms;
-    RngRandom *default_backend;
 };
=20
 typedef struct VirtIORNG {
--=20
2.20.1


