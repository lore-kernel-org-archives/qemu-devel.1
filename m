Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F01C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 09:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC0D20880
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 09:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC0D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyv7q-0008Fw-NJ
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 05:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hyv4y-0005Oo-C4
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hyv4x-0007UQ-8C
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hyv4x-0007St-2a
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 05:32:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so4147156pgl.11
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 02:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OJ8kD2/76pq/lLNCK63wh1+/dd7Uwzv0Gang7spaF0Y=;
 b=cCdFdXwwKQijVnQBBPHTZQPYnJvqAr9ypzJvE7BRGh/wfhzTsCTXSRunG/kiWPegys
 K9JTV7OCDdsa+Iicl3Ec7kfnlMfE/TGyImmeIHXaNAbe/o47wQCW6iHAoTL2F7Z5qGDE
 pC9+s1ZMM+2mA6QTsW+RaReu2jqK3nJ4YwZmDD41QfLSzeOGpU5qvhzZaB268ECkw8NJ
 Df8SQU0V/few+seqVALheTRXh+Gj3bES+6kROzSnwsHRBTmYb3H3K/+1Y+Lde6mlM/d4
 YA6ox8qgVed4plaJyDgtxMwkLwHYAjFUXCDG+1spxDKLuMf68Bzq1LZdyYdKkJ8mzJdu
 JGSg==
X-Gm-Message-State: APjAAAVn/UQl6iG7A0HF7c6xdMKGjj43BiPi7LvyqzDbgOo9CN7wpCA3
 pWbQl7WThFc4BcTfUUKiiMwCGsXubmk=
X-Google-Smtp-Source: APXvYqyDvPMauJPBrlAbwnL82CmTS67Rb4tamIpAaIl5GyY00M4KQPnVJ3zFQHREGS77W6ymrCcwWQ==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr11175853pgv.437.1566034371524; 
 Sat, 17 Aug 2019 02:32:51 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y23sm9821473pfr.86.2019.08.17.02.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2019 02:32:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 17 Aug 2019 17:32:36 +0800
Message-Id: <20190817093237.27967-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817093237.27967-1-peterx@redhat.com>
References: <20190817093237.27967-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: [Qemu-devel] [PATCH 1/2] memory: Replace has_coalesced_range with
 add/del flags
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

The previous has_coalesced_range counter has a problem in that it only
works for additions of coalesced mmio ranges but not deletions.  The
reason is that has_coalesced_range information can be lost when the
FlatView updates the topology again when the updated region is not
covering the coalesced regions. When that happens, due to
flatrange_equal() is not checking against has_coalesced_range, the new
FlatRange will be seen as the same one as the old and the new
instance (whose has_coalesced_range will be zero) will replace the old
instance (whose has_coalesced_range _could_ be non-zero).

To fix it, we don't cache has_coalesced_range at all in the FlatRange.
Instead we introduce two flags to make sure the coalesced_io_{add|del}
will only be called once for every FlatRange instance.  This will even
work if another FlatRange replaces current one.

Without this patch, MemoryListener.coalesced_io_del is hardly being
called due to has_coalesced_range will be mostly zero in
flat_range_coalesced_io_del() when topologies frequently change for
the "memory" address space.

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/memory.c b/memory.c
index 8141486832..1a2b465a96 100644
--- a/memory.c
+++ b/memory.c
@@ -217,7 +217,13 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
-    int has_coalesced_range;
+    /*
+     * Flags to show whether we have delievered the
+     * coalesced_io_{add|del} events to the listeners for this
+     * FlatRange.
+     */
+    bool coalesced_mmio_add_done;
+    bool coalesced_mmio_del_done;
 };
 
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -654,7 +660,8 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode = mr->romd_mode;
     fr.readonly = readonly;
     fr.nonvolatile = nonvolatile;
-    fr.has_coalesced_range = 0;
+    fr.coalesced_mmio_add_done = false;
+    fr.coalesced_mmio_del_done = false;
 
     /* Render the region itself into any gaps left by the current view. */
     for (i = 0; i < view->nr && int128_nz(remain); ++i) {
@@ -857,14 +864,16 @@ static void address_space_update_ioeventfds(AddressSpace *as)
 
 static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 {
-    if (!fr->has_coalesced_range) {
+    if (QTAILQ_EMPTY(&fr->mr->coalesced)) {
         return;
     }
 
-    if (--fr->has_coalesced_range > 0) {
+    if (fr->coalesced_mmio_del_done) {
         return;
     }
 
+    fr->coalesced_mmio_del_done = true;
+
     MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
                                   int128_get64(fr->addr.start),
                                   int128_get64(fr->addr.size));
@@ -880,10 +889,12 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
         return;
     }
 
-    if (fr->has_coalesced_range++) {
+    if (fr->coalesced_mmio_add_done) {
         return;
     }
 
+    fr->coalesced_mmio_add_done = true;
+
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
         tmp = addrrange_shift(cmr->addr,
                               int128_sub(fr->addr.start,
-- 
2.21.0


