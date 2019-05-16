Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B85AC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5FC2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5FC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37761 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRP20-0008QU-9q
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 18:39:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyP-0005qX-7t
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyN-00023Z-Ph
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:37 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34667)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hROyN-0001zj-Fy
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:35 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MXY2T-1hB6672YX9-00Z2OC; Fri, 17 May 2019 00:35:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 00:35:15 +0200
Message-Id: <20190516223519.7520-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516223519.7520-1-laurent@vivier.eu>
References: <20190516223519.7520-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Wst5CG7txb52InukpGjmYIqgpKtQBEZ9xOoRzes4il0BZ+Jl7y4
	6fR6iXYPNBxE3fhnPzaqS0Rrr4pNWioKfeHIJUgcxg0YhdkvPgZukYZ1YTRqRh1ellzsiK9
	dc0M7Ej16rJDoIkD/BLzFep3uX3HlDOLFkCT3F2/d0BCSjGa7zskJp67G9ranY9y5i6lmzB
	qzMRBcF9YdnEWq2B6MUbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2z7gLuM97CE=:fzEU6IrtDr6eW0MevMd0qw
	jHtSfJrWN/9rEd6XProGArOiwJP4WEZLas8W4NREUzX2OExMSDA0nP1xXlAR2zF0cW1KWnw2P
	ydINB3B9TeHqcAsvXnZ99EGSu5bu4cD++DRtzE7PPp2NezuxgAsPhJHXxUoq1oeAizYnN8Fxe
	t4b/33Dr9aMuMmMyzJPa5DkuMzJs1wRaBklwnnV7nnT+73/HMEuN94pg1GfZcDpSEH7/KmF21
	6R9btUw1pYcQ05Cv750g1pj1rDC0o6HvmpSm/4K5v1kXkqeb3EwoemORTci9iSiRLti9jpgRN
	GWFwRZzLi3V8DBobHNDIeVJtu+Bugyh2dUgF2MPLnScj1gkZuwBW6nKCAjfOBguPa/ofcsdP/
	nb0Agxhe2vC9RBNw712DGhpmOWqvZ/U+D0WDqzlT6ak44EbBLZHoAjIxZ5nJ8vsz3FxlPuSz4
	HmJMcu8FTkiPKYN1nE7EyrlDoe1iXYYCIltWycnrcKGnZTja15spsc9+VQPzMk+ngheC4mZaM
	aEsvKxQOM8AANySMo1/Ymp3LYxGuBcKJdNWbIUx/411XX5PIt+EHdZQsMs3KjXScF2kaaTkNZ
	VSe09WS4lNJFPPs6YP/8pxpFKuXJnHjSK8J1U4eQasKSNm10bk55zwkzAg56BQ9a1QU6kAQ6O
	hPh9AlDrE1OPZifh8u4Xwqnmy/WefHLdEhFCFVQgTX/HHHMQLRXpDvMSTmbjV5gKDqfxWLDQU
	TZMkImnRka8tO6AJLQOzIT4UJcd5WZPZTX8VUA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 2/6] target/m68k: In get_physical_address()
 check for memory access failures
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

In get_physical_address(), use address_space_ldl() and
address_space_stl() instead of ldl_phys() and stl_phys().
This allows us to check whether the memory access failed.
For the moment, we simply return -1 in this case;
add a TODO comment that we should ideally generate the
appropriate kind of fault.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181210165636.28366-3-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/helper.c | 62 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5b81995ee7..edd7bb64ed 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -651,6 +651,7 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     bool debug = access_type & ACCESS_DEBUG;
     int page_bits;
     int i;
+    MemTxResult txres;
 
     /* Transparent Translation (physical = logical) */
     for (i = 0; i < M68K_MAX_TTR; i++) {
@@ -680,12 +681,19 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     /* Root Index */
     entry = M68K_POINTER_BASE(next) | M68K_ROOT_INDEX(address);
 
-    next = ldl_phys(cs->as, entry);
+    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (txres != MEMTX_OK) {
+        goto txfail;
+    }
     if (!M68K_UDT_VALID(next)) {
         return -1;
     }
     if (!(next & M68K_DESC_USED) && !debug) {
-        stl_phys(cs->as, entry, next | M68K_DESC_USED);
+        address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                          MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK) {
+            goto txfail;
+        }
     }
     if (next & M68K_DESC_WRITEPROT) {
         if (access_type & ACCESS_PTEST) {
@@ -700,12 +708,19 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     /* Pointer Index */
     entry = M68K_POINTER_BASE(next) | M68K_POINTER_INDEX(address);
 
-    next = ldl_phys(cs->as, entry);
+    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (txres != MEMTX_OK) {
+        goto txfail;
+    }
     if (!M68K_UDT_VALID(next)) {
         return -1;
     }
     if (!(next & M68K_DESC_USED) && !debug) {
-        stl_phys(cs->as, entry, next | M68K_DESC_USED);
+        address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                          MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK) {
+            goto txfail;
+        }
     }
     if (next & M68K_DESC_WRITEPROT) {
         if (access_type & ACCESS_PTEST) {
@@ -724,27 +739,46 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
         entry = M68K_4K_PAGE_BASE(next) | M68K_4K_PAGE_INDEX(address);
     }
 
-    next = ldl_phys(cs->as, entry);
+    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (txres != MEMTX_OK) {
+        goto txfail;
+    }
 
     if (!M68K_PDT_VALID(next)) {
         return -1;
     }
     if (M68K_PDT_INDIRECT(next)) {
-        next = ldl_phys(cs->as, M68K_INDIRECT_POINTER(next));
+        next = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(next),
+                                 MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK) {
+            goto txfail;
+        }
     }
     if (access_type & ACCESS_STORE) {
         if (next & M68K_DESC_WRITEPROT) {
             if (!(next & M68K_DESC_USED) && !debug) {
-                stl_phys(cs->as, entry, next | M68K_DESC_USED);
+                address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                                  MEMTXATTRS_UNSPECIFIED, &txres);
+                if (txres != MEMTX_OK) {
+                    goto txfail;
+                }
             }
         } else if ((next & (M68K_DESC_MODIFIED | M68K_DESC_USED)) !=
                            (M68K_DESC_MODIFIED | M68K_DESC_USED) && !debug) {
-                stl_phys(cs->as, entry,
-                         next | (M68K_DESC_MODIFIED | M68K_DESC_USED));
+            address_space_stl(cs->as, entry,
+                              next | (M68K_DESC_MODIFIED | M68K_DESC_USED),
+                              MEMTXATTRS_UNSPECIFIED, &txres);
+            if (txres != MEMTX_OK) {
+                goto txfail;
+            }
         }
     } else {
         if (!(next & M68K_DESC_USED) && !debug) {
-            stl_phys(cs->as, entry, next | M68K_DESC_USED);
+            address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                              MEMTXATTRS_UNSPECIFIED, &txres);
+            if (txres != MEMTX_OK) {
+                goto txfail;
+            }
         }
     }
 
@@ -776,6 +810,14 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     }
 
     return 0;
+
+txfail:
+    /*
+     * A page table load/store failed. TODO: we should really raise a
+     * suitable guest fault here if this is not a debug access.
+     * For now just return that the translation failed.
+     */
+    return -1;
 }
 
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.20.1


