Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17540C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE09D2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE09D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37747 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRP01-0006xQ-59
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 18:37:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyP-0005qY-82
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyO-00024i-3H
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hROyN-000207-QL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:36 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N6bsG-1gc2OY0DJm-01861d; Fri, 17 May 2019 00:35:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 00:35:14 +0200
Message-Id: <20190516223519.7520-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516223519.7520-1-laurent@vivier.eu>
References: <20190516223519.7520-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mD9HteA2IFi9s1K5T83VMGrv0hpvBwVXoe9rDB5eXNP/haHwuQt
	cYN9bBB/2YWBVsEnn8j2y/4o1VsYtmMtYXLm6yh+Dh7Eh3R38wA8pEcClSJHh4W1UCpHrRA
	/xbxgCS4TZpSUgdVp8YlqdcfJ+wtrcn3X6SoQeCNzZEWgopPJVWjwAubR0bGmo3hfYsdvz2
	5P1XATwrPFIZ6aQAkA7vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zwm4bP9DNDE=:L6PDi8m94BmOKcfPkmct3D
	QtV7DQyhqm8PlzRNYi/Kc12pZ+27Rs9EfqFcprN/UVngIZjOKtUI/GVRDkYNFzuydxpCNytMK
	p52+/cRqOwm4wCJ981J4k6SOYt3UwWVMAG1C6ngUyNEMOei7SO/vjAA08mnCt5Nu0QdI4drmn
	fmZGiTGgKrJBwy8bBCpLfivh+FlGuKe9L0ptWjaLTCzssZk+LH8NQ0Zgammw2UcYDJx72xo8S
	4s5pJvAcoT3YJ3BC38dm0+yiPd5A+Ck/cwv5xRqo1F/bMyAJ9ftYsbG46vwoeAScdcb4tar4P
	YzQAMCNQcxx9u0K/PFWkqfaN0d/FWIsR7g0qpIWoFn2TRhMh5lfsVFWLD5Zff4atJMGoxSeCu
	e5SEy60BDNnSk1wHg+wotH7RgJEhpkgyGPub3UQPosbs1HVTL0wFrSEAqIKwNRPBlg7tydb5O
	ZLMmPp7LCZoTslvl2NYJi5UT+Nc6NqRftZTVybIZ5VhXDVhQ40pi4QegPd4a0syLYeniANy5q
	pmns3GX9FtTPUn1ifNEO7bft1+QLJoiBYeP2QLPtjpVjzPciycp/ADCJ5LEEYpUoyshG0hioB
	CxxsU1AbPcQ9zkWF0HpWSxsDi7GIsdb42jOlnEgVb8VqZIM26L+unr3odidd6u+UKx/HDzMfP
	MO9Ydv2NAXWs5jEmKSI+HD7RZFq2ryNJ8fxwFWoZZbMwa4GCuT2I/l6tglJ6dzMzymFGQ1Dwe
	P/K+6u9Z+QyuJeTphb2z85LKVTyGSFz65habUg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 1/6] target/m68k: In dump_address_map() check
 for memory access failures
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
Cc: Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In dump_address_map(), use address_space_ldl() instead of ldl_phys().
This allows us to check whether the memory access failed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181210165636.28366-2-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/helper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index d958a34959..5b81995ee7 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -403,6 +403,7 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
     int last_attr = -1, attr = -1;
     M68kCPU *cpu = m68k_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
+    MemTxResult txres;
 
     if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
         /* 8k page */
@@ -416,22 +417,29 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
         tib_mask = M68K_4K_PAGE_MASK;
     }
     for (i = 0; i < M68K_ROOT_POINTER_ENTRIES; i++) {
-        tia = ldl_phys(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4);
-        if (!M68K_UDT_VALID(tia)) {
+        tia = address_space_ldl(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4,
+                                MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK || !M68K_UDT_VALID(tia)) {
             continue;
         }
         for (j = 0; j < M68K_ROOT_POINTER_ENTRIES; j++) {
-            tib = ldl_phys(cs->as, M68K_POINTER_BASE(tia) + j * 4);
-            if (!M68K_UDT_VALID(tib)) {
+            tib = address_space_ldl(cs->as, M68K_POINTER_BASE(tia) + j * 4,
+                                    MEMTXATTRS_UNSPECIFIED, &txres);
+            if (txres != MEMTX_OK || !M68K_UDT_VALID(tib)) {
                 continue;
             }
             for (k = 0; k < tic_size; k++) {
-                tic = ldl_phys(cs->as, (tib & tib_mask) + k * 4);
-                if (!M68K_PDT_VALID(tic)) {
+                tic = address_space_ldl(cs->as, (tib & tib_mask) + k * 4,
+                                        MEMTXATTRS_UNSPECIFIED, &txres);
+                if (txres != MEMTX_OK || !M68K_PDT_VALID(tic)) {
                     continue;
                 }
                 if (M68K_PDT_INDIRECT(tic)) {
-                    tic = ldl_phys(cs->as, M68K_INDIRECT_POINTER(tic));
+                    tic = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(tic),
+                                            MEMTXATTRS_UNSPECIFIED, &txres);
+                    if (txres != MEMTX_OK) {
+                        continue;
+                    }
                 }
 
                 last_logical = logical;
-- 
2.20.1


