Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FFC3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 09:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCDB2173B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 09:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCDB2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyv6A-0006Oc-BS
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 05:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hyv4y-0005Pg-Pw
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hyv4x-0007Un-OJ
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hyv4x-0007UK-J1
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so4141894pgp.12
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 02:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mW7mapkXYlihbRk2kyRrnnB1xG5ne0ikmPSU8W9hYEs=;
 b=a4BVmcZPi4n1zX/YWWVbu31gC2PxzsCqJ+NF5qvvVMrj8eMiP1qA95QMRcwL/kTSTn
 4JFOGtvDbx2DGwZNVka4REArCMg07yUPrtwn27MdtjF/Us3dNcURA3Fb5VY6oU+0cyoA
 uEMZOa9O2iyg1n0V29r96+bbPv0AWSkaK1FDvsCNOONJIEcOBVKCkO1FCVvbvH0ejBbm
 fhbz+B7KGLn9aGpTMuWFq7uR6VLsMwwBAQbtEqr67GPPurpp5i6xdrXsNJ1UpTmEs4js
 tRVv5lRyLxVVDPq5dmyv1kEIY5YGmNGGSQ9fgtuan5Ey/YzSgWe3uN4VphfNCNqnNZQJ
 HaEQ==
X-Gm-Message-State: APjAAAXuDp9SHXOi+opkvwOnPYLuEhF/4NGlwjFOzeuwJhFWNpzynqxT
 56tv0sFimypGFHA9CGYauXDrSo/3xlM=
X-Google-Smtp-Source: APXvYqxuzc4bAHbVQoCRpI7bUMNA/M1BnhDLSlGw6kHuXaREoLsXsmEwDwEWFKa900wvRVp0Bfn0ZA==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr14825025pfh.179.1566034374418; 
 Sat, 17 Aug 2019 02:32:54 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y23sm9821473pfr.86.2019.08.17.02.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2019 02:32:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 17 Aug 2019 17:32:37 +0800
Message-Id: <20190817093237.27967-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817093237.27967-1-peterx@redhat.com>
References: <20190817093237.27967-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: [Qemu-devel] [PATCH 2/2] memory: Split zones when do
 coalesced_io_del()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is a workaround of current KVM's KVM_UNREGISTER_COALESCED_MMIO
interface.  The kernel interface only allows to unregister an mmio
device with exactly the zone size when registered, or any smaller zone
that is included in the device mmio zone.  It does not support the
userspace to specify a very large zone to remove all the small mmio
devices within the zone covered.

Logically speaking it would be nicer to fix this from KVM side, though
in all cases we still need to coop with old kernels so let's do this.

This patch has nothing to do with 3ac7d43a6fbb5d4a3 because this is
probably broken from the very beginning when the
KVM_UNREGISTER_COALESCED_MMIO interface is introduced in kernel.
However to make the backport to stables easier, I'm still using the
commit 3ac7d43a6fbb5d4a3 to track this problem because this will
depend on that otherwise even additions of mmio devices won't work.

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index 1a2b465a96..b24cdd13cf 100644
--- a/memory.c
+++ b/memory.c
@@ -864,6 +864,9 @@ static void address_space_update_ioeventfds(AddressSpace *as)
 
 static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 {
+    CoalescedMemoryRange *cmr;
+    AddrRange tmp;
+
     if (QTAILQ_EMPTY(&fr->mr->coalesced)) {
         return;
     }
@@ -874,9 +877,30 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 
     fr->coalesced_mmio_del_done = true;
 
-    MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
-                                  int128_get64(fr->addr.start),
-                                  int128_get64(fr->addr.size));
+    /*
+     * We split the big region into smaller ones to satisfy KVM's
+     * KVM_UNREGISTER_COALESCED_MMIO interface, where it does not
+     * allow to specify a large region to unregister all the devices
+     * under that zone instead it only accepts exact zones or even a
+     * smaller zone of previously registered mmio device.  Logically
+     * speaking we should better fix KVM to allow the userspace to
+     * unregister multiple mmio devices within a large requested zone,
+     * but in all cases we'll still need to live with old kernels.  So
+     * let's simply break the zones into exactly the small pieces when
+     * we do coalesced_io_add().
+     */
+    QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
+        tmp = addrrange_shift(cmr->addr,
+                              int128_sub(fr->addr.start,
+                                         int128_make64(fr->offset_in_region)));
+        if (!addrrange_intersects(tmp, fr->addr)) {
+            continue;
+        }
+        tmp = addrrange_intersection(tmp, fr->addr);
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    }
 }
 
 static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
-- 
2.21.0


