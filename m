Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1394C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FCD20786
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbJIZOB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FCD20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0APe-0004Hq-37
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAp-0005um-Jz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAo-00053M-0A
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3HGKl7Xu7uAqUHOkXtf9D5rZqcQtEe5Y64LPYPFuQz4=;
 b=fbJIZOB2EHKZgxid66e9h7YdoCvhZuRM7SCrwTFqO+vxOcxUnGJejCuaLBJ6WzNvJyjC9k
 DxuMLKdMCwa7aaiuSwsM1NCbsobfI7fKgu3+nuHjkUzcfA74myLD1D1US+vKa6zjssf0c9
 16EgkF6KvFKFVaPik2imwHB03bqqAPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-Q9y4uWpcMdCpDgIQ3MDE0g-1; Mon, 27 Jul 2020 16:56:34 -0400
X-MC-Unique: Q9y4uWpcMdCpDgIQ3MDE0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4312258;
 Mon, 27 Jul 2020 20:56:33 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 277F019C66;
 Mon, 27 Jul 2020 20:56:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/24] migration: Fix typos in bitmap migration comments
Date: Mon, 27 Jul 2020 15:55:43 -0500
Message-Id: <20200727205543.206624-25-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Noticed while reviewing the file for newer patches.

Fixes: b35ebdf076
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727203206.134996-1-eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1f675b792fc9..784330ebe130 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -97,7 +97,7 @@

 #define DIRTY_BITMAP_MIG_START_FLAG_ENABLED          0x01
 #define DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT       0x02
-/* 0x04 was "AUTOLOAD" flags on elder versions, no it is ignored */
+/* 0x04 was "AUTOLOAD" flags on older versions, now it is ignored */
 #define DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK    0xf8

 /* State of one bitmap during save process */
@@ -180,7 +180,7 @@ static uint32_t qemu_get_bitmap_flags(QEMUFile *f)

 static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
 {
-    /* The code currently do not send flags more than one byte */
+    /* The code currently does not send flags as more than one byte */
     assert(!(flags & (0xffffff00 | DIRTY_BITMAP_MIG_EXTRA_FLAGS)));

     qemu_put_byte(f, flags);
-- 
2.27.0


