Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272DFC433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B9D2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amcOvU3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B9D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09nv-0008Ug-8d
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k09nI-0007zl-Kq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:32:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41324
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k09nH-0001y3-3j
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595881938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nYbD8w7rv8LzeUcn46UwiVi/CXwxDqNtjF39tHuyKQ8=;
 b=amcOvU3zzQFhcYQbvs3CL+JFa1iGG6DNVeajTloormUm3yygFau2IbFy/HxyW0b1b2qmp4
 svMeO6mqSFiU9fw3dQ26MsRHa5sNISC8yO8Vavg5UsKcxeDtM/tg2Ktti8m7uLeByGa1ki
 6N0gb39fqoIlbW8TkyoBBSRHPxjkhHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-FRB1OZ9VN5Wov7caTu4A0A-1; Mon, 27 Jul 2020 16:32:14 -0400
X-MC-Unique: FRB1OZ9VN5Wov7caTu4A0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64B68106B242;
 Mon, 27 Jul 2020 20:32:13 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3E5419D82;
 Mon, 27 Jul 2020 20:32:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration: Fix typos in bitmap migration comments
Date: Mon, 27 Jul 2020 15:32:06 -0500
Message-Id: <20200727203206.134996-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Noticed while reviewing the file for newer patches.

Fixes: b35ebdf076
Signed-off-by: Eric Blake <eblake@redhat.com>
---

This is trivial enough that I'll throw it in my pull request today.

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


