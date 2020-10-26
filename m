Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F5FC5517A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA77320878
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA77320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAks-00022D-QA
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAai-0005cg-SW
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:48 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAah-0005FB-2s
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:48 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MD9nd-1kfjA62qDx-0099Rk; Mon, 26 Oct 2020 23:03:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] linux-user: update mips/syscall-args-o32.c.inc to Linux
 5.9-rc7
Date: Mon, 26 Oct 2020 23:03:35 +0100
Message-Id: <20201026220339.195790-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026220339.195790-1-laurent@vivier.eu>
References: <20201026220339.195790-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:39gxY8zbYF5wRP6WSzIWuuv77Ru4bWDfw1Ezo+Mj4tDeFze11jl
 9uKdBKst6eE83JNB4XZPNnuzP/S9BjONbH8y1odpDCFlFU2ul1ET5Pc0PCyNcBw3KDkFYV6
 FnZvzAoXJ8pmykcgAlar0AwlAh0kltWh+w9Fabm9pa0TYceXQvNs359eS5zh5k0Jkfvpsax
 QH71RoAOgi6rXcdyNAb4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDkUNIn1q1Y=:POLv1YzuHhzVfiHgL08xRm
 mp9ExwiuDEpU7Y0UBu2ddjv5y1CUG3M4osfLhYunlMPKchJkeWHXEr9YKZwHVh4hSYKueDDWL
 23Mc7yIRSSyrP89xIW7xhjDbDTN/OsXwquqSeF9zXjaJ1bIOjk5W48W7E+CWnMCv1U9WqLUAW
 blD4iLLJv+x9LsnBmdGLri9ZRCcfbHhq79um5t2qcbjMK+iTi2owBseMTmc+0rKC1nZLWxbAa
 k+2d+qPDHjHJbp97nOtNhHnmPgB+hH89BH6kYoIvA9riwm4HKZxoA5/g9J5qJtRlc6jWepz0M
 dif7m6hSrLkvfrasoAQjZKaH61JWEkZXOTJ2neokkiUQutNygwGXctRZqUvlmcp5fO5o6ct8r
 jndmmINZituKAQXFTOPHXHUNPHYqbBG9j3tdm8jMI0ImOp1TXghpJp0L4ZKOzmHD/fANpDi8n
 bsWu3AEY1w==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 18:03:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Updated running scripts/update-mips-syscall-args.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200930003033.554124-3-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/syscall-args-o32.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mips/syscall-args-o32.c.inc b/linux-user/mips/syscall-args-o32.c.inc
index 0ad35857b4e4..92ee4f921ec7 100644
--- a/linux-user/mips/syscall-args-o32.c.inc
+++ b/linux-user/mips/syscall-args-o32.c.inc
@@ -434,3 +434,7 @@
     [ 433] = 3, /* fspick */
     [ 434] = 2, /* pidfd_open */
     [ 435] = 2, /* clone3 */
+    [ 436] = 3, /* close_range */
+    [ 437] = 4, /* openat2 */
+    [ 438] = 3, /* pidfd_getfd */
+    [ 439] = 4, /* faccessat2 */
-- 
2.26.2


