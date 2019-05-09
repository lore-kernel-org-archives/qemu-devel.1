Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ECC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816A820675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rb51GKEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816A820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48627 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcDY-0001tp-ER
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:07:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8w-0005yv-GB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8t-00072s-Sj
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc8t-00072d-N3
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:55 -0400
Received: by mail-pf1-x443.google.com with SMTP id l132so714818pfc.8
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=w7l/Pbs/dkuyE6y60mYyZzngNGSZYjs+O6jEPehbb2U=;
	b=Rb51GKEkncGqGkbD0+hvkPavsJzccUSgbc9MBU86m7rUcT2RRJe0qvbRHy8/Imjdsa
	2DkXSAzUL2Iog5PG9JNk0oQdRmzNBbDJ/aEqmPlFE/0S+LyIzs/DBSxjGysTAWWFQ9F6
	DXrnB9qiuJWKw16zXIbE1EhnNrsAd7PmVByCf15lYL0pO32rIt34clbmYjOwr55A5IZJ
	vh3vRbK/yqwJ902DzW+l1n9QyqrXTbl0/pha/HIFzrEleIAhuKsMPv/KU1gePXGUT5v4
	Q5N+8HCn/JibJJMKyjIm9H6EUdP4dEvANDCtKaBz4LumAC+zVkOWZPkgvyXjifz6YDGg
	rZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=w7l/Pbs/dkuyE6y60mYyZzngNGSZYjs+O6jEPehbb2U=;
	b=MqZX61+/+b39h5n7NvOxmDDY7r+g4fRsaf4oocMCjHyOzhy2zDJyi1yy0DOIuqqgCL
	YOWlLIKuqwGNrsxt856N+Tebq+7AAeHcyNcsjV3HqUNP6nDTCb7h4dIXPNfwqRFKroAM
	gjyFwwuQRixmOEhiCCKqLvfvsG+3Rdp3oNcRwFDqRG5knmuwVxd8K0OuUdvhNvgyQY27
	ZwBcTPLVoRVo4Sy6YJiWoDDZyhlzVhk/8ZM551szABnhqPz0GjrrkKSoHMofYbVBrZ+B
	13rFT4OQEiuDrN9Zxb3H/KyJxfWG4qmksgkbUlQtvjghd+6BGVvBl7Mn2OVZBNPoBxde
	2aQQ==
X-Gm-Message-State: APjAAAUO5l9xWwyiaXRcJ0db0jHYl54YjpR0KVi3vYBGmyjPF2C7No2+
	xwGEHAw4TITO0CZpLd27en8HcaMcBnM=
X-Google-Smtp-Source: APXvYqw7rmZzXG9oo0wTTrtfA1Nxk75Gml1em6vNKodmedkCkjEmhgjfnLK5o2e8ROgkqywM+nDe4g==
X-Received: by 2002:a62:fb0a:: with SMTP id x10mr2521061pfm.179.1557381774503; 
	Wed, 08 May 2019 23:02:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.02.53
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:02:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:24 -0700
Message-Id: <20190509060246.4031-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 05/27] target/hppa: Convert to
 CPUClass::tlb_fill
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  8 ++++----
 target/hppa/cpu.c        |  5 ++---
 target/hppa/mem_helper.c | 22 +++++++++++++++++-----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 923346adb6..c1e0215e66 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -360,10 +360,10 @@ int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
-#ifdef CONFIG_USER_ONLY
-int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                              int rw, int midx);
-#else
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
+#ifndef CONFIG_USER_ONLY
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot);
 extern const MemoryRegionOps hppa_io_eir_ops;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index e64f48581e..9717ea1798 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -163,9 +163,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
     cc->gdb_read_register = hppa_cpu_gdb_read_register;
     cc->gdb_write_register = hppa_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = hppa_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_hppa_cpu;
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 77fb544838..5cee0c19b1 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -25,8 +25,9 @@
 #include "trace.h"
 
 #ifdef CONFIG_USER_ONLY
-int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
-                              int size, int rw, int mmu_idx)
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
@@ -34,7 +35,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
        which would affect si_code.  */
     cs->exception_index = EXCP_DMP;
     cpu->env.cr[CR_IOR] = address;
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 #else
 static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
@@ -213,8 +214,9 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return excp == EXCP_DTLB_MISS ? -1 : phys;
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                       MMUAccessType type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
@@ -236,6 +238,9 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     excp = hppa_get_physical_address(env, addr, mmu_idx,
                                      a_prot, &phys, &prot);
     if (unlikely(excp >= 0)) {
+        if (probe) {
+            return false;
+        }
         trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
         /* Failure.  Raise the indicated exception.  */
         cs->exception_index = excp;
@@ -252,6 +257,13 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     /* Success!  Store the translation into the QEMU TLB.  */
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
+    return true;
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
+{
+    hppa_cpu_tlb_fill(cs, addr, size, type, mmu_idx, false, retaddr);
 }
 
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
-- 
2.17.1


