Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1814F20809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjEe2R+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1814F20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ADb-0001rh-9g
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAa-0005Lx-1L
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAT-0004xw-I2
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVx0VAHepZVGUOdQt72FjQmlLnKaNCNllgZ9kWYIfkg=;
 b=GjEe2R+zGSqrQnFFWXLPGCcDSN4m7GHdKO9LmoHuRpwnSl5/+VTdObUtRMdC8jdy6QqZ3A
 d4/+MvccV1ZeWyEB2Gj7+nWLtLslvFQUMFD1HA4s1N1d60Z12RIQ65xkCHFDg1EH0soxLI
 f9ywAvcguMgYrMcg4L0jfJPmrC7Dg6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-DjFWZ96TPdeaV_Xv6jOI9Q-1; Mon, 27 Jul 2020 16:56:09 -0400
X-MC-Unique: DjFWZ96TPdeaV_Xv6jOI9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9995B101C8A0;
 Mon, 27 Jul 2020 20:56:08 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65EF419D82;
 Mon, 27 Jul 2020 20:56:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/24] migration/block-dirty-bitmap: rename
 dirty_bitmap_mig_cleanup
Date: Mon, 27 Jul 2020 15:55:29 -0500
Message-Id: <20200727205543.206624-11-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block I/O path" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rename dirty_bitmap_mig_cleanup to dirty_bitmap_do_save_cleanup, to
stress that it is on save part.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727194236.19551-10-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1d57bff4f6c7..01a536d7d3d3 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -259,7 +259,7 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
 }

 /* Called with iothread lock taken.  */
-static void dirty_bitmap_mig_cleanup(void)
+static void dirty_bitmap_do_save_cleanup(void)
 {
     SaveBitmapState *dbms;

@@ -406,7 +406,7 @@ static int init_dirty_bitmap_migration(void)

 fail:
     g_hash_table_destroy(handled_by_blk);
-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();

     return -1;
 }
@@ -445,7 +445,7 @@ static void bulk_phase(QEMUFile *f, bool limit)
 /* for SaveVMHandlers */
 static void dirty_bitmap_save_cleanup(void *opaque)
 {
-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();
 }

 static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
@@ -480,7 +480,7 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)

     trace_dirty_bitmap_save_complete_finish();

-    dirty_bitmap_mig_cleanup();
+    dirty_bitmap_do_save_cleanup();
     return 0;
 }

-- 
2.27.0


