Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46179C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1267021741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5mN7gbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1267021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLWZ-0003CK-7s
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLVJ-0001Te-PL
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLVH-0004SV-5q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLVH-0004MX-0X
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/l92mY2pAFJF/yUP+iL03ANFNUP9y0kgsvuaoTh1kgg=;
 b=W5mN7gbGM0WaW51FO1lHXF2nuKKV56vCV2n/O4fb1oCKtCDVNfgj1CqPQrFe0lXtVlLjGI
 hYwuivdE/W3O4d1VuzgNqO0VBh22kmVS6P1JR6/rfoVxXTh7fyqy56gBO3oEn8u/eD8t5H
 g8Xy6lltR8REmnz7p8Bgz306O/bkbWE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-olJw1sO-Mlicati2qONzTw-1; Wed, 05 Feb 2020 09:18:01 -0500
Received: by mail-qt1-f199.google.com with SMTP id o24so1399971qtr.17
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ha3PiyjeE7m3n0zH2bYefx34bQnP0jpPs+XZBPTQxTg=;
 b=Bn45GjqR4mPL3LUD36k5TUxjWgUfcaow7rIxEXIL9nGySzeSbJooRsJitWzkC5mh9n
 BtKE2noVVHZ1hK0attK0NX4ygkrdlMsOFqOWPDFr6nN6EuH5JxY1bLNrVm6CDjNn349b
 6bP1yfnZJWMQH6SuRhi+BbUMwMPLl0WklA3D9st0cGgkHWU2Gzjse5C17OSUvebETl9H
 n/HD5daTXcbbacnE2BCViMpkHnN8MAdXnZA05HF1VP/tNpC3My+8+xbn4MXI0sLU4+W2
 WZpvfk8ncN8D5eT+w/coluoAFIWy04mNZbZQ5+k3fBwW3b6fBaltp0zueRrJwPGMTiVs
 ykLA==
X-Gm-Message-State: APjAAAXQWjw9x6m+88UIg3XQnRSBoLfEBMKZEXaAMTS15hLm8QVDbuIU
 hSx9EE2gxOQ77ti8WN3cQxEx88odXsNeqMXuDzSrdNmn9xnhqmdGiI5fA2uwy4Vf+ORA/8V5Hbk
 bgUvRhw8mQL3UfjI=
X-Received: by 2002:a05:6214:927:: with SMTP id
 dk7mr29250966qvb.200.1580912281038; 
 Wed, 05 Feb 2020 06:18:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUHB+zXjrTNJiKFKHsixhMD6GxCR9nO43ARJwlOz+J40yHrsh+S7U+cT3j7zlX8nyxKc8lMw==
X-Received: by 2002:a05:6214:927:: with SMTP id
 dk7mr29250949qvb.200.1580912280774; 
 Wed, 05 Feb 2020 06:18:00 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:18:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 4/9] KVM: Create the KVMSlot dirty bitmap on flag changes
Date: Wed,  5 Feb 2020 09:17:44 -0500
Message-Id: <20200205141749.378044-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: olJw1sO-Mlicati2qONzTw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
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

Since at it, move all the pre-checks into kvm_slot_init_dirty_bitmap().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4be3cd2352..bb635c775f 100644
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
@@ -442,6 +444,7 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml=
, KVMSlot *mem,
         return 0;
     }
=20
+    kvm_slot_init_dirty_bitmap(mem);
     return kvm_set_user_memory_region(kml, mem, false);
 }
=20
@@ -526,8 +529,12 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionS=
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
@@ -578,11 +585,6 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryLis=
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
@@ -1079,14 +1081,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
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


