Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21199C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 10:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CD2218EA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 10:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6GYNFnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CD2218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHQum-0001QL-Ly
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 06:38:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHQtv-00017G-4B
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHQtu-0006F7-0J
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:37:47 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shahab.vahedi@gmail.com>)
	id 1hHQtr-0006DO-2D
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:37:44 -0400
Received: by mail-ed1-x543.google.com with SMTP id a6so4151366edv.1
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 03:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=28jotbghOsTkOfUxXEzjb4qLbJLpTPn+3ztFJ/xHkAk=;
	b=Q6GYNFnL1QZyYxki3AS02nRuIHLEO1ioFIwZq/8oBn5nelBDB4wvr63roG7z81HPEv
	i0dwnmddNKfR1x0kJp10JJv4/br4D5vTMEAbnPOkZy60VXQdaDnxAojtNWqqHks3Cxo/
	eH62yCPXSjlEQyVheSTQPVk1R5HrczA3axccIvD7Ox1X0uWu/bhbAVjkZuCOS8yoW3VZ
	4rubrlsaE7s0LMhImq+3GjvwHfbob9p7tgR51c+ghPwOXr25PUQY8bfFfC/pzXTTkk4K
	4dwABLN5+6fXpdLXC4KtCLh0GJW1m/0uOlBhdMUrWSwn8XPlY8+kK7u0hU+AqB5z/xce
	curw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=28jotbghOsTkOfUxXEzjb4qLbJLpTPn+3ztFJ/xHkAk=;
	b=tuQ/ovS5lTyy0dXek5aqKHEzwXuAVAST0gs4A1gCdeRfQd9wHBHRZLZsVl4U3LyARS
	3Xyqzxw7KQ5xgp5yuCYJ0CdVhPcKErOASsgHhOJdqkRSPVSxOUrejghjljKrd1G3iU48
	Gdxqocd1Bq3ziD0JMgj/t9ONjyy6emfDepFAG8+wqd7cJXFSyJ+Mhbam4+8TVRosTev/
	6qLkKNzHNYhQFendVq9pUcxMhzzjfjZw5vOR/lRPaj3Pg0aLuV1K4z2BBlt9Jx2rzBWL
	GKLuJDq3Pe8mT+M4+n9bY4DcLR7o5cE2h9YcTLUD5GLfad6AOMGv/1PhTxKEwHNsikuy
	UIeQ==
X-Gm-Message-State: APjAAAV++NAa0XfqbVt6oHWsFFkXbdXmNOf+Bjbz06zvdUfYwbuKs1Qz
	h4PGwN8Y3Mk74vHAc22+gZptK86rWrH76A==
X-Google-Smtp-Source: APXvYqxc4B4xYHTU1hVyJJKItrVIJ88u4cz+vJgumVtr19ZXZAOKXQJSFIAajpCgPYKjPflS7b72xg==
X-Received: by 2002:a50:8866:: with SMTP id c35mr1946031edc.132.1555670260574; 
	Fri, 19 Apr 2019 03:37:40 -0700 (PDT)
Received: from localhost.localdomain
	(ip-217-103-128-141.ip.prioritytelecom.net. [217.103.128.141])
	by smtp.gmail.com with ESMTPSA id w4sm1193568eds.86.2019.04.19.03.37.39
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 19 Apr 2019 03:37:39 -0700 (PDT)
From: Shahab Vahedi <shahab.vahedi@gmail.com>
To: qemu-devel@nongnu.org (open list:Overall)
Date: Fri, 19 Apr 2019 12:37:22 +0200
Message-Id: <20190419103722.17062-1-shahab.vahedi@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Shahab Vahedi <shahab.vahedi@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419103722.P6g7uYN5j_BRH8JpX9d_RQU3qbBBCkEt-LYbKRyerCc@z>

This change adapts io_readx() to its input access_type. Currently
io_readx() treats any memory access as a read, although it has an
input argument "MMUAccessType access_type". This results in:

1) Calling the tlb_fill() only with MMU_DATA_LOAD
2) Considering only entry->addr_read as the tlb_addr

Buglink: https://bugs.launchpad.net/qemu/+bug/1825359

Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
---
 accel/tcg/cputlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..0daac0e806 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
 
         entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = entry->addr_read;
+        tlb_addr =
+            (access_type == MMU_DATA_LOAD ) ? entry->addr_read  :
+            (access_type == MMU_DATA_STORE) ? entry->addr_write :
+            entry->addr_code;
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + entry->addend;
-- 
2.21.0


