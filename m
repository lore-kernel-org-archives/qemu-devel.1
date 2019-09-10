Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6FBC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C582081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C582081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jG3-000594-8z
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j7q-0004VY-Go
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7p-000214-FZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:18 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7p-0001zX-6l
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:17 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYehP-1hc3TT3cWp-00VeZS; Tue, 10 Sep 2019 18:36:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:52 +0200
Message-Id: <20190910163600.19971-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NrnoZuyyvRcyXw1YmJnEBT5z5hd9yw8C+ku7f8wk+z9qKrAlHck
 uCVbZz7r6GrkavrDF4ketOG9NLa70mg8LNA6VvR1+h8inYuG+LSc+5AOimViH1QqOAc1zu6
 QvfleKpfOoVL3VIuK/P15SXBUkgd/bBuEVNWkTgH1GJjbC02C/rKSVKN1QVq9CUKNH9rdbl
 NuUOiF2kSSPo8ZJv01eSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:INcU2wQI8OU=:Ff0ZBHMdaNTC0/POC9Fpdm
 QntY9sG9OO+S9w0NXg+kBTPA5kZp/Qmt9sBdUysiKhamNP2zoY78Pcez4Nujqt/9qBHtZ1xoS
 L2t4eC57uH8k/6EBi2+l6L3en6rr9VKJnKOVNiPN5Yu8RTpLdBesaRBuYYnlj2Pdn4VJQG7Xq
 3gLZ5s19Rza3BJcHTLbhq+L2A7msjhNezC3C7VooNTxZbCSH/rjawtdUSDeHe7hlynntnQMWx
 3F9SVuNzAAb5YGc+Ir79CSMpwXnCC5NVvqATn1WsNuzSZBYI23BkkCIY/vyvLX8YKvFdJu8oc
 UwmlkstbMt5P8ecUPJJpWl5pqnVV3sERYHj2E5f4Ph1kgk0AwBZS6zYsBE4KRzCRm5qkRFMhy
 C9FANKi0SpPDEcLP6XbBcL126EzBHXsa6bm8C0PLMjHnph81Eqa9UQIup2f/CAWfi7mpjEyxX
 fbS3go4CA/NyVpRsmdvcldEnH7uAwoqqekXyRX0yoTDG+YJ5Zf1Iz9GZQdvo3uyxOrycG4nat
 Z1NZvseb2dfsanDIsMoaq+ZzLfKCRXfyH0fnuw5I0T/1fxiDJb21PV6u1qx2fiDhnz4oF001r
 rnXW1E+tzKasdhoPPNrbogoT3M0HHo0NHhc4NqtR3FSLDG9GlukaS7giO5NdBdk09jsfs135U
 4S6Eiv0ylbkNweq/EFfVXMnUIJAA5hXDnTDj8EQgZNdqdPEkBkEjUyacdCUIL1DwEZEJmUiDA
 PPHt6nMbveX0MwJIio+T3nzV2/+Bk0h/Y4176HgLcAypWPldwdAD6i39cu0xZdvoYL5GzEAPy
 IvuBGfFp1iL1RKAUErHEqb8JpLPwSbRwpe7EgDSEB/mPcItlZ8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PULL 07/15] linux-user/arm: Adjust MAX_RESERVED_VA
 for M-profile
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Limit the virtual address space for M-profile cpus to 2GB,
so that we avoid all of the magic addresses in the top half
of the M-profile system map.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190822185929.16891-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/arm/target_cpu.h | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 279ea532d5b7..3f79356a07fc 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -19,9 +19,27 @@
 #ifndef ARM_TARGET_CPU_H
 #define ARM_TARGET_CPU_H
 
-/* We need to be able to map the commpage.
-   See validate_guest_space in linux-user/elfload.c.  */
-#define MAX_RESERVED_VA(CPU)  0xffff0000ul
+static inline unsigned long arm_max_reserved_va(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        /*
+         * There are magic return addresses above 0xfe000000,
+         * and in general a lot of M-profile system stuff in
+         * the high addresses.  Restrict linux-user to the
+         * cached write-back RAM in the system map.
+         */
+        return 0x80000000ul;
+    } else {
+        /*
+         * We need to be able to map the commpage.
+         * See validate_guest_space in linux-user/elfload.c.
+         */
+        return 0xffff0000ul;
+    }
+}
+#define MAX_RESERVED_VA  arm_max_reserved_va
 
 static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
 {
-- 
2.21.0


