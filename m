Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EEDC35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 02:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD9B21D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 02:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2zl86l/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD9B21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuoY7-00012f-VA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 21:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1iuoXU-0000I1-U7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 21:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1iuoXT-0000DO-Ov
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 21:17:40 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1iuoXT-0000CZ-Jl; Thu, 23 Jan 2020 21:17:39 -0500
Received: by mail-pg1-x541.google.com with SMTP id q127so220506pga.4;
 Thu, 23 Jan 2020 18:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jg8HrVjpChzg0UHj4O3qKsQVQAUS0D7oRxH/19QrHAc=;
 b=b2zl86l/OFBC1zv9Publ3h+pLzz6AVxZzgXu3iB7cvepbcYcyoTcRZUjOc22qdnvpW
 WlzCEx88gHP7NT5se9s9Q+iiB2l071NgPLAPDJVErzOH3zuasNHNYDAdga7gUjnRzlAX
 v0PUIuvnga8j4tsgDIm+wHtafdGTvuNWEDhKaKmnhD58prpSYOlusuzMb+4BwAl9oizX
 9W2Mkmo+r+1nfpWsO0FSJtCfCVeUiUOinA7RqJbu9pTbWAMn9rFgDOM84JQBfzjYSc9s
 PXvREYvIemU192vkIfC0e7GTKL69tGH4LFym+WfrHdFPPOIYfZBmqE5MHm4a86p/FWk8
 94Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jg8HrVjpChzg0UHj4O3qKsQVQAUS0D7oRxH/19QrHAc=;
 b=iJL1EhGIIDRze5nxWyYFFCFqNXriGP4GoO5NDljAGzEV85XnElXMSdDgaBYjL0C54B
 hjQ1Xo/gPdRCXESBy+S+28q+E/cuJ+/zCaPHbj2r5+n09DMp1XURytp5dra+3xttjcLN
 wry52va8Q1oPoO6Hq/adIIkRBo7q4/XTcHh164vNbGxoMa+1GXCDn9sqHve9zl0V/r+2
 HRlV15WaiTGeYL8VlWslfjSROHtnyT4bz+q0l00rjc/RNSf/7JLAwW3MovdHDlrdTPSB
 ngKpJT+o/qyVO7y3ZtmkPOqTsBeQHV4aPNOAwdnhE0eHpHKPD7v86U25tknKAuLOC137
 bBwQ==
X-Gm-Message-State: APjAAAV4Z+zsCw/pz/lkTOlaAHdQZ+iqiJ+ovsqiT/yz3CjP+T1+dhvP
 Ec/+vkGVBHXGAui74m0C4JcJVzkesZPWWA==
X-Google-Smtp-Source: APXvYqwZfZR4aUiKPip0u2nmLjqEviqDJeYDipO1k0kuFixGC06JlYL0oLc+kSxci4tTcTAaBvo8gQ==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr1501905pgh.96.1579832257951; 
 Thu, 23 Jan 2020 18:17:37 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
 by smtp.gmail.com with ESMTPSA id m71sm6762598pje.0.2020.01.23.18.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 18:17:37 -0800 (PST)
From: Changbin Du <changbin.du@gmail.com>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tcg: gdbstub: Fix missing breakpoint issue
Date: Fri, 24 Jan 2020 10:17:28 +0800
Message-Id: <20200124021728.32518-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-stable@nongnu.org, Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When inserting breakpoints, we need to invalidate related TBs to apply
helper call. This is done by breakpoint_invalidate(). But many users
found the BPs sometimes never hit.

In system mode emulation, the BPs are global in guest but not particular
address space. The issue is that the current implementation only trys to
invalidate TB of paddr corresponding to the target vaddr in current MMU
context. Then some cached TBs continue running without BPs applied.

To fix this issue, we can just invalidate all TBs as what step mode does.
(For old version users, issuing a step command can workaround this problem.)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 exec.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d18e..9d9fd48519 100644
--- a/exec.c
+++ b/exec.c
@@ -997,36 +997,9 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
     tb_invalidate_phys_addr(pc);
 }
 #else
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
-{
-    ram_addr_t ram_addr;
-    MemoryRegion *mr;
-    hwaddr l = 1;
-
-    if (!tcg_enabled()) {
-        return;
-    }
-
-    RCU_READ_LOCK_GUARD();
-    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
-    if (!(memory_region_is_ram(mr)
-          || memory_region_is_romd(mr))) {
-        return;
-    }
-    ram_addr = memory_region_get_ram_addr(mr) + addr;
-    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
-}
-
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
-    MemTxAttrs attrs;
-    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
-    int asidx = cpu_asidx_from_attrs(cpu, attrs);
-    if (phys != -1) {
-        /* Locks grabbed by tb_invalidate_phys_addr */
-        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
-                                phys | (pc & ~TARGET_PAGE_MASK), attrs);
-    }
+    tb_flush(cpu);
 }
 #endif
 
-- 
2.24.0


