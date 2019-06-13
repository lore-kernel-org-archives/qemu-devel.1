Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6178C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8012082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8012082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTQ5-0000MM-V5
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbRyN-0002qj-0u
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbRy9-0006Xn-2o
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hbRy5-0006UU-NN; Thu, 13 Jun 2019 11:48:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1FC830860BD;
 Thu, 13 Jun 2019 15:48:48 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40AA75C6D6;
 Thu, 13 Jun 2019 15:48:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 10:48:34 -0500
Message-Id: <20190613154837.21734-7-eblake@redhat.com>
In-Reply-To: <20190613154837.21734-1-eblake@redhat.com>
References: <20190613154837.21734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 13 Jun 2019 15:48:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/9] nbd/server: Nicer spelling of max
 BLOCK_STATUS reply length
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 3d068aff (3.0) introduced NBD_MAX_BITMAP_EXTENTS as a limit on
how large we would allow a reply to NBD_CMD_BLOCK_STATUS to grow when
it is visiting a qemu:dirty-bitmap: context.  Later, commit fb7afc79
(3.1) reused the constant to limit base:allocation context replies,
although the name is now less appropriate in that situation.

Rename things, and improve the macro to use units.h for better
legibility. Then reformat the comment to comply with checkpatch rules
added in the meantime. No semantic change.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190510151735.29687-1-eblake@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index aeca3893fe2b..10faedcfc55d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -21,15 +21,18 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "nbd-internal.h"
+#include "qemu/units.h"

 #define NBD_META_ID_BASE_ALLOCATION 0
 #define NBD_META_ID_DIRTY_BITMAP 1

-/* NBD_MAX_BITMAP_EXTENTS: 1 mb of extents data. An empirical
+/*
+ * NBD_MAX_BLOCK_STATUS_EXTENTS: 1 MiB of extents data. An empirical
  * constant. If an increase is needed, note that the NBD protocol
  * recommends no larger than 32 mb, so that the client won't consider
- * the reply as a denial of service attack. */
-#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8)
+ * the reply as a denial of service attack.
+ */
+#define NBD_MAX_BLOCK_STATUS_EXTENTS (1 * MiB / 8)

 static int system_errno_to_nbd_errno(int err)
 {
@@ -1960,7 +1963,7 @@ static int nbd_co_send_block_status(NBDClient *clie=
nt, uint64_t handle,
                                     Error **errp)
 {
     int ret;
-    unsigned int nb_extents =3D dont_fragment ? 1 : NBD_MAX_BITMAP_EXTEN=
TS;
+    unsigned int nb_extents =3D dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS=
_EXTENTS;
     NBDExtent *extents =3D g_new(NBDExtent, nb_extents);
     uint64_t final_length =3D length;

@@ -2045,7 +2048,7 @@ static int nbd_co_send_bitmap(NBDClient *client, ui=
nt64_t handle,
                               uint32_t context_id, Error **errp)
 {
     int ret;
-    unsigned int nb_extents =3D dont_fragment ? 1 : NBD_MAX_BITMAP_EXTEN=
TS;
+    unsigned int nb_extents =3D dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS=
_EXTENTS;
     NBDExtent *extents =3D g_new(NBDExtent, nb_extents);
     uint64_t final_length =3D length;

--=20
2.20.1


