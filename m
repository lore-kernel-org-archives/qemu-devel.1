Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F6ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EEC222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EEC222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7whA-0005H0-5U
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRf-00061x-8n
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRe-0004Mz-7K
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRd-0004MP-Va
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:38 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M433w-1i7wRV0koi-0005Zb; Wed, 11 Sep 2019 08:49:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:12 +0200
Message-Id: <20190911064920.1718-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j1F0yFaoMBQbhDzxmPD/ys5XuuMgxXp2xefCRwWzaxgBAq1Qh3Y
 XnXREZG434/svVgJWbJFkhZWP2mZgf+nj1Wd+MNGLW54VD0DuihYSGH9mjuYsFyBAvdvfb3
 DSfavkSh/rrOerPWH9p1PIO7ZFOQE8vWQ/IB1i5Mcdt83cPdFQ6LnUDJ0yHOr0iXYXDtQbo
 5sW5mhIBET57KsWKgLUHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KvlJrzyYUls=:nUrra4ZjROo/bXiDf4TkaG
 DpJTcZ3KbUbA/oB5W1FAlyOYtcwt373QGxC9h/7fUTdc/amveaIpeuEcx9hiYsbHpcS+PnGNp
 1ggUaT3/L7ThyUGweeBC8PhvSGiqL899UFVIQ6kH4RcsbIGMSBOezIAGokE4dQx0pQSdw3Ot9
 kUICto5xq+46r2uvKHk6Doje2Vsr8UJTKTWXVUmWrpgxt+A0qFPq0GVb/3MJOrVS6gtCfXt96
 JQ5YbvoaXxBzh2iK/+7/tT37ETZWPEB+73M8b0fLzZ61HyCXrVlX9F0MbTRxYWT7/wydno5Gl
 unvrJIbLnVlageGdJ2BxjOxlAsWwhiD4Lrb5A0RQQG28Y/qw5bYkyKAJMxMcBj2tHwrkt9H6Z
 SpHA+bSYz53KVsGGCCtiA0hAPi3qBvQMQl65e+WZ/Pg9AtVUNis4T2aoH3t2bfsmefrpYFUqi
 QyUsG10PqwM3Q7OsI/NDFGNmq4vWJHJ/wmSvRa6pCCXzs1rzBXsSu7gIAr+8RHBpD9k1uOAqg
 uTSOsSLmS1MaSG7z+gO0XIzG1uVGhkD/k6tCdfy+rEJC/sjzz3KZwPAHvJQjYTDI/8gjs1uQC
 JZZ5WG/v025B9zj+7FJirH5oY0FqRt5b8jwWNSvw7nEuq+wTSPzFUNwNKcfHAR4kqOe7Ac2I1
 qzEtQ9LLjpTMsCNsJ+JqseZG7vkuCz5dHE87Ni4rgnEThrCgxoyN6YRa/ENdsAL3UmgGCdxKm
 hv8/Icf8qlrWSNQKYJoqmD9/d0j3hiB3+GP25MS/GYZiQqMEsY3ZQBRxncda4FXZ3Bbnda6Lx
 bCDKTgldaPP/DqpHC1kfcf26DWuq5KoOOKTrNzGoqMdmnVk5ZnyLTmY5HhbHXsNSwIsdWybAR
 W+dMya93idaAwZAZ8Gmo3SDOR/fAN3XIdQyEdqkx3jtsvEvjv4ZT30NnpDISMzxOcEwJoyhqq
 Dwj8xb8D619mtdNdgsbWgH3bmEo3UjU5vDrjVHSyeso7XqyVe2cX7vCnU+QDrMlYmer45+Zm5
 xWw56EaQ7WW0DhBDxU62KX0bmc7GVgdKFEaBJTK2QV72
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PULL v2 07/15] linux-user/arm: Adjust MAX_RESERVED_VA
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


