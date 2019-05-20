Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41202C04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165902081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165902081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57101 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSYpp-0001iH-Am
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 23:19:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSYfr-00026C-6W
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSYfq-0001jj-8k
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hSYfq-0001iw-10
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BE288667D
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:09:13 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42EB41001E73;
	Mon, 20 May 2019 03:09:11 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 11:08:33 +0800
Message-Id: <20190520030839.6795-10-peterx@redhat.com>
In-Reply-To: <20190520030839.6795-1-peterx@redhat.com>
References: <20190520030839.6795-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 20 May 2019 03:09:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 09/15] kvm: Update comments for
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


