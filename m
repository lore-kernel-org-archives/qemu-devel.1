Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3B1C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240FC206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240FC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1Qr-0001U0-5W
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hn1PM-0003aD-Ss
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hn1PL-0003at-Pe
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hn1PL-0003aR-Ju
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB6A430C0DD0;
 Mon, 15 Jul 2019 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53D2A5D772;
 Mon, 15 Jul 2019 13:52:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 15:51:17 +0200
Message-Id: <20190715135125.17770-14-quintela@redhat.com>
In-Reply-To: <20190715135125.17770-1-quintela@redhat.com>
References: <20190715135125.17770-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 15 Jul 2019 13:52:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/21] kvm: Update comments for sync_dirty_bitmap
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

It's obviously obsolete.  Do some update.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190603065056.25211-8-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3d86ae5052..a3df19da56 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -478,13 +478,13 @@ static int kvm_get_dirty_pages_log_range(MemoryRegi=
onSection *section,
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
=20
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
--=20
2.21.0


