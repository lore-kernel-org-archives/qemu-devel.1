Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF41C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27E220578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27E220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1dM-00068t-VA
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:03:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bd-00053G-ED
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bY-0002T6-DO
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hO1bR-0002PO-NM; Tue, 07 May 2019 11:01:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A6C364464;
	Tue,  7 May 2019 15:01:57 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84FF05B0A5;
	Tue,  7 May 2019 15:01:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:01:49 -0500
Message-Id: <20190507150153.26859-2-eblake@redhat.com>
In-Reply-To: <20190507150153.26859-1-eblake@redhat.com>
References: <20190507150153.26859-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 07 May 2019 15:01:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/5] qemu-nbd: Look up flag names in array
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"open list:Network Block Dev..." <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

The existing code to convert flag bits into strings looks a bit strange
now, and if we ever add more flags, it will look even stranger.  Prevent
that from happening by making it look up the flag names in an array.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20190405191635.25740-1-mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 38 +++++++++++++++++++++++++------------
 qemu-nbd.c          | 46 +++++++++++++++++----------------------------
 2 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 6d05983a55f..bb9f5bc0216 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -127,18 +127,32 @@ typedef struct NBDExtent {

 /* Transmission (export) flags: sent from server to client during handsh=
ake,
    but describe what will happen during transmission */
-#define NBD_FLAG_HAS_FLAGS         (1 << 0) /* Flags are there */
-#define NBD_FLAG_READ_ONLY         (1 << 1) /* Device is read-only */
-#define NBD_FLAG_SEND_FLUSH        (1 << 2) /* Send FLUSH */
-#define NBD_FLAG_SEND_FUA          (1 << 3) /* Send FUA (Force Unit Acce=
ss) */
-#define NBD_FLAG_ROTATIONAL        (1 << 4) /* Use elevator algorithm -
-                                               rotational media */
-#define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
-#define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
-#define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment)=
 */
-#define NBD_FLAG_CAN_MULTI_CONN    (1 << 8) /* Multi-client cache consis=
tent */
-#define NBD_FLAG_SEND_RESIZE       (1 << 9) /* Send resize */
-#define NBD_FLAG_SEND_CACHE        (1 << 10) /* Send CACHE (prefetch) */
+enum {
+    NBD_FLAG_HAS_FLAGS_BIT          =3D  0, /* Flags are there */
+    NBD_FLAG_READ_ONLY_BIT          =3D  1, /* Device is read-only */
+    NBD_FLAG_SEND_FLUSH_BIT         =3D  2, /* Send FLUSH */
+    NBD_FLAG_SEND_FUA_BIT           =3D  3, /* Send FUA (Force Unit Acce=
ss) */
+    NBD_FLAG_ROTATIONAL_BIT         =3D  4, /* Use elevator algorithm -
+                                             rotational media */
+    NBD_FLAG_SEND_TRIM_BIT          =3D  5, /* Send TRIM (discard) */
+    NBD_FLAG_SEND_WRITE_ZEROES_BIT  =3D  6, /* Send WRITE_ZEROES */
+    NBD_FLAG_SEND_DF_BIT            =3D  7, /* Send DF (Do not Fragment)=
 */
+    NBD_FLAG_CAN_MULTI_CONN_BIT     =3D  8, /* Multi-client cache consis=
tent */
+    NBD_FLAG_SEND_RESIZE_BIT        =3D  9, /* Send resize */
+    NBD_FLAG_SEND_CACHE_BIT         =3D 10, /* Send CACHE (prefetch) */
+};
+
+#define NBD_FLAG_HAS_FLAGS         (1 << NBD_FLAG_HAS_FLAGS_BIT)
+#define NBD_FLAG_READ_ONLY         (1 << NBD_FLAG_READ_ONLY_BIT)
+#define NBD_FLAG_SEND_FLUSH        (1 << NBD_FLAG_SEND_FLUSH_BIT)
+#define NBD_FLAG_SEND_FUA          (1 << NBD_FLAG_SEND_FUA_BIT)
+#define NBD_FLAG_ROTATIONAL        (1 << NBD_FLAG_ROTATIONAL_BIT)
+#define NBD_FLAG_SEND_TRIM         (1 << NBD_FLAG_SEND_TRIM_BIT)
+#define NBD_FLAG_SEND_WRITE_ZEROES (1 << NBD_FLAG_SEND_WRITE_ZEROES_BIT)
+#define NBD_FLAG_SEND_DF           (1 << NBD_FLAG_SEND_DF_BIT)
+#define NBD_FLAG_CAN_MULTI_CONN    (1 << NBD_FLAG_CAN_MULTI_CONN_BIT)
+#define NBD_FLAG_SEND_RESIZE       (1 << NBD_FLAG_SEND_RESIZE_BIT)
+#define NBD_FLAG_SEND_CACHE        (1 << NBD_FLAG_SEND_CACHE_BIT)

 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
diff --git a/qemu-nbd.c b/qemu-nbd.c
index dca9e72ceee..081fcf74d5c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -279,37 +279,25 @@ static int qemu_nbd_client_list(SocketAddress *sadd=
r, QCryptoTLSCreds *tls,
             printf("  description: %s\n", list[i].description);
         }
         if (list[i].flags & NBD_FLAG_HAS_FLAGS) {
+            static const char *const flag_names[] =3D {
+                [NBD_FLAG_READ_ONLY_BIT]            =3D "readonly",
+                [NBD_FLAG_SEND_FLUSH_BIT]           =3D "flush",
+                [NBD_FLAG_SEND_FUA_BIT]             =3D "fua",
+                [NBD_FLAG_ROTATIONAL_BIT]           =3D "rotational",
+                [NBD_FLAG_SEND_TRIM_BIT]            =3D "trim",
+                [NBD_FLAG_SEND_WRITE_ZEROES_BIT]    =3D "zeroes",
+                [NBD_FLAG_SEND_DF_BIT]              =3D "df",
+                [NBD_FLAG_CAN_MULTI_CONN_BIT]       =3D "multi",
+                [NBD_FLAG_SEND_RESIZE_BIT]          =3D "resize",
+                [NBD_FLAG_SEND_CACHE_BIT]           =3D "cache",
+            };
+
             printf("  size:  %" PRIu64 "\n", list[i].size);
             printf("  flags: 0x%x (", list[i].flags);
-            if (list[i].flags & NBD_FLAG_READ_ONLY) {
-                printf(" readonly");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_FLUSH) {
-                printf(" flush");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_FUA) {
-                printf(" fua");
-            }
-            if (list[i].flags & NBD_FLAG_ROTATIONAL) {
-                printf(" rotational");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_TRIM) {
-                printf(" trim");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_WRITE_ZEROES) {
-                printf(" zeroes");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_DF) {
-                printf(" df");
-            }
-            if (list[i].flags & NBD_FLAG_CAN_MULTI_CONN) {
-                printf(" multi");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_RESIZE) {
-                printf(" resize");
-            }
-            if (list[i].flags & NBD_FLAG_SEND_CACHE) {
-                printf(" cache");
+            for (size_t bit =3D 0; bit < ARRAY_SIZE(flag_names); bit++) =
{
+                if (flag_names[bit] && (list[i].flags & (1 << bit))) {
+                    printf(" %s", flag_names[bit]);
+                }
             }
             printf(" )\n");
         }
--=20
2.20.1


