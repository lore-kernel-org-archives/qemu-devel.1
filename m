Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5051C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860C32082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860C32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyYJ-0005s5-Ks
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8z-0005z4-0c
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8x-0003pa-ND
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8u-0003hM-VF
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A68FA3CA0B;
 Tue, 20 Aug 2019 07:01:15 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E98A60BE2;
 Tue, 20 Aug 2019 07:01:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:53 +0200
Message-Id: <1566284395-30287-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 20 Aug 2019 07:01:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 34/36] test-bitmap: test set 1 bit case for
 bitmap_set
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
Cc: Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

All current bitmap_set test cases set range across word, while the
handle of a range within one word is different from that.

Add case to set 1 bit as a represent for set range within one word.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-bitmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index 18aa584..087e02a 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -67,6 +67,18 @@ static void bitmap_set_case(bmap_set_func set_func)
 
     bmap = bitmap_new(BMAP_SIZE);
 
+    /* Set one bit at offset in second word */
+    for (offset = 0; offset <= BITS_PER_LONG; offset++) {
+        bitmap_clear(bmap, 0, BMAP_SIZE);
+        set_func(bmap, BITS_PER_LONG + offset, 1);
+        g_assert_cmpint(find_first_bit(bmap, 2 * BITS_PER_LONG),
+                        ==, BITS_PER_LONG + offset);
+        g_assert_cmpint(find_next_zero_bit(bmap,
+                                           3 * BITS_PER_LONG,
+                                           BITS_PER_LONG + offset),
+                        ==, BITS_PER_LONG + offset + 1);
+    }
+
     /* Both Aligned, set bits [BITS_PER_LONG, 3*BITS_PER_LONG] */
     set_func(bmap, BITS_PER_LONG, 2 * BITS_PER_LONG);
     g_assert_cmpuint(bmap[1], ==, -1ul);
-- 
1.8.3.1



