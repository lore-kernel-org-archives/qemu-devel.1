Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1475EC83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46E1208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K71G6u8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46E1208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWal-0001dD-Qe
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWXO-0007yP-Tl
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWTm-0003Zm-R3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:09:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWTm-0003Pm-5c
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588104316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0mPNFnLhk/o5J3Jnu99bb2JupaYtYpoov8YY6lNUcg=;
 b=K71G6u8cGKMJ7fJvasaHz6I+RkcjOjhnehsyCo/S354cKmJfie8sYW9UwS+raqouLgsmkX
 q6TLs72JrTgUauIQ5pnCbvm/SAooUqO2v3jU64Drs7XK5PFS3Icp9Lbfcyo8jgvh2chhBF
 cIYnzUsHbxTWtZ3NmdE1gBRlXhqL+Gg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-TkrycxZXNheA7pAAnx0VxQ-1; Tue, 28 Apr 2020 16:05:14 -0400
X-MC-Unique: TkrycxZXNheA7pAAnx0VxQ-1
Received: by mail-qk1-f200.google.com with SMTP id 30so24527564qkp.21
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BWN777/+kh7YasCdIn6E68M+19eQsvTkowcMlPruT+0=;
 b=QxFbAgYWqg+fwr9rKmztQF1WXiHJVbVsUcoZ3NY4zAPPVJnbkkst9ou9mO73URthfU
 n6UYVmfaVy6oJgXg9VSCMh8PWzwbu1MQ7BsiVHi7QOPXQPowt3QhxBSnWdoPmpSzdkJn
 K/oS+unyR+Ax3ILEJ01QecFuhJ6XZ5RyJSd84lh/24s7jGK5gHTtGPPg07znSrYqIRUk
 QG9/F4xo25DJDCZmgObxq1r8HdzciAR9gmJAS7c5E0uKkbJ1bTVLbI0naM/IpQh2HYcZ
 /9jlEkZjzlOLVdPEX/WAJAs0xwVeiz2+VVhsUvfbE5sMBxVqphWCaGHm2P0nfm8OE9BX
 2g9w==
X-Gm-Message-State: AGi0PubKxSkpdlHLHEBUOrV/uGAdy8VVf9DJSObOEwzE+p2y6wO9DWW/
 yJKdogEK7Rm2O5D+2bkYDPxKBmTCMkp7TBRL/2MyWuLkZuD5yO7JKXBFh/xKvaN1MtHgJfTV21d
 tp3vw4sMq3zb4FNg=
X-Received: by 2002:a05:620a:c89:: with SMTP id
 q9mr28569354qki.375.1588104313275; 
 Tue, 28 Apr 2020 13:05:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKbQf4BKJNy3WPcSWl7xotMGpfenfrB24JvpFA87T1iRguLgXT1YLoYbaF01K/4v99lbaYbXQ==
X-Received: by 2002:a05:620a:c89:: with SMTP id
 q9mr28569336qki.375.1588104312931; 
 Tue, 28 Apr 2020 13:05:12 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k127sm14106585qkb.35.2020.04.28.13.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:05:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 4/9] KVM: Create the KVMSlot dirty bitmap on flag
 changes
Date: Tue, 28 Apr 2020 16:05:04 -0400
Message-Id: <20200428200509.13150-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428195707.11980-1-peterx@redhat.com>
References: <20200428195707.11980-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previously we have two places that will create the per KVMSlot dirty
bitmap:

  1. When a newly created KVMSlot has dirty logging enabled,
  2. When the first log_sync() happens for a memory slot.

The 2nd case is lazy-init, while the 1st case is not (which is a fix
of what the 2nd case missed).

To do explicit initialization of dirty bitmaps, what we're missing is
to create the dirty bitmap when the slot changed from not-dirty-track
to dirty-track.  Do that in kvm_slot_update_flags().

With that, we can safely remove the 2nd lazy-init.

This change will be needed for kvm dirty ring because kvm dirty ring
does not use the log_sync() interface at all.

Also move all the pre-checks into kvm_slot_init_dirty_bitmap().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1f1fd5316e..dc6371b8b2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -162,6 +162,8 @@ static NotifierList kvm_irqchip_change_notifiers =3D
 #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
 #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
=20
+static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s =3D KVM_STATE(current_accel());
@@ -452,6 +454,7 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml=
, KVMSlot *mem,
         return 0;
     }
=20
+    kvm_slot_init_dirty_bitmap(mem);
     return kvm_set_user_memory_region(kml, mem, false);
 }
=20
@@ -536,8 +539,12 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionS=
ection *section,
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
=20
 /* Allocate the dirty bitmap for a slot  */
-static void kvm_memslot_init_dirty_bitmap(KVMSlot *mem)
+static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
 {
+    if (!(mem->flags & KVM_MEM_LOG_DIRTY_PAGES) || mem->dirty_bmap) {
+        return;
+    }
+
     /*
      * XXX bad kernel interface alert
      * For dirty bitmap, kernel allocates array of size aligned to
@@ -588,11 +595,6 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryLis=
tener *kml,
             goto out;
         }
=20
-        if (!mem->dirty_bmap) {
-            /* Allocate on the first log_sync, once and for all */
-            kvm_memslot_init_dirty_bitmap(mem);
-        }
-
         d.dirty_bitmap =3D mem->dirty_bmap;
         d.slot =3D mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) =3D=3D -1) {
@@ -1086,14 +1088,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->start_addr =3D start_addr;
         mem->ram =3D ram;
         mem->flags =3D kvm_mem_flags(mr);
-
-        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
-            /*
-             * Reallocate the bmap; it means it doesn't disappear in
-             * middle of a migrate.
-             */
-            kvm_memslot_init_dirty_bitmap(mem);
-        }
+        kvm_slot_init_dirty_bitmap(mem);
         err =3D kvm_set_user_memory_region(kml, mem, true);
         if (err) {
             fprintf(stderr, "%s: error registering slot: %s\n", __func__,
--=20
2.24.1


