Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4D520640
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwEWUgt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4D520640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWKZ-00073w-Ut
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBb-0005VV-Kv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBX-0003BD-F9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBW-00039m-Hi
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id t16so8471319wrr.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2SbHTSN9heUjHZHZr60mvvzx0DMavYLdULN0Nc21EaA=;
 b=SwEWUgt4cjSVAgyd/Slb9Q/7XdBThBAZUJfMlFg3HtV+A3anxFf6y3+pWYdeUVNqZy
 aBrRq1WlgozbG0bNV2GBPedKUMR8PSW5JsZK0UWAmbV2I/0L7di4TrZjbh1gOFNGfCPZ
 hF1NQpXUgrMPQHFCzkZV0CWAVwAcktOkAwUGK7+FtPB7JKFnJtXcYGK0Z0+9yCYewdnr
 f5CT+geenw8mbXctqD8qIrwnJhxFTPGqT8lnZiZvtxLD8TsZa6amh2Exsn6ojtIgEunU
 XHuxc2C74593g3dTdxHJ7jq0hgDOFpr9S0fR8KEPwtsR2G2AXsiAYCOiv2BwqlhYUi17
 KwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2SbHTSN9heUjHZHZr60mvvzx0DMavYLdULN0Nc21EaA=;
 b=Xr/MerggoXjA33McDWveVxjCG3kKQ49DzBBdWAnU2PPxVF2ew5R5ky0DAbwGV/ptGE
 lOLdrQ5kiyhzkpFUx5skym4/RgsOOA3YkIa6X7lQE71ACUb1MS9vw0w0X8kmCSrEUUXc
 AGnpEIW67ZuSFR+F4RVmnbbFlJuZEUQEq3i0RTJ6UA8m577GVLqFLb0H9qxYsr5gve0i
 gBSrJy6g9zCA1f7cDs/gWSC9uC7IN2cAZF8UMNxs/71+BjcqhUUVhP/q+pBnsmuUIVwt
 VdZHskFa7LR9g4UNOqBXcoohHqdkDerwuK4vAGRN7WrcAoTz87T5JeSHadLYymD7F6MQ
 qp2g==
X-Gm-Message-State: APjAAAVNfFilxKjCFisZPexrdEo57dWV1E7BTeXG282uEJcQSxCajM71
 ZfDcja2U+jo3z8Rmm5a9hRTlH7Ai
X-Google-Smtp-Source: APXvYqxLrWSAVOP3pSpEsoOOzcX6QOi9oISCevAkDQPhs5fesW+Kc0O27HltHPdicW5rJGCfgogDpA==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr5069585wrt.78.1571658550029; 
 Mon, 21 Oct 2019 04:49:10 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 6/9] linux-user/strace: Add print_sockfd()
Date: Mon, 21 Oct 2019 13:48:54 +0200
Message-Id: <20191021114857.20538-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Extract common print_sockfd() from various socket related syscalls.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v6: use another ifdef TARGET_NR_socketcall
---
 linux-user/strace.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5fa7748427..0ce2b658a5 100644
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


