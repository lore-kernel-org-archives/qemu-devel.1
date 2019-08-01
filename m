Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2045FC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF12E20838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dsyu8dRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF12E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFyI-0005rl-7x
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59336)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqT-0005vr-3N
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqR-0002Sj-AW
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htFqP-0002PG-5F
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id p17so74604542wrf.11
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3ACUCJ4J4ZTgyEv5rJDA4/ZTS/t+qCZGcs+88DOJKtM=;
 b=Dsyu8dRbkRv6Z6/o2I3QGG2JObWj+0cw1TybpS+MLUg6RIOpcIDTsmlQSBJO/CJN7y
 9ftWu5Dzuj10ZSg3UdSQsbKaW4bk3mBL1Z7z5JM1+b5d216T3U4S08XBL3Z6eZzP7OxT
 Y4V9jcUAipheMj4zzF1pGr59G9yTVKuBiX+K6WqOTMN8A5G7elgLSvLotw3eXXECjWQk
 KZHOLAqRUmFJAN4KaX3/nMeOJghArqBWRx3ZArm3qqp5ioi9Vd9+/s7x06cQKtbk/+O6
 hpDW+/8hbD6V2HQeffJV6dor+M0/Go0epXYTcZx5i0MhORIG9c/iqvlWEXk7eW/+MzgX
 F+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3ACUCJ4J4ZTgyEv5rJDA4/ZTS/t+qCZGcs+88DOJKtM=;
 b=BnOBjgnPWXtdgiO4G2HtwECSN6QI/KGNxHTyNHehz9k9ybey7E4Os61v5Cyx1XiCks
 log5Hd7o7jERN7Z5pjkT5cZ/h1fmochbYIz2TvR/Ty5hSy1Jy8BMFQUsk7eFVVwKFVdr
 fYPAS1q7ocMI3Ymts6dEaH775ZXj+B1OekmoTHpL77ErFADP1/rPuR0K3hE5LlSTR4nl
 cTX1TI1HB5Y27JQzUKLGnGuQWKdVbhCyMONna6eWCKFJYCcK5XHOba4/szMGFUkKDSxP
 uv18WXRohjjjNemEiP8DCJmb05RIx9aGGN5nG6UzLaM839+QlyKx1pZ2mMwa8ph34yjQ
 EQ8Q==
X-Gm-Message-State: APjAAAWKAoukyFiUy1oowOX/AEypd9ekvnBSjujN4exn0j74ha1W3Ngi
 N66RAdigi6NrKzBzJe4SbuJ8uy/B1PXOYQ==
X-Google-Smtp-Source: APXvYqydhDFvlAuN8tjcCAXDcft5Rq4xi8kNNkesauPrWp0qqnj2PX+0f2aZ9YkeJCo/GYBZQxxaiQ==
X-Received: by 2002:adf:f046:: with SMTP id t6mr26164668wro.307.1564684222387; 
 Thu, 01 Aug 2019 11:30:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm71702104wrw.23.2019.08.01.11.30.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 11:30:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 19:30:12 +0100
Message-Id: <20190801183012.17564-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801183012.17564-1-peter.maydell@linaro.org>
References: <20190801183012.17564-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 7/7] target/sparc: Switch to
 do_transaction_failed() hook
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the SPARC target from the old unassigned_access hook to the
new do_transaction_failed hook.

This will cause the "if transaction failed" code paths added in
the previous commits to become active if the access is to an
unassigned address. In particular we'll now handle bus errors
during page table walks correctly (generating a translation
error with the right kind of fault status).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/cpu.h         |  8 +++++---
 target/sparc/cpu.c         |  2 +-
 target/sparc/ldst_helper.c | 16 ++++++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 8ed2250cd03..0bf365bed22 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -614,9 +614,11 @@ static inline int tlb_compare_context(const SparcTLBEntry *tlb,
 
 /* cpu-exec.c */
 #if !defined(CONFIG_USER_ONLY)
-void sparc_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
-                                 bool is_write, bool is_exec, int is_asi,
-                                 unsigned size);
+void sparc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr);
 #if defined(TARGET_SPARC64)
 hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
                                            int mmu_idx);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ee60a5536a0..bc659295520 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -877,7 +877,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = sparc_cpu_gdb_write_register;
     cc->tlb_fill = sparc_cpu_tlb_fill;
 #ifndef CONFIG_USER_ONLY
-    cc->do_unassigned_access = sparc_cpu_unassigned_access;
+    cc->do_transaction_failed = sparc_cpu_do_transaction_failed;
     cc->do_unaligned_access = sparc_cpu_do_unaligned_access;
     cc->get_phys_page_debug = sparc_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_sparc_cpu;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 91cd0b593ef..7345827a966 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1943,11 +1943,19 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 #endif /* TARGET_SPARC64 */
 
 #if !defined(CONFIG_USER_ONLY)
-void sparc_cpu_unassigned_access(CPUState *cs, hwaddr addr,
-                                 bool is_write, bool is_exec, int is_asi,
-                                 unsigned size)
+
+void sparc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr)
 {
-    sparc_raise_mmu_fault(cs, addr, is_write, is_exec, is_asi, size, GETPC());
+    bool is_write = access_type == MMU_DATA_STORE;
+    bool is_exec = access_type == MMU_INST_FETCH;
+    bool is_asi = false;
+
+    sparc_raise_mmu_fault(cs, physaddr, is_write, is_exec,
+                          is_asi, size, retaddr);
 }
 #endif
 
-- 
2.20.1


