Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C06C47E49
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E99820684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E99820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpQh-0006SM-9P
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGH-0002iq-1h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGF-00054e-Oi
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57585)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGF-00053l-FW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:23 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MvJjz-1i5Qpl17qL-00rIdv; Tue, 22 Oct 2019 10:11:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] linux-user/strace: Add print_sockfd()
Date: Tue, 22 Oct 2019 10:11:01 +0200
Message-Id: <20191022081104.11814-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aIxCoJcwnpaYf33vOCZNVpNcU8+ktlueahCgsyBYALPNleEqRrq
 VLY8HeEUPQB1HZedvhpjwOGSBs/iRUcK9nOkfde4xYS8ftkFw3zUKXlAC84D+javr+vQyDL
 h8FhltB1jvpLeQp/BOGc0tZnCe3Z77Zm+4nZc0a1Tm+VUfgGWBJoXBNfS7VJz55661LwC6k
 RdQott0w5Hi3ZfjrIGmpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7BAujVHsBMs=:KdfPWzQrTCNgCcHSq0ttXM
 4h3JrV17J6ulNAXMB9juvApYC5pKKi3hu3fIRlch+CKB4QX3O5JelS2C95/Gc//NRqtWSnDDy
 n8vfkQbAxRVFZdDot/G3dUHrql4vpzgcnwMsWEGW+IlYjqsYEi726cyK6C2mklCyR2skCxK07
 jDlIfg46fPsAaqP8NsHBVzCLfOx+Yfy6tEK9b3uQ2ImgtdC7ZodNpcc95cbLZz0OLvnZ68Sj/
 IGX0X/b429g2Du8k9y6c7LlOl2arzYT3Auk8ZWMKfew5eC3N+VEaYcwDrY/CKXCJnZ5wxOMDI
 vpUYfWKVnWZ3HBc+qgYxsE5pQoECRnNLtHEFYBKr0JIFIM7Iq5fa/kgczGJskmjqsn9TR9tzk
 NmA+fWvs0Lb8pJ4CEkAUi0H2J/aHESLI9QR69QxlbF3hm0agbOvBZk5/YOMMxh5iOoWJCIlf9
 XRFmH3yiaRL44JjiUu/S6IEgGJ9PPFMBKJmtGSEM3jyOY6ZXlZpehpM+rLl8AK/kOMQyu9I09
 t3HXgmk2U+oI9TFeslPtQm0UGbRmMUkXYiRuIV/g/p9PzVRwxaMjUAcjwDT9L8h5C3062QgrQ
 OeV4CA/P4tbtB+uo7I+YsT49v6xSzDdef6/rF/X91pSAD1fQ3Iua+sO45HIlC7Gx7jkWGCz2L
 qGOMltlu6MopFVJ0urPN7e94YG3759Nc9Nef9+QF44fEABOiOTs5tWkAAxKN4DdHGAC9x8Pxl
 ABTmtNcSYxZ1AOsJg/sBsJQ4LD1MdesBAiKmrGzaguT83eRbCFqPLFJaFPzIGzpp2pMRrmC0S
 ZHrX4yx0g8i2C/9ajQFL4a04d5WYOqRQlvU69uHzM5wPZQr1yWYQlteI8I1aF+LRUJDwRdNod
 N8c6sY9vXsRKraZwCXDHZYGooxWBzCxugQrAoq5P8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Extract common print_sockfd() from various socket related syscalls.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20191021114857.20538-7-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5fa7748427f0..0ce2b658a52d 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1709,6 +1709,15 @@ print_socket(const struct syscallname *name,
 
 #if defined(TARGET_NR_socketcall)
 
+static void print_sockfd(abi_long sockfd, int last)
+{
+    print_raw_param(TARGET_ABI_FMT_ld, sockfd, last);
+}
+
+#endif
+
+#if defined(TARGET_NR_socketcall)
+
 #define get_user_ualx(x, gaddr, idx) \
         get_user_ual(x, (gaddr) + (idx) * sizeof(abi_long))
 
@@ -1741,7 +1750,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
     get_user_ualx(addrlen, arg1, 2);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_sockaddr(addr, addrlen);
     gemu_log(")");
 }
@@ -1754,7 +1763,7 @@ static void do_print_listen(const char *name, abi_long arg1)
     get_user_ualx(backlog, arg1, 1);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_raw_param(TARGET_ABI_FMT_ld, backlog, 1);
     gemu_log(")");
 }
@@ -1789,7 +1798,7 @@ static void do_print_sendrecv(const char *name, abi_long arg1)
     get_user_ualx(flags, arg1, 3);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 1);
@@ -1808,7 +1817,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
     get_user_ualx(addrlen, arg1, 5);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 0);
@@ -1824,7 +1833,7 @@ static void do_print_shutdown(const char *name, abi_long arg1)
     get_user_ualx(how, arg1, 1);
 
     gemu_log("shutdown(");
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     switch (how) {
     case SHUT_RD:
         gemu_log("SHUT_RD");
@@ -1851,7 +1860,7 @@ static void do_print_msg(const char *name, abi_long arg1)
     get_user_ualx(flags, arg1, 2);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_pointer(msg, 0);
     print_flags(msg_flags, flags, 1);
     gemu_log(")");
@@ -1868,7 +1877,7 @@ static void do_print_sockopt(const char *name, abi_long arg1)
     get_user_ualx(optlen, arg1, 4);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     switch (level) {
     case SOL_TCP:
         gemu_log("SOL_TCP,");
-- 
2.21.0


