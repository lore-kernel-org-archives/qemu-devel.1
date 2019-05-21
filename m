Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78FAC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E7E21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E7E21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5ae-0000S9-47
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:18:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hT5Uj-0005CU-Ai
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hT5Uh-0000m2-HP
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hT5Uh-0000lC-CD
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:11:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80E46C130719;
	Tue, 21 May 2019 14:11:53 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.205.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 015425E7AF;
	Tue, 21 May 2019 14:11:50 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 16:11:33 +0200
Message-Id: <20190521141133.27380-5-lvivier@redhat.com>
In-Reply-To: <20190521141133.27380-1-lvivier@redhat.com>
References: <20190521141133.27380-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 21 May 2019 14:11:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 4/4] virtio-rng: change default backend to
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
	Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 backends/rng-builtin.c | 1 -
 hw/virtio/virtio-rng.c | 3 +--
 include/sysemu/rng.h   | 2 ++
 qemu-options.hx        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
index 6b9543a7de87..868055cbc723 100644
--- a/backends/rng-builtin.c
+++ b/backends/rng-builtin.c
@@ -10,7 +10,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
=20
-#define TYPE_RNG_BUILTIN "rng-builtin"
 #define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTI=
N)
=20
 typedef struct RngBuiltin {
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 73ffb476e030..55745f75a1c9 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -16,7 +16,6 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
-#include "sysemu/rng-random.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
=20
@@ -190,7 +189,7 @@ static void virtio_rng_device_realize(DeviceState *de=
v, Error **errp)
     }
=20
     if (vrng->conf.rng =3D=3D NULL) {
-        Object *default_backend =3D object_new(TYPE_RNG_RANDOM);
+        Object *default_backend =3D object_new(TYPE_RNG_BUILTIN);
=20
         user_creatable_complete(USER_CREATABLE(default_backend),
                                 &local_err);
diff --git a/include/sysemu/rng.h b/include/sysemu/rng.h
index 27b37da05d2e..9dc5e0e90100 100644
--- a/include/sysemu/rng.h
+++ b/include/sysemu/rng.h
@@ -24,6 +24,8 @@
 #define RNG_BACKEND_CLASS(klass) \
     OBJECT_CLASS_CHECK(RngBackendClass, (klass), TYPE_RNG_BACKEND)
=20
+#define TYPE_RNG_BUILTIN "rng-builtin"
+
 typedef struct RngRequest RngRequest;
 typedef struct RngBackendClass RngBackendClass;
 typedef struct RngBackend RngBackend;
diff --git a/qemu-options.hx b/qemu-options.hx
index d5233e189ceb..cd1c68d8dc9a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4325,7 +4325,7 @@ The @option{share} boolean option is @var{on} by de=
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
--=20
2.20.1


