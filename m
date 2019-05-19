Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2C4C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D824B20644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njAw4p97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D824B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSb4-0004T9-32
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:39:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYs-0002mB-T6
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYr-0003Sw-RR
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:38 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYr-0003SL-Lt
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:37 -0400
Received: by mail-pf1-x441.google.com with SMTP id s11so6148107pfm.12
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WUYfVdZEVtBk9MHhOPPZhUCKLb9+xv1voeQk5PhUfpc=;
	b=njAw4p9772b+h3oN2yLFzA7FLillXnb1Lf8lnMJU7VLCfwlmHjFfRH6wFrzE35r7Of
	Eoc20tumRaLO5akv+ql0lZ4wfyFgYP1E8Uk78KAd27eOQBN4+4pUHNi7m7BW8Nxr6yh/
	VXu/svjD30BIoMBlbxEAAP+RM12LYDxTnXif+91CRueKAQEduLGggAm4xsTpzeqY2XeV
	kwH2hvrXXXr+erMPWjc9X/V4QwnB8owZ87llebOz3vxIGRJ9qydnaAR4VisuyC+lQEKH
	/Lw6hJAhuHJ6U2O9hkI+VqlBirXbyGEndi0jUiYRg1dhn1VpoimyrB50XrZfdZPKojZm
	MhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=WUYfVdZEVtBk9MHhOPPZhUCKLb9+xv1voeQk5PhUfpc=;
	b=uL7Xiwj+O/Zh9bmkfDdMduDrtGWdPMQCGPGn3CsKwGJF+qHsZGDib9eRiOaC1bpj0k
	XVf1NYSMWL7E+UUxexgNDUq7bB3KDGQLXAzMkFf9t69CKQ4uOTOjAznO+DIecj6lRDPu
	wBAg67b4HPq9RPl4ZkHZsXxag2zANQsMHqSAeMhKKskNCOU9H4IeBjiVytUlGHwNZ++R
	WyZZK65tkg9ysvv58P0PXqs5CnfLEyMJspzqBhqWKLLW4TPWxtoCQsmQeGcvgqjSRlnz
	ClyNfovA3b3Qm03mQlNiG7fvbTq/9LiEG73frIeDDVBFtHNV89nM50IaNsxREvLwsh+i
	6rbQ==
X-Gm-Message-State: APjAAAV1lT1jzBzUV5pdriC0SIYpw8IPBJNM70FH/xIcjMq5EwEAzgg+
	ZNpgGjRNxSU8QI6l7nf4ivpJpCkYPwI=
X-Google-Smtp-Source: APXvYqwUyhXyOfSeZTZ2cQP/xiwArBMAnLg9Fe/tN+hy6PHeSV+zS1wkBrV7oYg85it5+x5M+08VRw==
X-Received: by 2002:a63:1316:: with SMTP id i22mr71592462pgl.274.1558298256356;
	Sun, 19 May 2019 13:37:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:18 -0700
Message-Id: <20190519203726.20729-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 06/74] linux-user: Split out close
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     | 1 +
 linux-user/syscall-file.inc.c | 8 ++++++++
 linux-user/syscall.c          | 4 ----
 linux-user/strace.list        | 3 ---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index d1a6c6fa3c..797426ae6f 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -16,6 +16,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_open
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 4ef0be2c6f..d9b09c2cd2 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -16,6 +16,14 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_IMPL(close)
+{
+    int fd = arg1;
+
+    fd_trans_unregister(fd);
+    return get_errno(close(fd));
+}
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 53fb211f16..d2b1bb76c4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6827,10 +6827,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         return ret;
 #endif
-    case TARGET_NR_close:
-        fd_trans_unregister(arg1);
-        return get_errno(close(arg1));
-
     case TARGET_NR_brk:
         return do_brk(arg1);
 #ifdef TARGET_NR_fork
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 53cee3db92..43d3088669 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -97,9 +97,6 @@
 #ifdef TARGET_NR_clone
 { TARGET_NR_clone, "clone" , NULL, print_clone, NULL },
 #endif
-#ifdef TARGET_NR_close
-{ TARGET_NR_close, "close" , "%s(%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_connect
 { TARGET_NR_connect, "connect" , "%s(%d,%#x,%d)", NULL, NULL },
 #endif
-- 
2.17.1


