Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21826C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26B6214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj9+xCD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26B6214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qaB-0001Fh-4j
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUN-0002rU-3m
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUL-0002T7-AU
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUL-0002Ss-3X
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:53 -0400
Received: by mail-wm1-x341.google.com with SMTP id o184so11102080wme.3
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zuGhKIpIYrZ0cZDnAjpPq44Q1ATbBUKEKB1AIlgvvW4=;
 b=mj9+xCD3fvB2SOvhXklzxHHe97J+r8Fcee7YFnTHp6CiFDsH0QIJlC0iIV/rmsReRj
 oVe1azeaWxC+mMmotujE8FvGH+OcXudvd4TZXzXP+GhzoFSKG6o8eoDsx0EOdi2MDsDh
 zMNqQyGWbq6T7XKlpCknRSjmVucxDy79KjPXlWDOROm1ra+9jElcwaXjfRhf07bKseYm
 dU7pGQ6IlT+yaddavzTrZJGL64ycWaMeo6L3dhBzIw7RWZ/uhcBT5F8TFsfAjC2P5m6L
 T/XQIdzSCkpxMc9PPYh+SJ9xUBtM4kcOGVR71mhxr7amZ9OwST159krfsrBCb/nmoKL5
 FAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zuGhKIpIYrZ0cZDnAjpPq44Q1ATbBUKEKB1AIlgvvW4=;
 b=L3i6DgvDaRDKQi860dr4aNFYO/gBRjg+S0cAWUk1qxS1ha/SRFo9TyTZnUvDGlqTlJ
 CnWpW1bB897skzRXGAC+KE0WuIR3lnCYAOUFdaJMskH9o6kzUcdx8w0zZcD6eH8LXVml
 Km3nBKnBGzcbv6vJj7DPJ0u7dZYchsWNz5VS3Ox0LWN3TZX+6VXUESA9ItRrbb3HsaG/
 eRZ6lBHYjh10DGUsqc5Zj0LOaJA/maOzWfqZzUxfxd+SpNXjq0iWVX7Rg2KCnC5ZqLE1
 9gnMevriFsGdv+g9mY+JH9xuDVWZH77VLNcv9USzPH6M4ZbvMgRevwYLs55XTz8Hf0bL
 Z/2g==
X-Gm-Message-State: APjAAAWjO7QxqtnECeBOnzvwM8pvDdWmBeYtlyoK0G5PkQ0G6+QWBp1W
 HzOdp9NL/vi2xHPRHnyUVeA+cBdb
X-Google-Smtp-Source: APXvYqzUfuIjJIMvJ2fY+Mo6DrZUj4cHCCQO+ntYkHusW8aEMINLIKGPQ+XQebMLt5LjwCpSS2BKAQ==
X-Received: by 2002:a05:600c:2151:: with SMTP id
 v17mr14105555wml.69.1567923352040; 
 Sat, 07 Sep 2019 23:15:52 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:41 +0200
Message-Id: <20190908061543.25136-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
References: <20190908061543.25136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v6 6/8] linux-user/strace: Add print_sockfd()
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

Extract common print_sockfd() from various socket related syscalls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v6: use another ifdef TARGET_NR_socketcall
---
 linux-user/strace.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 77d7f6a97a..8a1df12e67 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1710,6 +1710,15 @@ print_socket(const struct syscallname *name,
 
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
 
@@ -1742,7 +1751,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
     get_user_ualx(addrlen, arg1, 2);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_sockaddr(addr, addrlen);
     gemu_log(")");
 }
@@ -1755,7 +1764,7 @@ static void do_print_listen(const char *name, abi_long arg1)
     get_user_ualx(backlog, arg1, 1);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_raw_param(TARGET_ABI_FMT_ld, backlog, 1);
     gemu_log(")");
 }
@@ -1790,7 +1799,7 @@ static void do_print_sendrecv(const char *name, abi_long arg1)
     get_user_ualx(flags, arg1, 3);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 1);
@@ -1809,7 +1818,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
     get_user_ualx(addrlen, arg1, 5);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 0);
@@ -1825,7 +1834,7 @@ static void do_print_shutdown(const char *name, abi_long arg1)
     get_user_ualx(how, arg1, 1);
 
     gemu_log("shutdown(");
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     switch (how) {
     case SHUT_RD:
         gemu_log("SHUT_RD");
@@ -1852,7 +1861,7 @@ static void do_print_msg(const char *name, abi_long arg1)
     get_user_ualx(flags, arg1, 2);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_pointer(msg, 0);
     print_flags(msg_flags, flags, 1);
     gemu_log(")");
@@ -1869,7 +1878,7 @@ static void do_print_sockopt(const char *name, abi_long arg1)
     get_user_ualx(optlen, arg1, 4);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     switch (level) {
     case SOL_TCP:
         gemu_log("SOL_TCP,");
-- 
2.20.1


