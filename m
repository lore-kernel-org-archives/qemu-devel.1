Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA3C4332F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67290214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4p+9Lm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67290214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qbJ-0002AK-LR
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUP-0002uL-0i
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUN-0002Uo-L0
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUN-0002U5-Br
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id q12so11125468wmj.4
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8mg012TbrBH7IitXy+GojEIbhI2BLUInMejCjfV2448=;
 b=s4p+9Lm3hwA6HUSfys6tJszvERkFrsdPkw2ttOEysl3xlZ3YYkSRid1l96IFwDnqM5
 3qCiCvTYhi7NGjuNcQpRDlB80b8cAMFDDfSPcVAVOdWggW0MhuAXmbAZrnpq8qPo4rHi
 d8mnR5cq4BrcQ3MdJfXH9KIWVXTUVf44AyIsnoiLH6X3gmAoUOI1PNPOhcMxmQ1wLc2C
 nOv5fs01OyjoQPtRikIEr0Yw/lHazrXQS18sgsk/UrxpKxLY2aF/euNm9OKbC4mS6UiF
 HilIdeimHGuO59zDngPQdwa+YwMpdGZ0VaORrWdeU2chcy7r7fTZ8Iz46SXaoJ8RLxiJ
 Bpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8mg012TbrBH7IitXy+GojEIbhI2BLUInMejCjfV2448=;
 b=GWMYrhOy198V3ggn0631x5oz0J7j2wj47Eu7YFmdbKhY46VLH0zFlA5riyyzydXVYQ
 WS/Bu3LCLP9Llci+BudWSNPg0v72ALzMLcaS4BGJ8n7JoNEgdX4JM5uN9rp8xwmo01Ai
 d2wRPoDJ6yfg/BfdpEsNMgMYnsl4/5mR9ZpXXdmPxE7mDOZEfuTQgpxD6nmRNuv34vs2
 AtWdoD7sqPKt8nECIvGhjneyrh1jId4cRgvtrTeE0HC2y8emRRQ+mC3goRvCllRXP2yq
 nKchE+XQSVSYFtygWDF7bH8yEsRN6JOQtJgNhORftdzZ7YFNvqZqEowx0xF96967OGA6
 CkVQ==
X-Gm-Message-State: APjAAAUEy6phm6Y0tObqkX9s1VCH1NcPm8vjIEriRNJ4UuS3A8SpGlrZ
 pCDy8+ezNud6nn3E9qwWDVRJlVsQ
X-Google-Smtp-Source: APXvYqwVtAb/Z53K4q8Qmcg5QAhgZJUyZcjiXKhccz1EfVr73ilcj2fKz4USZ1sJ5bUUwvhoG12djA==
X-Received: by 2002:a1c:7214:: with SMTP id n20mr12936695wmc.160.1567923354110; 
 Sat, 07 Sep 2019 23:15:54 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:43 +0200
Message-Id: <20190908061543.25136-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
References: <20190908061543.25136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v6 8/8] linux-user/strace: Let print_sockaddr()
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
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
index a1e971ac8a..a297f59efd 100644
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
@@ -1752,7 +1752,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
 
     gemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_sockaddr(addr, addrlen);
+    print_sockaddr(addr, addrlen, 0);
     gemu_log(")");
 }
 
@@ -1822,7 +1822,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 0);
-    print_sockaddr(addr, addrlen);
+    print_sockaddr(addr, addrlen, 0);
     gemu_log(")");
 }
 
-- 
2.20.1


