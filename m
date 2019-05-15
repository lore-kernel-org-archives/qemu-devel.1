Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E39C04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6A420818
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6A420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR114-0006Gf-77
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 17:00:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rZ-00062p-LR
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rY-0001JK-DB
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0rY-0001IS-53
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C3268553A;
	Wed, 15 May 2019 20:50:55 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80B415C557;
	Wed, 15 May 2019 20:50:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:20 +0200
Message-Id: <1557953433-19663-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 15 May 2019 20:50:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/21] memory: correct the comment to
 DIRTY_MEMORY_MIGRATION
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
Cc: Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

The dirty bit is DIRTY_MEMORY_MIGRATION. Correct the comment.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190426020927.25470-1-richardw.yang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index bb2b71e..3071c4b 100644
--- a/memory.c
+++ b/memory.c
@@ -2584,7 +2584,7 @@ void memory_global_dirty_log_start(void)
 
     MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
 
-    /* Refresh DIRTY_LOG_MIGRATION bit.  */
+    /* Refresh DIRTY_MEMORY_MIGRATION bit.  */
     memory_region_transaction_begin();
     memory_region_update_pending = true;
     memory_region_transaction_commit();
@@ -2594,7 +2594,7 @@ static void memory_global_dirty_log_do_stop(void)
 {
     global_dirty_log = false;
 
-    /* Refresh DIRTY_LOG_MIGRATION bit.  */
+    /* Refresh DIRTY_MEMORY_MIGRATION bit.  */
     memory_region_transaction_begin();
     memory_region_update_pending = true;
     memory_region_transaction_commit();
-- 
1.8.3.1



