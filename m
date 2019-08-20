Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8A7C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAAA214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAAA214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04xE-0006JW-HR
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i04tN-0002Rh-UD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i04tM-0007LP-RA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i04tM-0007Ku-Js
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:44 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC1AFC0467C3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:13:43 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id 191so4891379pfy.20
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cZFoxwy7BgOSzGeOdH9WM+DUKNeOVDwNKzYU3L8feJA=;
 b=nPbo4iilvikd2RBiCrJvolHevhz65InrCna8P1TPa+1VXDXV5ZHcFL/SbQ/XtQu38n
 qPHI+N2nseP9kjcejhhI1FdLIZg8SoG2zVXUydtJ8A+m7ERssaZ9OFBbowMtyBhkqU7l
 KBf8o3WnOUZ5+Rs5SgKs0cqXiyopFts4TvTC1ySDpZPSWnRqjcQk+mAtT/suV49xJMP5
 OXhaGwSVzV5oRPVFe3JMsycXXUYSHzz/rKdh0ALhn1X3PylLPZ390l0mmycvUvGhHuME
 TKRINus4luUuyjk3s7E1RYXd7bCnEqZVxiJBGZeseZT9jfGkDwDpQXxjbe921FQwGW1N
 1BIA==
X-Gm-Message-State: APjAAAUgPHL1V0KREYj2TijRA0G8gyqrkKG3MdRk6PKNKoaW6hQ4MHcV
 pkU3chsOVHfTXnjiINAKMixlu3YCDQyyENtqctow3GynkZkzL28rFRd+uFS30HRY1TBKWiiX5ff
 vakvRV8TbopWnMr4=
X-Received: by 2002:aa7:9a5a:: with SMTP id x26mr29329594pfj.47.1566310422776; 
 Tue, 20 Aug 2019 07:13:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQKgYqnxpqMDObrt2pbF3XE0Qi1egFttdRsx8+3xSfOupBH+bOgVMgL9UUcBGDor/8frnJhw==
X-Received: by 2002:aa7:9a5a:: with SMTP id x26mr29329576pfj.47.1566310422588; 
 Tue, 20 Aug 2019 07:13:42 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e185sm9057921pfa.119.2019.08.20.07.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 07:13:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 22:13:25 +0800
Message-Id: <20190820141328.10009-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820141328.10009-1-peterx@redhat.com>
References: <20190820141328.10009-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/4] memory: Split zones when do
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

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/memory.c b/memory.c
index 8141486832..8173f6be62 100644
--- a/memory.c
+++ b/memory.c
@@ -855,8 +855,39 @@ static void address_space_update_ioeventfds(AddressS=
pace *as)
     flatview_unref(view);
 }
=20
+/*
+ * Notify the memory listeners about the coalesced IO change events of
+ * range `cmr'.  Only the part that has intersection of the specified
+ * FlatRange will be sent.
+ */
+static void flat_range_coalesced_io_notify(FlatRange *fr, AddressSpace *=
as,
+                                           CoalescedMemoryRange *cmr, bo=
ol add)
+{
+    AddrRange tmp;
+
+    tmp =3D addrrange_shift(cmr->addr,
+                          int128_sub(fr->addr.start,
+                                     int128_make64(fr->offset_in_region)=
));
+    if (!addrrange_intersects(tmp, fr->addr)) {
+        return;
+    }
+    tmp =3D addrrange_intersection(tmp, fr->addr);
+
+    if (add) {
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, coalesced_io_add,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    } else {
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    }
+}
+
 static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 {
+    CoalescedMemoryRange *cmr;
+
     if (!fr->has_coalesced_range) {
         return;
     }
@@ -865,16 +896,15 @@ static void flat_range_coalesced_io_del(FlatRange *=
fr, AddressSpace *as)
         return;
     }
=20
-    MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
-                                  int128_get64(fr->addr.start),
-                                  int128_get64(fr->addr.size));
+    QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
+        flat_range_coalesced_io_notify(fr, as, cmr, false);
+    }
 }
=20
 static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
 {
     MemoryRegion *mr =3D fr->mr;
     CoalescedMemoryRange *cmr;
-    AddrRange tmp;
=20
     if (QTAILQ_EMPTY(&mr->coalesced)) {
         return;
@@ -885,16 +915,7 @@ static void flat_range_coalesced_io_add(FlatRange *f=
r, AddressSpace *as)
     }
=20
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
-        tmp =3D addrrange_shift(cmr->addr,
-                              int128_sub(fr->addr.start,
-                                         int128_make64(fr->offset_in_reg=
ion)));
-        if (!addrrange_intersects(tmp, fr->addr)) {
-            continue;
-        }
-        tmp =3D addrrange_intersection(tmp, fr->addr);
-        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, coalesced_io_add,
-                                      int128_get64(tmp.start),
-                                      int128_get64(tmp.size));
+        flat_range_coalesced_io_notify(fr, as, cmr, true);
     }
 }
=20
--=20
2.21.0


