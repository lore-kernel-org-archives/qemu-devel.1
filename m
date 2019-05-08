Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD3C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB25214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB25214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60066 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFtR-0002Vu-Jm
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:17:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hOFrd-0000Zl-SW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hOFrc-0003s5-Su
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hOFrc-0003qP-NY
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14A5530970CF
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 06:15:36 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 025E116BF0;
	Wed,  8 May 2019 06:15:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 14:15:14 +0800
Message-Id: <20190508061523.17666-3-peterx@redhat.com>
In-Reply-To: <20190508061523.17666-1-peterx@redhat.com>
References: <20190508061523.17666-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 08 May 2019 06:15:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/11] memory: Remove memory_region_get_dirty()
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's never used anywhere.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 17 -----------------
 memory.c              |  8 --------
 2 files changed, 25 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9144a47f57..e6140e8a04 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1254,23 +1254,6 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
  */
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client);
 
-/**
- * memory_region_get_dirty: Check whether a range of bytes is dirty
- *                          for a specified client.
- *
- * Checks whether a range of bytes has been written to since the last
- * call to memory_region_reset_dirty() with the same @client.  Dirty logging
- * must be enabled.
- *
- * @mr: the memory region being queried.
- * @addr: the address (relative to the start of the region) being queried.
- * @size: the size of the range being queried.
- * @client: the user of the logging information; %DIRTY_MEMORY_MIGRATION or
- *          %DIRTY_MEMORY_VGA.
- */
-bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
-                             hwaddr size, unsigned client);
-
 /**
  * memory_region_set_dirty: Mark a range of bytes as dirty in a memory region.
  *
diff --git a/memory.c b/memory.c
index bb2b71ee38..0cce3a6fc5 100644
--- a/memory.c
+++ b/memory.c
@@ -2027,14 +2027,6 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
     memory_region_transaction_commit();
 }
 
-bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
-                             hwaddr size, unsigned client)
-{
-    assert(mr->ram_block);
-    return cpu_physical_memory_get_dirty(memory_region_get_ram_addr(mr) + addr,
-                                         size, client);
-}
-
 void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size)
 {
-- 
2.17.1


