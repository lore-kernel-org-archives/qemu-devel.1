Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135DFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2242206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXlnwYB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2242206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWEX-00006z-Gk
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBb-0005VR-Kh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBZ-0003Bv-F6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBY-0003Ac-Fk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id t16so8471560wrr.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DHS2SKkFIjzeTftKW046CihOKHK4sJ21ouhmUQVVWVk=;
 b=WXlnwYB5TO5sc5oj7MWKLEmf9dMi9e/Pa+hDs/EOgCXlfMCJtLrMO4R0gexqV+E6Vu
 xir/fHW6ERSIja+E6Kh0bHQz4UBS4JY5k5T15OCqP5+ok7LiRFR2wccUoDP5mLQyRjJW
 vao5mjh29l0aE2aAf8kmQGKpXISGvu2knqcuBIjRpQZVS2tyI+fRxJ701BVsi1pmgojh
 TOiYE0lj2B0jBLMuFFGmEO6PZQ8Eba5QLbl+qBo3uyC6/DEH+2EI+HC3fsha999rF4lU
 LWlz6++gNnbxPHI5MBzoF4zSOObkrD8Avk05TsyVmkj2yRBb8DhHGqLwM647/O8WkugU
 QIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DHS2SKkFIjzeTftKW046CihOKHK4sJ21ouhmUQVVWVk=;
 b=jMhY05pRW4z4l/rTGgCVDEdZXLSL0KphyWBwTqix+9jlU5CvFF1fqGhv94V+a/S4M9
 lRH15QgZ3A3+Um069XdYWri1dkSfcUf7pl15qUdpnM3leT+roRhQCUveeDtga+0+Y4lV
 ZS/RpDD4DZybCY0j6P1/1+ov+SjP9boM6nLf2Lt7D5SKhx1OFBRJKRqeD16gNLF/q8G9
 rQxvA+A6CKvKT7CUy3HNSlkfx5cHswV2PJRa5qegg4WoukTUBfxWfoIPw1dLG75B/Fds
 2aROyZzx/jTMAptS72ReehUKgr0EaIvjwJx/VWgogp8dKerrbuj6O1jYUj3Tj/ieKP0V
 dhSw==
X-Gm-Message-State: APjAAAUQZs4OhCQvhW5keA39tub9nHSDq6V08JoV8FYCpcFhjR5Ua4+a
 so67w0+K1+meLZscOTJqkKbMUBri
X-Google-Smtp-Source: APXvYqx6rfoIDlDSRqAjNEeojfpztr0NuoFOjQd8tKdCWqpu0bAHuh7pslWOtAD1XhCk+s5lT4xltQ==
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr2932131wrs.357.1571658553659; 
 Mon, 21 Oct 2019 04:49:13 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 8/9] linux-user/strace: Let print_sockaddr() have a 'last'
 argument
Date: Mon, 21 Oct 2019 13:48:56 +0200
Message-Id: <20191021114857.20538-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
v8: do not name prototype arguments

checkpatch error:
 ERROR: storage class should be at the beginning of the declaration
 #10: FILE: linux-user/strace.c:70:
 +UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
---
 linux-user/strace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index cd92c77d33..3d4d684450 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -67,7 +67,7 @@ UNUSED static void print_timeval(abi_ulong, int);
 UNUSED static void print_timezone(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
-UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen);
+UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
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
2.21.0


