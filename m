Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87525C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63735208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63735208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhp2-0001yu-H5
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:31:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhmy-0000jR-J2
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhmn-0000gB-Vg
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhmP-0008Ul-M6; Tue, 28 May 2019 15:29:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7ACC3082134;
	Tue, 28 May 2019 19:28:51 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B5DD1972B;
	Tue, 28 May 2019 19:28:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:27 +0200
Message-Id: <20190528192847.2730-2-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 28 May 2019 19:28:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/21] qcow2.h: add missing include
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

qcow2.h depends on block_int.h. Compilation isn't broken currently only
due to block_int.h always included before qcow2.h. Though, it seems
better to directly include block_int.h in qcow2.h.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190506142741.41731-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          | 1 +
 block/qcow2-bitmap.c   | 1 -
 block/qcow2-cache.c    | 1 -
 block/qcow2-cluster.c  | 1 -
 block/qcow2-refcount.c | 1 -
 block/qcow2-snapshot.c | 1 -
 block/qcow2.c          | 1 -
 7 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 8d92ef1fee..c2b0e955eb 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -28,6 +28,7 @@
 #include "crypto/block.h"
 #include "qemu/coroutine.h"
 #include "qemu/units.h"
+#include "block/block_int.h"
=20
 //#define DEBUG_ALLOC
 //#define DEBUG_ALLOC2
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 8a75366c92..640da68ce1 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
=20
-#include "block/block_int.h"
 #include "qcow2.h"
=20
 /* NOTICE: BME here means Bitmaps Extension and used as a namespace for
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index df02e7b20a..b33bcbc984 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "block/block_int.h"
 #include "qemu-common.h"
 #include "qcow2.h"
 #include "trace.h"
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index b36f4aa84a..a4c878398e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -27,7 +27,6 @@
=20
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "block/block_int.h"
 #include "qcow2.h"
 #include "qemu/bswap.h"
 #include "trace.h"
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 0b09d6838b..4c1794f9af 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "block/block_int.h"
 #include "qcow2.h"
 #include "qemu/range.h"
 #include "qemu/bswap.h"
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index a6ffae89a6..d0e7fa9311 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "block/block_int.h"
 #include "qcow2.h"
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index d39882785d..38bf729a1e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -27,7 +27,6 @@
 #define ZLIB_CONST
 #include <zlib.h>
=20
-#include "block/block_int.h"
 #include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
--=20
2.21.0


