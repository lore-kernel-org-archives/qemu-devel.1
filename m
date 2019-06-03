Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C775C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E8027C56
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E8027C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgt9-0002hE-DG
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 02:56:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgoa-0007nf-2J
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXgoZ-0002L1-2p
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hXgoY-0002KQ-Tr
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:51:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F7B8330259
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 06:51:26 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 599A64E6AA;
	Mon,  3 Jun 2019 06:51:22 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 14:50:52 +0800
Message-Id: <20190603065056.25211-8-peterx@redhat.com>
In-Reply-To: <20190603065056.25211-1-peterx@redhat.com>
References: <20190603065056.25211-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 03 Jun 2019 06:51:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 07/11] kvm: Update comments for
 sync_dirty_bitmap
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

It's obviously obsolete.  Do some update.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 524c4ddfbd..b686531586 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -473,13 +473,13 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
 
 /**
- * kvm_physical_sync_dirty_bitmap - Grab dirty bitmap from kernel space
- * This function updates qemu's dirty bitmap using
- * memory_region_set_dirty().  This means all bits are set
- * to dirty.
+ * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
- * @start_add: start of logged region.
- * @end_addr: end of logged region.
+ * This function will first try to fetch dirty bitmap from the kernel,
+ * and then updates qemu's dirty bitmap.
+ *
+ * @kml: the KVM memory listener object
+ * @section: the memory section to sync the dirty bitmap with
  */
 static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
                                           MemoryRegionSection *section)
-- 
2.17.1


