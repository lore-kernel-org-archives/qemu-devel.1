Received: from eggs.gnu.org ([2001:4830:134:3::10]:45118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-0006pk-K1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwl-0005w9-HO
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwl-0003ah-56
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:39 -0400
Received: by mail-pg1-x544.google.com with SMTP id c10-v6so4737621pgq.4
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:51 -0700
Message-Id: <20181011205206.3552-6-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/20] target/arm: Mark some arrays const
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 736880ee71..d59ffa1c67 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -72,7 +72,7 @@ static TCGv_i64 cpu_F0d, cpu_F1d;
 
 #include "exec/gen-icount.h"
 
-static const char *regnames[] =
+static const char * const regnames[] =
     { "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
       "r8", "r9", "r10", "r11", "r12", "r13", "r14", "pc" };
 
@@ -4907,7 +4907,7 @@ static struct {
     int nregs;
     int interleave;
     int spacing;
-} neon_ls_element_type[11] = {
+} const neon_ls_element_type[11] = {
     {4, 4, 1},
     {4, 4, 2},
     {4, 1, 1},
@@ -13089,7 +13089,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
     translator_loop(ops, &dc.base, cpu, tb);
 }
 
-static const char *cpu_mode_names[16] = {
+static const char * const cpu_mode_names[16] = {
   "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
   "???", "???", "hyp", "und", "???", "???", "???", "sys"
 };
-- 
2.17.1
