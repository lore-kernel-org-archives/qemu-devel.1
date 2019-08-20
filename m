Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20744C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 05:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F572087E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 05:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F572087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzwWu-0008VT-ID
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 01:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzwVW-0006ql-VB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzwVV-000500-Rr
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzwVV-0004zh-Ke
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:33 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B976491764
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 05:16:32 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id l12so3851313pgt.9
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 22:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r+wqbognQ8MrfKU7lUNMA5ZfpEUba5ufEKo6ZHWFaYs=;
 b=gnVDwDMyAU+c2X516P+WvhZNRo0hPHnxt3QGwE+SwoterZp6lmBThFMERhDHlmWFRK
 CNl3INoxjGIayVnMTFSC/F8heWhubODK+bgmyovgkeSTK0IVq8HqFJP5XPFXtPaxX6TL
 fTXzsrpND03PV7L6fnLUI2HSlZmI3+fnWXPeKfICLPfJaZ0znNKatA3PD8ljBNRDUmz9
 goUR/VLypJkR2ypz5/vG0d3O8jNfllDVpe1up3mVvsBOFrPC5ZS3R79IjHRHXLYzANbh
 rVCQF+NZ5NbTvEJGe0JY5ex9yyc+DKtbIrB74mNw0+0aSpOvJS0D7l4IoQqL4SDjTTM3
 fXrg==
X-Gm-Message-State: APjAAAVyqTjtHgp2VTKlFZd0/d+RHtcxlI8R4gt73dWKKsBR9PwC/nxm
 WyDDlW0/0ygvujNJ7NYqPWaVOq1qKlffrb3WgEEWRTygGmdgZhGNyzici/8tmGBTyMsx6uhvIMC
 6riQdZTz7wx9Qw08=
X-Received: by 2002:a17:902:20cc:: with SMTP id
 v12mr24444600plg.188.1566278191956; 
 Mon, 19 Aug 2019 22:16:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0LlzcFm81NBcBS6R/JCPOgYE4CSrCi6IrEy4ui1/NPHZCXnSDDI1f2EGmnyK2fASTPxLuAA==
X-Received: by 2002:a17:902:20cc:: with SMTP id
 v12mr24444585plg.188.1566278191791; 
 Mon, 19 Aug 2019 22:16:31 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e6sm17462610pfn.71.2019.08.19.22.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 22:16:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 13:16:15 +0800
Message-Id: <20190820051615.1210-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820051615.1210-1-peterx@redhat.com>
References: <20190820051615.1210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/2] memory: Split zones when do
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
index c53dcfc092..7684b423f8 100644
--- a/memory.c
+++ b/memory.c
@@ -857,6 +857,9 @@ static void address_space_update_ioeventfds(AddressSp=
ace *as)
=20
 static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 {
+    CoalescedMemoryRange *cmr;
+    AddrRange tmp;
+
     if (!fr->has_coalesced_range) {
         return;
     }
@@ -865,9 +868,30 @@ static void flat_range_coalesced_io_del(FlatRange *f=
r, AddressSpace *as)
         return;
     }
=20
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
+        tmp =3D addrrange_shift(cmr->addr,
+                              int128_sub(fr->addr.start,
+                                         int128_make64(fr->offset_in_reg=
ion)));
+        if (!addrrange_intersects(tmp, fr->addr)) {
+            continue;
+        }
+        tmp =3D addrrange_intersection(tmp, fr->addr);
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    }
 }
=20
 static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
--=20
2.21.0


