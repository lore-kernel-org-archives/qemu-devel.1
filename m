Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA079C10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BEC2067C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vn2hh65d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BEC2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAHmm-0000k5-Qt
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 13:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlX-0008EM-22
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlV-0003Tu-Nj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:32:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAHlV-0003Q8-Eq; Fri, 06 Mar 2020 13:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583519532; x=1615055532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Bhx9QdhIgpC1T3sfDyOZNyN2dm4mKGOjTxObaOqx5U=;
 b=Vn2hh65d5QOuf2C6onEEgk6bDkbrLw0mWgmWTnQV3sVGAB3nlTTSprqQ
 uyWoOt26lZBeV8hAwi3PQBvq2hunlYT2qCax+aBddg8NUE0wKDX8vWDFP
 QhgTn5qgfqEkSSvQlUrw++Ea/AYwEnSp3K3GVzcjKkVH09TLLkKvt63Lf
 MuC3BQ69xzrB2pW7XeB5PY0abMXoM6vhr6xi7OzPj2qdBfmTync9r9ZIV
 wTw/Ymi11YiWFKmiii2LnwlYUtsaFi9bDdzkStPMPxl9k346wPgoLLG2B
 p0PxehJd6v8MpJytnExuUQoPZadycOArNygzGlNbL2wKVunDb+GqZg2IN g==;
IronPort-SDR: 1zF5nKzLnSjkJPBi5MHy8VZNJi7c5yJ3H6NRfvRxvrIzRGiH+yNeG+tx12Olq5z++FkFZvTDgw
 qk+WYxnbCD5y8FU1go5JoqAkqCnHZBk1zCXTRC9CtMke4I5/KC+Ui5beyVc6wvpH//dyh4jPzZ
 sVs9MhOloHAhbOMpwwHTPajwJMXvFaT2JiuN6MSpLabzmodXI+GXioYRV8wjbnpI4kVlBMEJvO
 onF/edjPxE9dYt3hoGYF7jC7+eIZuilCyAEZnY2QgCOWOu2ocMX7j+aBg1dcYv3YaavMnTzskh
 PzY=
X-IronPort-AV: E=Sophos;i="5.70,523,1574092800"; d="scan'208";a="233755496"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2020 02:31:46 +0800
IronPort-SDR: WtUEOaHRqP8RsT5MFW/FtD68KETkPZ8NGeGIlkUtjVlaSXKv50Ck7WmjwYn8CBmT2TPg9mRvSq
 YBxFqWtbVaKx70SdGXyIqlE8uGyZgiC59Db3rSlb+IZY9x8mwFTHkJfqQx/BCkKv5Ff7BqUwRe
 XE1FC2SJoFju32q7SsJdyzCIY3ODICakhJlXXtwRlwVxEc2M8zilOVHL4zniiqWo1lJJJ6iThK
 oB4091kl7VA53zSPU3RImPo9MlfLiHn1YDSFJ/bZge0PhaYM/ap+mndThowKUV/5eQ9yL4dpmM
 aWyh3oZbMWBbWcny0J/x3FZE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 10:23:53 -0800
IronPort-SDR: +kA2M0/fxCDWIjD5hwKnf+SQ/ANpCpwoveJ03vUyo5wjtTAUN7tVWnoRqZnJEKMEtsLsg0vzwx
 H6zWE0dHPQqzc9swUgdND7OCRTRKntx9h0jjtkChC72CsP4p6Iv6ssYXXlfBCep1ESbveI/CLj
 /SIvAIbMJ5yg2kWLzBFUgVd/Q+SDuKrevy/0DAjGxJwkma8Pxd7bo2P3+/IG3UtWZKrtO79m+F
 H67EVA7K+k65qSnMii/DOS62v7upnnIv3vFx+RdVmhRrff0YOQKPBMPjLOHiq3GiiOSQpLQxRD
 ctc=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Mar 2020 10:31:43 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com,
 laurent@vivier.eu
Subject: [PATCH v6 2/4] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Date: Fri,  6 Mar 2020 10:24:25 -0800
Message-Id: <5fa31f8938fb16e6d07d3ec10e6ddb7a4e274f79.1583518447.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583518447.git.alistair.francis@wdc.com>
References: <cover.1583518447.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1a7df23440..0f219b26c1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1231,6 +1231,22 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
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
@@ -11460,6 +11476,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11471,6 +11499,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


