Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4248C2BA1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FACA20692
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMGMcaQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FACA20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9cKL-0000mJ-R7
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF9-00041l-RL
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF8-0002Ao-PC
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF8-0002Ad-Jm
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so1507864wrt.2
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U069PKGTirvYtK7TC62rtzJztVF96Z4Bj7Sfc1rCm1s=;
 b=HMGMcaQil56mIC8vhtPhZXl1+okQ2lwYPSBywqdJJJVFIRYE9wGEgNjws2cNhnnqeN
 tscihB8C7r66CriZ8odqWEEbzq0iSS9sEWuePlUYmWXNipqqwkSXEEjlbrEuGABmnLRV
 B8VyjkIqYZ0rkYmOQ0MY04YEbGjElwV6faOD3jxMmekGZ/pun4BQglcWhG0hhpPBlykg
 Gp2f0Tdt5zL+GMiJtxWrFMs13eOF+RYkiy5V3Gg4CtRRLq+glTLhQsMYSmoViIn3YggF
 toVTYoo1iD7aC+NsfORUDrWoiTjTtZL81odm3Mv3/hCfPJp56PCr1P4IWFgqOwqoIWx1
 lygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U069PKGTirvYtK7TC62rtzJztVF96Z4Bj7Sfc1rCm1s=;
 b=OpvnmnRfVtrOMn0cqeioemRDVrtUohNVEq4IuZOHjEFQ/VLXBZjv8ARG5JLZrvBMfZ
 zj/BeIEf0KJZ5aKqsU/xTpHvdEi2t644jJQULpGzaIm+fUwc412ThDFkU/eF7mfph0iC
 VYpUQ0yCGGLgWn63CXZiVj72hw4CLRpwqoD7bJJXWMLaVLkTjUby00HLdG89wkBgZP9v
 cUk8mGYIX5EK52RDpz0V9bYspGV0UeTcNfBqElzyu9tJ43PCPRLiwRvhutlB8FIE3zGx
 hNUB6ZH4s1S6XciG7ezoIEN81Lvl3OQoczED7GFPQCnBBd0ws8+PEr6hL7soJnTgwyz7
 XIMQ==
X-Gm-Message-State: APjAAAU6xwLOC+HhGScQy/5RL/wNpgVApeDccFnFm71C7LsS5mmw4Sxk
 knX/MO90lwna6yrvRASqO6EZQrty
X-Google-Smtp-Source: APXvYqxBfLqFlKQ+IyYqSHYbBzFtMj5ymbrtB3YzVD+YW9F5IY/QZnEEihktbx1/eI/NwEGezONXLg==
X-Received: by 2002:adf:a415:: with SMTP id d21mr51453213wra.94.1568583577474; 
 Sun, 15 Sep 2019 14:39:37 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z1sm68738999wre.40.2019.09.15.14.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:39:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:39:23 +0200
Message-Id: <20190915213924.22223-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915213924.22223-1-f4bug@amsat.org>
References: <20190915213924.22223-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v7 8/9] linux-user/strace: Let print_sockaddr()
 have a 'last' argument
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

If the format is not the syscall last argument, a comma is append.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
checkpatch error:
ERROR: storage class should be at the beginning of the declaration
---
 linux-user/strace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6e82f6197a..3ccefb9839 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -67,7 +67,7 @@ UNUSED static void print_timeval(abi_ulong, int);
 UNUSED static void print_timezone(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
-UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen);
+UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen, int);
 UNUSED static void print_socket_domain(int domain);
 UNUSED static void print_socket_type(int type);
 UNUSED static void print_socket_protocol(int domain, int type, int protocol);
@@ -336,7 +336,7 @@ static void print_siginfo(const target_siginfo_t *tinfo)
 }
 
 static void
-print_sockaddr(abi_ulong addr, abi_long addrlen)
+print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
 {
     struct target_sockaddr *sa;
     int i;
@@ -418,7 +418,7 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
     } else {
         print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
     }
-    gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
+    gemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
 
 static void
@@ -1751,7 +1751,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
 
     gemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_sockaddr(addr, addrlen);
+    print_sockaddr(addr, addrlen, 0);
     gemu_log(")");
 }
 
@@ -1821,7 +1821,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 0);
-    print_sockaddr(addr, addrlen);
+    print_sockaddr(addr, addrlen, 0);
     gemu_log(")");
 }
 
-- 
2.20.1


