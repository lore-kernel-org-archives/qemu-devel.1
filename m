Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A705C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C4A2081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C4A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PzG-0000Fd-Kc
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1i8Pft-0002aO-VM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1i8Pfs-0000i4-T9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:02:17 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:53956
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1i8Pfs-0000hI-NX; Thu, 12 Sep 2019 10:02:16 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 0CEDE81549;
 Thu, 12 Sep 2019 16:02:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pIj6RhTj-Hn; Thu, 12 Sep 2019 16:02:14 +0200 (CEST)
Received: from localhost.localdomain.localdomain
 (lfbn-tou-1-447-75.w86-206.abo.wanadoo.fr [86.206.4.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id C77FA8138C;
 Thu, 12 Sep 2019 16:02:14 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Date: Thu, 12 Sep 2019 16:02:00 +0200
Message-Id: <1568296920-29939-1-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.98.77.210
Subject: [Qemu-devel] [PATCH] target/m68k/fpu_helper.c: rename the access
 arguments
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "access" arguments clash with a macro under Windows with MinGW:
  CC      m68k-softmmu/target/m68k/fpu_helper.o
  target/m68k/fpu_helper.c: In function 'fmovem_predec':
  target/m68k/fpu_helper.c:405:56: error: macro "access" passed 4 arguments,
   but takes just 2
               size = access(env, addr, &env->fregs[i], ra);

So this renames them access_fn.

Tested with:
 ./configure --target-list=m68k-softmmu
 make -j8

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 target/m68k/fpu_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 9b039c8..4137542 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -396,14 +396,14 @@ typedef int (*float_access)(CPUM68KState *env, uint32_t addr, FPReg *fp,
                             uintptr_t ra);
 
 static uint32_t fmovem_predec(CPUM68KState *env, uint32_t addr, uint32_t mask,
-                               float_access access)
+                              float_access access_fn)
 {
     uintptr_t ra = GETPC();
     int i, size;
 
     for (i = 7; i >= 0; i--, mask <<= 1) {
         if (mask & 0x80) {
-            size = access(env, addr, &env->fregs[i], ra);
+            size = access_fn(env, addr, &env->fregs[i], ra);
             if ((mask & 0xff) != 0x80) {
                 addr -= size;
             }
@@ -414,14 +414,14 @@ static uint32_t fmovem_predec(CPUM68KState *env, uint32_t addr, uint32_t mask,
 }
 
 static uint32_t fmovem_postinc(CPUM68KState *env, uint32_t addr, uint32_t mask,
-                               float_access access)
+                               float_access access_fn)
 {
     uintptr_t ra = GETPC();
     int i, size;
 
     for (i = 0; i < 8; i++, mask <<= 1) {
         if (mask & 0x80) {
-            size = access(env, addr, &env->fregs[i], ra);
+            size = access_fn(env, addr, &env->fregs[i], ra);
             addr += size;
         }
     }
-- 
1.8.3.1


