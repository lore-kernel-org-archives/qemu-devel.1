Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67BBC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5FA214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5FA214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04vE-0003wt-As
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i04tW-0002be-3e
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i04tU-0007Wz-SF
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i04tU-0007TU-Hy
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:52 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3DD6C0546F2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:13:51 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id n186so4905558pfn.6
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=09T6APry/hKW1d7wgqIZDeiyq1OtzijdsQjH90lcRxY=;
 b=jAHwIrbuxSfuwcMCNeBU2jyd5X5VNza0Rd6/F0PMlY8AdR2ExP5terpLIcWKDwyqiM
 D2Xxftl2XzVFoxXk+2MbRaJcqhzUDtnISCN1whG2e7VazdUQA9yU3yF8fGf9CUJ/8HcV
 IdbKQ9DNAmviDW1SvMNcElg86ZP2U0UwChIuiOL574F9uGdrKaSwyR6PLkCAPL0ANIa5
 pPyDBtsQzFiVW+6f45dhkjkXo2kPYWMKUp+BJbG+QSLhoNZIKkCMPdkaWjK4ArNJOGVL
 5JcKaMNnHeGoz+bxiY9S0bla+4J82lRGV1geY3CP/Lb626f0LWS6kk82xnNOkfe5xHC0
 nViQ==
X-Gm-Message-State: APjAAAXe/lbJdY7WT5XGtONb2OPWuhmiYQ597GCpWCWx2uWEzZWWXhKZ
 Mm0O6LdP1Xw5L4x1iSHfGapTsh3amkTB+v5oxEQHALXyXDxbBUlc00xB0YeBaKRjYHIfsJ7ABKz
 aYGbiM5kTcaoxx/c=
X-Received: by 2002:a17:902:7083:: with SMTP id
 z3mr28435065plk.87.1566310431047; 
 Tue, 20 Aug 2019 07:13:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbCWRxHRwtCElFSTc/rf/zLBkKNbGRm8wwm4/t4pTfLKe9HmoWPuGkG0/aDlRxgTzKZ0WWrg==
X-Received: by 2002:a17:902:7083:: with SMTP id
 z3mr28435047plk.87.1566310430899; 
 Tue, 20 Aug 2019 07:13:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e185sm9057921pfa.119.2019.08.20.07.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 07:13:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 22:13:28 +0800
Message-Id: <20190820141328.10009-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820141328.10009-1-peterx@redhat.com>
References: <20190820141328.10009-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/4] memory: Fix up
 memory_region_{add|del}_coalescing
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

The old memory_region_{add|clear}_coalescing() has some defects
because they both changed mr->coalesced before updating the regions
using memory_region_update_coalesced_range_as().  Then when the
regions were updated in memory_region_update_coalesced_range_as() the
mr->coalesced will always be either one more or one less.  So:

- For memory_region_add_coalescing: it'll always trying to remove the
  newly added coalesced region while it shouldn't, and,

- For memory_region_clear_coalescing: when it calls the update there
  will be no coalesced ranges on mr->coalesced because they were all
  removed before hand so the update will probably do nothing for real.

Let's fix this.  Now we've got flat_range_coalesced_io_notify() to
notify a single CoalescedMemoryRange instance change, so use it in the
existing memory_region_update_coalesced_range() logic by only notify
either an addition or deletion.  Then we hammer both the
memory_region_{add|clear}_coalescing() to use it.

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/memory.c b/memory.c
index 2f7a67086a..5d2194ebcc 100644
--- a/memory.c
+++ b/memory.c
@@ -2238,27 +2238,26 @@ void memory_region_ram_resize(MemoryRegion *mr, r=
am_addr_t newsize, Error **errp
     qemu_ram_resize(mr->ram_block, newsize, errp);
 }
=20
-static void memory_region_update_coalesced_range_as(MemoryRegion *mr, Ad=
dressSpace *as)
+/*
+ * Call proper memory listeners about the change on the newly
+ * added/removed CoalescedMemoryRange.
+ */
+static void memory_region_update_coalesced_range(MemoryRegion *mr,
+                                                 CoalescedMemoryRange *c=
mr,
+                                                 bool add)
 {
+    AddressSpace *as;
     FlatView *view;
     FlatRange *fr;
=20
-    view =3D address_space_get_flatview(as);
-    FOR_EACH_FLAT_RANGE(fr, view) {
-        if (fr->mr =3D=3D mr) {
-            flat_range_coalesced_io_del(fr, as);
-            flat_range_coalesced_io_add(fr, as);
-        }
-    }
-    flatview_unref(view);
-}
-
-static void memory_region_update_coalesced_range(MemoryRegion *mr)
-{
-    AddressSpace *as;
-
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        memory_region_update_coalesced_range_as(mr, as);
+        view =3D address_space_get_flatview(as);
+        FOR_EACH_FLAT_RANGE(fr, view) {
+            if (fr->mr =3D=3D mr) {
+                flat_range_coalesced_io_notify(fr, as, cmr, add);
+            }
+        }
+        flatview_unref(view);
     }
 }
=20
@@ -2276,7 +2275,7 @@ void memory_region_add_coalescing(MemoryRegion *mr,
=20
     cmr->addr =3D addrrange_make(int128_make64(offset), int128_make64(si=
ze));
     QTAILQ_INSERT_TAIL(&mr->coalesced, cmr, link);
-    memory_region_update_coalesced_range(mr);
+    memory_region_update_coalesced_range(mr, cmr, true);
     memory_region_set_flush_coalesced(mr);
 }
=20
@@ -2294,10 +2293,9 @@ void memory_region_clear_coalescing(MemoryRegion *=
mr)
     while (!QTAILQ_EMPTY(&mr->coalesced)) {
         cmr =3D QTAILQ_FIRST(&mr->coalesced);
         QTAILQ_REMOVE(&mr->coalesced, cmr, link);
+        memory_region_update_coalesced_range(mr, cmr, false);
         g_free(cmr);
     }
-
-    memory_region_update_coalesced_range(mr);
 }
=20
 void memory_region_set_flush_coalesced(MemoryRegion *mr)
--=20
2.21.0


