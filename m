Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98143C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0022070D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM1E61Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0022070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3S7-0004Dj-K7
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:11:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3Na-0000Sq-8Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NY-000588-DY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hF3NY-00057U-3w; Fri, 12 Apr 2019 17:06:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id y13so13630090wrd.3;
	Fri, 12 Apr 2019 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=W8ixuwHDYIWc5mB7FPo87JyNHztypB+6NDXzbL76bL0=;
	b=ZM1E61LbF+Qmgd0WaBSvEy4wzNZQ1iF8EAYddbHs/hvxO/Fpo0Pe11GN5LfAMhJK58
	ajufquT10aDK6jklTeUcCg/s2dZMsSOqPII0lKcBEgYUnp4AJv3iWCJyZCymLcVO942B
	voQQhWzMu3BtbMftVw8lM3wN+j7iOhwwdsoacguKtYFMWQRLSxOoU2fWMGRuu+u5WK6U
	JX2pvkvZiB7p4eX8FKb0oEmAsxTjhyWHiDOo1021xpwMLELbgAIY/yRJd/olOJ2JBpR5
	RUFynkCpU2+F/ijIdLZQ6mca7rSo3aZPYWyzTxAbgiP6YD95sTf0FDkjzBEiL5/a62qB
	KIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=W8ixuwHDYIWc5mB7FPo87JyNHztypB+6NDXzbL76bL0=;
	b=V4uzRthwuQZqR4MCONKDChJ+nc/6e/G93bVZNa2F1DsPdeuUDrmyvT4mjTZ4xN4MPY
	sluwqqKkrhpLpCPWo5PE2Ktgo9JvuOFJOIBN+t/REyNbIPqan3+cSBbVw3qD81qBjQXH
	b4sZjrfhtIUSuNhgTJc96nT32DhQP/NE8dGefciiAcr2K8BdxHdUoxBwhnavLGkYaTq7
	JdYXRxFNtvS7vFfQXiqNOFSYpN8GvqQb9ApFqaCCv6O4qU5byY5GyFGr7XX950QOQL/3
	D/btHV5+diY8kV+rSoSe4Xsx1Hhu/ca5iomLKr3i5jObcyboUqzeJv8BM3lj1o64XRiz
	3QdQ==
X-Gm-Message-State: APjAAAWkrMUlkLui4XEToGpxL4ABH+QTpKWvFebo9nP5YP96VfA5HZjf
	MC6+X29BMJEq/eQJ2BudqQBAfk2h
X-Google-Smtp-Source: APXvYqza9vkplNe1zHbdZHGFLAvua4bSEJpXPn24l3mVX6p3UWp68eSZV0wjREN4YbdQE1ur70H1mA==
X-Received: by 2002:adf:f803:: with SMTP id s3mr18286487wrp.54.1555103190708; 
	Fri, 12 Apr 2019 14:06:30 -0700 (PDT)
Received: from localhost (x4d0c5397.dyn.telefonica.de. [77.12.83.151])
	by smtp.gmail.com with ESMTPSA id
	h12sm40804140wrq.95.2019.04.12.14.06.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:06:30 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Fri, 12 Apr 2019 23:06:17 +0200
Message-Id: <1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 3/4] target/ppc: improve performance of large
 BAT invalidations
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
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412210617.xzRv6RkihDfEcxwbyIDJEtiMpbSaE5OQL3XvBvUFQU8@z>

Performing a complete flush is ~ 100 times faster than flushing
256MiB of 4KiB pages. Set a limit of 1024 pages and perform a complete
flush afterwards.

This patch significantly speeds up AIX 5.1 and NetBSD-ofppc.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/ppc/mmu_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 4a6be4d..d7eed3a 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1809,6 +1809,13 @@ static inline void do_invalidate_BAT(CPUPPCState *env, target_ulong BATu,
 
     base = BATu & ~0x0001FFFF;
     end = base + mask + 0x00020000;
+    if (((end - base) >> TARGET_PAGE_BITS) > 1024) {
+        /* Flushing 1024 4K pages is slower than a complete flush */
+        LOG_BATS("Flush all BATs\n");
+        tlb_flush(CPU(cs));
+        LOG_BATS("Flush done\n");
+        return;
+    }
     LOG_BATS("Flush BAT from " TARGET_FMT_lx " to " TARGET_FMT_lx " ("
              TARGET_FMT_lx ")\n", base, end, mask);
     for (page = base; page != end; page += TARGET_PAGE_SIZE) {
-- 
2.7.2


