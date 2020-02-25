Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A73C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91825218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfiSOU+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91825218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZG2-0007sQ-MA
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl9-0001Rt-4y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl5-0000N0-5M
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl4-0000Il-Oo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:14 -0500
Received: by mail-wm1-x32f.google.com with SMTP id z12so2665332wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tAOcwiucq9sZ03S56wSU3BKkO7ecBjXLzXDmBGEz1YQ=;
 b=AfiSOU+IQ6ayUHzv5eI2pIOnOZoIrW44acTXVj+0a0bKcP3FjL42+7tTWbirabPsJt
 EZc4ro/X040XtXWi2vWNkjFOhW15orEr8KJDVDHGD4JvFgLiwaDZfoKzqdQR8TloOX9W
 S4o2UMXfCc6+yPV8k562eayEPgPTg50OSwul0+tz7au/JhEWpgTMTLucNzJ1szhPmKf6
 1+ZKSMXXvghWkUkrLCGmAAjVfdkbA+rBumnFoRk3gSRFP2qKctp3VqpnWuGq3i7SY5Lw
 wA/Y8HMLtzj/kM8wYXPNvmEHNbuUWo2aYAK3TYtKe2ESlmuKclaqisfAPB6ulvNwMi9v
 xr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=tAOcwiucq9sZ03S56wSU3BKkO7ecBjXLzXDmBGEz1YQ=;
 b=eRCbQtQnaLCz+iohYx47WezIhecFl1SxoynhVAPWZT3zOrglVAREGlNK/BuKzBlhp4
 r1Lsikqu85QBm9ia8I3X7ZhTaasTBFesdATYROSm3ZQnsCW7AlJEpUkWQScgPxzdwE80
 IwdAt+fSzznGt/P/+m01Qfcd8PhWSW/PiUshpHHaRRkEssKV/Bln7kwOBC7NvvWY+4c+
 NyNtgBtSawXTxAw5KNOI7l0Z1uSCNaj90Hp7JDGERtUin7y6fgJqwE4QbvltcrEXkirx
 fZm58yH3nkarhNUwcMpBXJ6blMjUBs/02clrMaQAK5TsZYW5urRtxQgG9M51WgyPDFf9
 0PpA==
X-Gm-Message-State: APjAAAXi3Ieyp2JBZOg7PDc0Jlptj0VamBR8191xmfYBshdEf1BOwhCY
 +msr/DLxCZ5jqlqBoTn1Zl8Iv8S1
X-Google-Smtp-Source: APXvYqygfOr0iI6YXcegaIBmsOEhwt+Ho2JUbrChCJl0lVNLzMkUGa3jA99WY22mCS6sdw0Xnb+EnQ==
X-Received: by 2002:a05:600c:204f:: with SMTP id
 p15mr5148549wmg.6.1582631533427; 
 Tue, 25 Feb 2020 03:52:13 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 073/136] exec: cleanup
 qemu_minrampagesize()/qemu_maxrampagesize()
Date: Tue, 25 Feb 2020 12:50:03 +0100
Message-Id: <1582631466-13880-73-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Since all RAM is backed by hostmem backends, drop
global -mem-path invariant and simplify code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-74-imammedo@redhat.com>
---
 exec.c | 49 ++++---------------------------------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/exec.c b/exec.c
index 8e9cc3b..d85a868 100644
--- a/exec.c
+++ b/exec.c
@@ -1667,59 +1667,18 @@ static int find_max_backend_pagesize(Object *obj, void *opaque)
 long qemu_minrampagesize(void)
 {
     long hpsize = LONG_MAX;
-    long mainrampagesize;
-    Object *memdev_root;
-    MachineState *ms = MACHINE(qdev_get_machine());
-
-    mainrampagesize = qemu_mempath_getpagesize(mem_path);
-
-    /* it's possible we have memory-backend objects with
-     * hugepage-backed RAM. these may get mapped into system
-     * address space via -numa parameters or memory hotplug
-     * hooks. we want to take these into account, but we
-     * also want to make sure these supported hugepage
-     * sizes are applicable across the entire range of memory
-     * we may boot from, so we take the min across all
-     * backends, and assume normal pages in cases where a
-     * backend isn't backed by hugepages.
-     */
-    memdev_root = object_resolve_path("/objects", NULL);
-    if (memdev_root) {
-        object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsize);
-    }
-    if (hpsize == LONG_MAX) {
-        /* No additional memory regions found ==> Report main RAM page size */
-        return mainrampagesize;
-    }
-
-    /* If NUMA is disabled or the NUMA nodes are not backed with a
-     * memory-backend, then there is at least one node using "normal" RAM,
-     * so if its page size is smaller we have got to report that size instead.
-     */
-    if (hpsize > mainrampagesize &&
-        (ms->numa_state == NULL ||
-         ms->numa_state->num_nodes == 0 ||
-         ms->numa_state->nodes[0].node_memdev == NULL)) {
-        static bool warned;
-        if (!warned) {
-            error_report("Huge page support disabled (n/a for main memory).");
-            warned = true;
-        }
-        return mainrampagesize;
-    }
+    Object *memdev_root = object_resolve_path("/objects", NULL);
 
+    object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsize);
     return hpsize;
 }
 
 long qemu_maxrampagesize(void)
 {
-    long pagesize = qemu_mempath_getpagesize(mem_path);
+    long pagesize = 0;
     Object *memdev_root = object_resolve_path("/objects", NULL);
 
-    if (memdev_root) {
-        object_child_foreach(memdev_root, find_max_backend_pagesize,
-                             &pagesize);
-    }
+    object_child_foreach(memdev_root, find_max_backend_pagesize, &pagesize);
     return pagesize;
 }
 #else
-- 
1.8.3.1



