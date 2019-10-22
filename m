Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E40BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4781F20684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4781F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpST-0000qs-6R
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGT-00034C-Iu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGO-0005AN-Ji
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37835)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGO-00059V-A3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:32 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M4aEC-1iLBMe31jq-001fWm; Tue, 22 Oct 2019 10:11:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] linux-user/strace: Improve settimeofday()
Date: Tue, 22 Oct 2019 10:10:58 +0200
Message-Id: <20191022081104.11814-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NsWC2Xt4bpl0q1ey+XXa/QhosycTjZyo5vAKPhfl8h2CIrRvDpC
 imrRTCLQwdE69H8QDoXA5fTGhJsIZYZ5sjVxOmWARjvSJ+RRdlOzvKRpShOR5AQROAzSS4T
 H299Y5/5gn+txrxFPT6KZzkc77h84E6pchKbq89dy+9B1+RYesTbb0TF5QbfZ4s/hH/OV2v
 ROgB/rpVKIFJ5rDeLyzow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R9kOsov3XtI=:T65UAa9OtCm+puzDh6PPgx
 v5gmLQLbh/3q1vM6Bn6eUroHMtSOo/meGAY1BINSgyYGuA8W3jJKVBqomVjAO5S2ooC55craO
 MLNyYr5GgNLQrVIQDSAYVLn3XWO/fGFxAjTx6WY697QvXRULH1aK2QRPgkE7Nvjn6EjfcCYTv
 nWpD7fNTEa5/zYI46nksDc3WJqHHsMZJyD3M146ZeMaV3pnOZRESbCnZMFHWcvkSqKskIFcOq
 dnQb7esPnnfcnOUjPwYkh1IkGH6SvnrKS8f2Bl0wxGOomhoTYukA395agMsAyBkdMQtZXrby4
 W88t3tTJhWIbqfvhcazxkCwRQBqfFdKwq0EoIKxQoiX2EY2lFIhFT7TB07Pmi4tiAYrHQMIEi
 eUc3SgZs7nzu/wwwhFZFRHedHE54oGyu2VjhN9wQg/GJ1RDXIgHHLC2nu20n80HBNLRcObqnp
 MfUsdNxr76QBkmwF06i5I6vqCvF4VQW8AajNMmsRE8Xconok/oNQcpxrtJ0kdsdnsy0dVkVD8
 IBiYNjqrYCrA8UU9hX5r8twzZPwFArysG9fZe8WRFS6YmsGwFmOoC55dwJjTG8uGq/apmdnDp
 zuGRq9x09Vli6Nu7W/AYthtJbD+dbDwx0R8WMjEqpRrWiU/LrswPZDe9oXEbsWeYC+hWUVwGt
 jKFO9kqv++BrzMDeB1zdgJrqBL6P4021qGPJnfXrRQcGXWDhJ1iaSwwf5SQr7E8Py2OTWkDCn
 fHxbtjjfOhpFoztvMsIre9mHGmIQp0hLs12b6VxiSEZ1iSkRmVpjk22mRqppr3mSB2m4WyfJf
 pw24pxFzt0bx70TMPLSFBf0S6AUj/jVVQMHbMW+B8CuO+1ScjpkkZkFdPBUwGRUVs1GK+53o3
 lDYA3hpMW+9rb8FqTAIsvRw9O11iTGhRwfo2AatjI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191021114857.20538-4-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 13 +++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 2cd6687cd99b..fd5596a64074 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1583,6 +1583,19 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_settimeofday
+static void
+print_settimeofday(const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_timeval(arg0, 0);
+    print_timezone(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_link
 static void
 print_link(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 863283418ef9..6f95466dc59d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1348,7 +1348,7 @@
 { TARGET_NR_set_tid_address, "set_tid_address" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_settimeofday
-{ TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
+{ TARGET_NR_settimeofday, "settimeofday" , NULL, print_settimeofday, NULL },
 #endif
 #ifdef TARGET_NR_setuid
 { TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
-- 
2.21.0


