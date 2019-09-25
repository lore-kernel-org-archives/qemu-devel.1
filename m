Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67099C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B9C21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8sr21E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B9C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCZY-0002P0-OZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIk-0001u2-LN
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIj-0004OP-F0
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIj-0004NZ-5J
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:09 -0400
Received: by mail-pg1-x542.google.com with SMTP id i14so142992pgt.11
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yAC6RG3wvhI3H3mXOjF1M8pzwn6maoZxTmCA0mspbiE=;
 b=j8sr21E/7b0HcIha4bK+txI5RcHSDB5hgO/mBCmw9C01jPpwe0EJhDMezWYD1nSHxN
 45k4cZSLyb5qnB2D2+F4z/1u3LSe5S7AndiUdnxMEKrjyTdlG5tCp/Yrdhf77uk5jpxH
 brqBILK9azxYj9SPKlfbAuFlWRre3WYTw6usQ1/x8Wf2js9amISDTvgZUxXJznwq85mx
 3/3X1VHHAKMoG0PQJ1WNotV2+YxUYqoxFGSbDBISLaqn9fWWb/QiWkJIiKIKQNwIZetf
 Gsv8xruh1O/yvbYo+zpLlG3FpD42CZsSVvHOasjKL7uNWe/T3G8G3yAmYgwG/zgaGhqG
 4KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yAC6RG3wvhI3H3mXOjF1M8pzwn6maoZxTmCA0mspbiE=;
 b=FPKYXiX8jjAWTEfVgpx86SA2s7obenYhsCuhV3YO6bhyKgT/sk8WDD1f5cVTLD8uzu
 PkXt+LKaStqKSre88DAq6ANoUbZexrEoJOmVGpeAG2ymIsYtf0CcJx4sz0OAjb9X994j
 btewq79a/N7DRooTw1yO7EJTy8KeLLdNeWmP2ZbWL+7qF9DRNpBJFXU+0mBCGsW9ZR/0
 50VSHvJy6FXcFzidxX/29yx3Qa2lf67WuoNexnub5rCulGJl8nH+Y/tNgnnAKOaEYxWg
 YnGat2oVLBgKKXaEnKKH6cuYc4eHkgjPgl2nNw0Tx881+uf4C2VFhseSJVXqe54KeSbO
 TDow==
X-Gm-Message-State: APjAAAXAo/iKgaBfRYYKx51koWpaq4EBD7YrMZkAPIRy4gSkv2oOFCpe
 NwMvkB578fQJo53dmPhEGqq5JUbUcII=
X-Google-Smtp-Source: APXvYqwgDeLXGIVJEKyWDA3emsnAE4L5EYU7jYmTQdhJyt2r6ogN1aJgqNkv2VzYln/C4Uj9+a/ZJw==
X-Received: by 2002:a17:90a:b385:: with SMTP id
 e5mr8169741pjr.91.1569437167666; 
 Wed, 25 Sep 2019 11:46:07 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:46:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] cputlb: Handle TLB_NOTDIRTY in probe_access
Date: Wed, 25 Sep 2019 11:45:44 -0700
Message-Id: <20190925184548.30673-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can use notdirty_write for the write and return a valid host
pointer for this case.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3e91838519..b56e9ddf8c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1168,16 +1168,24 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
         return NULL;
     }
 
-    /* Handle watchpoints.  */
-    if (tlb_addr & TLB_WATCHPOINT) {
-        cpu_check_watchpoint(env_cpu(env), addr, size,
-                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
-                             wp_access, retaddr);
-    }
+    if (unlikely(tlb_addr & TLB_FLAGS_MASK)) {
+        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
 
-    /* Reject I/O access, or other required slow-path.  */
-    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP | TLB_DISCARD_WRITE)) {
-        return NULL;
+        /* Reject I/O access, or other required slow-path.  */
+        if (tlb_addr & (TLB_MMIO | TLB_BSWAP | TLB_DISCARD_WRITE)) {
+            return NULL;
+        }
+
+        /* Handle watchpoints.  */
+        if (tlb_addr & TLB_WATCHPOINT) {
+            cpu_check_watchpoint(env_cpu(env), addr, size,
+                                 iotlbentry->attrs, wp_access, retaddr);
+        }
+
+        /* Handle clean RAM pages.  */
+        if (tlb_addr & TLB_NOTDIRTY) {
+            notdirty_write(env_cpu(env), addr, size, iotlbentry, retaddr);
+        }
     }
 
     return (void *)((uintptr_t)addr + entry->addend);
-- 
2.17.1


