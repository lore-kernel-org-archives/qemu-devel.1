Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0626ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D6F21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D6F21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpQh-0006UU-P0
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGS-00032V-E2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGR-0005DD-Bv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGR-0005By-1q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:35 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYe6H-1iZlhj3Ksd-00VjY1; Tue, 22 Oct 2019 10:11:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] linux-user/strace: Improve bind() output
Date: Tue, 22 Oct 2019 10:11:02 +0200
Message-Id: <20191022081104.11814-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Xdd+r7GY/qZzaOF66zQ1MYlqJ3Y0zOwwi/ejhmnpZZtv+BToISa
 DS3E7xWtMLVHYM2wSWF0EXK+yxqAAVRV44JX1aV3QFCPfC1DHFsFbYxcz+bLTBPJqNU5eSa
 ntsBZ0JipY3pTVh7sgl6RBZV25mLT4vm5ftWsv9uipnvdwFGlzbj3iW32FcDWOlJyr6xlmC
 gitvG+q9kmngxt/J5wcxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fHu1Xq0zEe8=:+g8Or0jkTRy8yLVlsA23/r
 2AwvEQrf/zP9uXV6cQOgKuJ21WFr5C4UuqYRBdRkMaXJxtuX6tjXnBoZSihSCGcmyCd6jXDYm
 WNR/hHMr6BB0h55saEANbyFLqumzTIMzc9KVAQ4RdSN1IdSAEwFqCJNSUbkJTPopWvmU++ezZ
 cUzygfiHmnK4gtwdCieP0l4943RkE0xEeU+E75zRLuhKrVOiBwB33Uqms1Dxm7/cyfcffZ2nE
 FFf7phTh0lbzSUzzVnWBpJcEPRW7LmN8rLGT4kwOo/B6JVxmJP53zqFptfVkPJGS1z3bubm+n
 8JgK4s4QwqA5H4Az4XnCSAmVoSuqZEQXbSyJ3MPu8UnfZgpsqnqRgGD16CSlnbsEIKLXFRtGn
 k20S6lWejWf4WWMn37MYgYfM4Cboy0BYVdVNtCTIKpmOe49KBQD8wfjYZ+GjbqJkM+/CejRYY
 iHYObgpFJJPbKul//cBOclfxaGrSFHAhptkzav3Yq83LCp/G62HJKKcLnJxY3z4OiYQnTEEmE
 r+yxDljjLez8D2MUEjVZkZPDSPfap9xH1wVrF3YUqZyp8ZLndBcDdlSUkUIHW6toufa7Xys0J
 DVLlf2rcQWt1mRGtRDe/ayna3lAlQJdkZ/i8Uuv2YokALovXWzFreXfbjMPf2z6u0ftpYPKG+
 YaOVHTJBd+OABtLktJf69G+VMTLOFqfF2XqFTfZtVcv+gGajgsZA4848goMRPpZP+dDiIodQ0
 1LAtN+XYMWfUEUdII6U88J71I/+/TVL1oUyvQTsLAZ4TevjLWEDj9gYIacOU8ecFiNWp0H4c+
 4EgoCXZFJoTciD+sGs49sjgC6vyHd+dXr7CKcQIumuaJqKulSV1Ppd9tE5cKqd1EIBm+X8Pvm
 XM8PO/vGks9HFD1/2wDtYrPZiHYLUhQ9bta6a/4Gw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20191021114857.20538-8-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 15 ++++++++++++++-
 linux-user/strace.list |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0ce2b658a52d..cd92c77d3366 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1707,7 +1707,7 @@ print_socket(const struct syscallname *name,
 
 #endif
 
-#if defined(TARGET_NR_socketcall)
+#if defined(TARGET_NR_socketcall) || defined(TARGET_NR_bind)
 
 static void print_sockfd(abi_long sockfd, int last)
 {
@@ -2054,6 +2054,19 @@ print_socketcall(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_bind)
+static void
+print_bind(const struct syscallname *name,
+           abi_long arg0, abi_long arg1, abi_long arg2,
+           abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_sockaddr(arg1, arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
     defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
 static void
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 6f95466dc59d..1de4319dcf87 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -41,7 +41,7 @@
 { TARGET_NR_bdflush, "bdflush" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_bind
-{ TARGET_NR_bind, "bind" , NULL, NULL, NULL },
+{ TARGET_NR_bind, "bind" , NULL, print_bind, NULL },
 #endif
 #ifdef TARGET_NR_bpf
 { TARGET_NR_bpf, "bpf" , NULL, NULL, NULL },
-- 
2.21.0


