Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D0C10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798472082E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798472082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53879 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFLyl-0002PR-Qi
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 12:58:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLuh-0007AZ-U4
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLuh-0002lg-09
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:53:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hFLue-0002jE-Ra; Sat, 13 Apr 2019 12:53:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E40381E1B;
	Sat, 13 Apr 2019 16:53:56 +0000 (UTC)
Received: from localhost (ovpn-204-66.brq.redhat.com [10.40.204.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9898F5D71A;
	Sat, 13 Apr 2019 16:53:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Sat, 13 Apr 2019 18:53:40 +0200
Message-Id: <20190413165343.9018-5-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-1-mreitz@redhat.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Sat, 13 Apr 2019 16:53:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/7] blkdebug: Add "none" event
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
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	"Denis V . Lunev" <den@openvz.org>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190413165340.zLw8Zvb__ymn87uiLjt3Lg_3gzFqxPAaLoxN_SZfQZc@z>

Together with @iotypes and @sector, this can be used to trap e.g. the
first read or write access to a certain sector without having to know
what happens internally in the block layer, i.e. which "real" events
happen right before such an access.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 4 +++-
 block/blkdebug.c     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5141e91172..717b13f7f5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3215,6 +3215,8 @@
 #
 # @cor_write: a write due to copy-on-read (since 2.11)
 #
+# @none: triggers once at creation of the blkdebug node (since 4.1)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -3233,7 +3235,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write'] }
+            'cor_write', 'none' ] }
=20
 ##
 # @BlkdebugIOType:
diff --git a/block/blkdebug.c b/block/blkdebug.c
index ca84b12e32..69c608be6f 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -491,6 +491,8 @@ static int blkdebug_open(BlockDriverState *bs, QDict =
*options, int flags,
         goto out;
     }
=20
+    bdrv_debug_event(bs, BLKDBG_NONE);
+
     ret =3D 0;
 out:
     if (ret < 0) {
--=20
2.20.1


