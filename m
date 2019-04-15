Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7155EC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 06:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429F420693
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 06:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429F420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45717 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFvTE-0006lK-De
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 02:52:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1hFvSQ-0006UT-VG
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1hFvSO-0005Xm-Bq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:51:09 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:6492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wang.yi59@zte.com.cn>)
	id 1hFvSM-0005Qf-Fi
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:51:08 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
	by Forcepoint Email with ESMTPS id B42A073F2F93EA1D222D;
	Mon, 15 Apr 2019 14:50:49 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
	by mse01.zte.com.cn with ESMTP id x3F6ogFl006379;
	Mon, 15 Apr 2019 14:50:42 +0800 (GMT-8)
	(envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
	by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2019041514504782-8694789 ;
	Mon, 15 Apr 2019 14:50:47 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: quintela@redhat.com
Date: Mon, 15 Apr 2019 14:51:29 +0800
Message-Id: <1555311089-18610-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
	8.5.3FP6|November 21, 2013) at 2019-04-15 14:50:47,
	Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17,
	2016) at 2019-04-15 14:50:41,
	Serialize complete at 2019-04-15 14:50:41
X-MAIL: mse01.zte.com.cn x3F6ogFl006379
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.217.80.70
Subject: [Qemu-devel] [PATCH] migration: update comments of migration bitmap
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415065129.lTUdssWKAarnJZWTzXijUD5IzBqVlIjt8pu9npOkmf4@z>

Since the ram bitmap and the unsent bitmap are split by RAMBlock
in commit 6b6712e, it's better to update the comments about them.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 migration/ram.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1ca9ba7..24ab23d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1630,8 +1630,6 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
 /**
  * migration_bitmap_find_dirty: find the next dirty page from start
  *
- * Called with rcu_read_lock() to protect migration_bitmap
- *
  * Returns the byte offset within memory region of the start of a dirty page
  *
  * @rs: current RAM state
@@ -2681,7 +2679,7 @@ static void ram_save_cleanup(void *opaque)
     RAMBlock *block;
 
     /* caller have hold iothread lock or is in a bh, so there is
-     * no writing race against this migration_bitmap
+     * no writing race against the migration bitmap
      */
     memory_global_dirty_log_stop();
 
-- 
1.8.3.1


