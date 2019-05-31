Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C4CC28CC0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 02:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283842620A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 02:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283842620A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWXX9-0002Z9-7U
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 22:44:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWXWR-00027t-Fq
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWXWQ-0003Rq-DQ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hWXWQ-0003Nx-7j
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B07AA36893
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 02:43:56 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C5A861001E64;
	Fri, 31 May 2019 02:43:54 +0000 (UTC)
Date: Fri, 31 May 2019 10:43:52 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190531024352.GI28587@xz-x1>
References: <20190530092919.26059-1-peterx@redhat.com>
	<20190530092919.26059-10-peterx@redhat.com>
	<20190530135329.GG2823@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190530135329.GG2823@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 31 May 2019 02:43:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 09/12] kvm: Persistent per kvmslot dirty
 bitmap
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
	qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 02:53:30PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > When synchronizing dirty bitmap from kernel KVM we do it in a
> > per-kvmslot fashion and we allocate the userspace bitmap for each of
> > the ioctl.  This patch instead make the bitmap cache be persistent
> > then we don't need to g_malloc0() every time.
> > 
> > More importantly, the cached per-kvmslot dirty bitmap will be further
> > used when we want to add support for the KVM_CLEAR_DIRTY_LOG and this
> > cached bitmap will be used to guarantee we won't clear any unknown
> > dirty bits otherwise that can be a severe data loss issue for
> > migration code.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Is there no way to make this get allocated the first time it's needed?
> I'm thinking here of the VM most of the time not being migrated so we're
> allocating this structure for no benefit.

Valid argument...  sure we can do the allocation on first usage. How
about below change squashed?

(I'll squash them properly into different patches where proper; the
 assertion would belong to the other patch)

=======================

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 23895a95a2..80bc4be03a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -523,6 +523,11 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,                                                                       
             goto out;
         }

+        if (!mem->dirty_bmap) {
+            /* Allocate on the first log_sync, once and for all */
+            mem->dirty_bmap = g_malloc0(bmap_size);
+        }
+
         d.dirty_bitmap = mem->dirty_bmap;
         d.slot = mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
@@ -638,6 +643,8 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
      */

     assert(bmap_start % BITS_PER_LONG == 0);
+    /* We should never do log_clear before log_sync */
+    assert(mem->dirty_bmap);
     if (start_delta) {
         /* Slow path - we need to manipulate a temp bitmap */
         bmap_clear = bitmap_new(bmap_npages);
@@ -995,7 +1002,6 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     mem->start_addr = start_addr;
     mem->ram = ram;
     mem->flags = kvm_mem_flags(mr);
-    mem->dirty_bmap = g_malloc0(bmap_size);

     err = kvm_set_user_memory_region(kml, mem, true);
     if (err) {

Regards,

-- 
Peter Xu

