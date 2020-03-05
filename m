Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43BC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4C42072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZOiKJyae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4C42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wcd-0003qw-41
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbS-0002Sb-B7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbQ-00085a-Lz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:56:17 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbQ-00084P-E9; Thu, 05 Mar 2020 14:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583438176; x=1614974176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7w/jukcGi+PETt2xAivSJOJ1m1Zi3H5c75jF3dKfpn8=;
 b=ZOiKJyaeXBlaxidFYOFEiIowdPTbqE2jjBhu7rh/gRT+Ig580akfZ/N+
 DTcP/jxSQGCJ2+dNw5QCZomW+vvgbg/oIbHtDReD9loB6wl+21oF7pWNo
 M2v7igm5TKTGxzpyIjcjxYpj2wNSlXKAxKJW0/9L3R5gKSn0cKYvgfjJh
 BYSHj0nAgpKTvoTMh6kJfO3BATiCK2yCeCWrExtx9HtySbQgs1IgZQn3s
 b6KVT3rId9XdsM+i3I/OaEmVy7krjJxtB3V2XXYlg/hSce/0rOQXppTY1
 8DYHIi4ZpAzm60lUmT8tY4XHYXar19GdNqoMeoZgEMrS/0sChLhnhvKy3 w==;
IronPort-SDR: NVY+b1+tzpVFSryBAJczenFtBYT6jFd4Db1kxXfCzs4JVyyhclySN0mm/N2xBqu4eZJo7YbjdD
 A0pOWX+R0/8MVURMMbUKmnedHTkv6UNCzd7W2nZu5EDw2bsfGRdvPNZmca1FsIX951qM60Zzam
 qXUrqK6RJDXLYAn1OePwqgj8otfjk56RARla4+kBJqxkahG3R/MGDZouMDpVFFVKsWYbhtjMcV
 noHZLetGJXJViSkWuUJCWUDivl0c4sLMQgIs+S4knQlFmH/uhoNlCzhiPZ7CPKUn1DauM633rp
 T1k=
X-IronPort-AV: E=Sophos;i="5.70,519,1574092800"; d="scan'208";a="132119761"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2020 03:56:15 +0800
IronPort-SDR: PAG+tLyXiyObt8Q/yX0+96sWqTxD1w32EGhZE/sUeKPxjzAYswssY28BYRgFlhJH/3+pivVUh3
 aFEaDlI16KiKjFvnV4QnJpKsMO6Yb++bunDVIv56Nwbe+rO9ny2mN5o3K1h2gJvHM8TSOHIVvj
 VYdPQfd6+MlS7pK0+NJm0e3gVUXeF2TEHRyzBzWvzt2gsdCspH9DzIAxbTBe1rAvaEbwGl75ED
 3aUhs6M+Nermz440/zr9iF00qVjP7RFY4N1KWz2D6Xh/EbESzZNucqvA0nHETzClK+KNBsYNFq
 op8OhoU5h4PihUBOldEvxJrA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 11:48:27 -0800
IronPort-SDR: YPKPtPbhS6opipBj2Tgv+1P9qj99TQ5kKabYBMK3noIBtzSrPoHO9Fe99beCwYXVTp7i9rCKNu
 eP46csrzsIdVeblGZqnMQ06u9CDMBl37tBoew43l+SK6WugkUqH33bPk7IUzJGf4/nkgWGyZT3
 AM1AVh71uz+a8NMGO5NP4lN11y2J89fd5p3nyehIN+bIOsi7TvIJ4ih86lJzBcCUcTpoCYGHLX
 zNdK7Vs34cIxmQC8ke0SXCJhAhQoQ7IJT6wQPoxUtmGmGGf1WXM+YBmMG0m62WyyiC61FJe1R7
 szM=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 05 Mar 2020 11:56:15 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com,
 laurent@vivier.eu
Subject: [PATCH v5 2/3] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Date: Thu,  5 Mar 2020 11:48:59 -0800
Message-Id: <07e94b85b8afbfe391a0ab93857f99288600da84.1583437651.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583437651.git.alistair.francis@wdc.com>
References: <cover.1583437651.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for the clock_gettime64/clock_settime64 syscalls.

If your host is 64-bit or is 32-bit with the *_time64 syscall then the
timespec will correctly be a 64-bit time_t. Otherwise the host will
return a 32-bit time_t which will be rounded to 64-bits. This will be
incorrect after y2038.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c000fb07c5..55eacadd19 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1236,6 +1236,22 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
+#if defined(TARGET_NR_clock_settime64)
+static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
+                                                 abi_ulong target_addr)
+{
+    struct target__kernel_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
+    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_addr, 0);
+    return 0;
+}
+#endif
+
 static inline abi_long host_to_target_timespec(abi_ulong target_addr,
                                                struct timespec *host_ts)
 {
@@ -11465,6 +11481,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_settime64
+    case TARGET_NR_clock_settime64:
+    {
+        struct timespec ts;
+
+        ret = target_to_host_timespec64(&ts, arg2);
+        if (!is_error(ret)) {
+            ret = get_errno(clock_settime(arg1, &ts));
+        }
+        return ret;
+    }
+#endif
 #ifdef TARGET_NR_clock_gettime
     case TARGET_NR_clock_gettime:
     {
@@ -11476,6 +11504,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_gettime64
+    case TARGET_NR_clock_gettime64:
+    {
+        struct timespec ts;
+        ret = get_errno(clock_gettime(arg1, &ts));
+        if (!is_error(ret)) {
+            ret = host_to_target_timespec64(arg2, &ts);
+        }
+        return ret;
+    }
+#endif
 #ifdef TARGET_NR_clock_getres
     case TARGET_NR_clock_getres:
     {
-- 
2.25.1


