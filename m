Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA706C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A7020637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZakfkO5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A7020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCWFH-0004wG-P3
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCe-0006XF-Ow
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCd-0006xl-HY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:21:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCd-0006wv-9O; Thu, 12 Mar 2020 18:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584051679; x=1615587679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5LAi0O+mTaWDQDimiBocyA7wHcDy5fDRMj7L3Yuk5mg=;
 b=ZakfkO5X80PhknbeXRXXb1UNn38JLmyn7+p+/0cezpPn2qRkT+LyjhYi
 21Us5s7QnKy5E4cfxZJgXilUD+mZzjLTOQMvt68twI0GtM7bC4gSqsbgq
 FExtMrVPGbfogLa7ALxi9/bEu06TxJX0VHA7AwQUqorVhTJwn63s3Zn5z
 EYuALiLqZHvMxdwpaH1H0D+Ud0FRRGGFYfAEzyCgm63X7bL0FPQz8Hzex
 USJu/tnPHeXPsiIZOng9dUJNtnL/qAVBe9hDUcyzMOTtJkDkzLhEH0mfH
 IPAV3VdGQopS4Bwc1FRumh4rw0gEhD4AV0Mz4cRElod0pWxhADmoNsSf2 Q==;
IronPort-SDR: H8yzzcsIrc82r1hKc/Htk/XYYECa4uBwGna4QwMzDvb8QJ844M1lWlj7piULuz0eZw/bXPmILL
 895nqevogKAe9SOvVnwK4mW7TAQaWJsQlT+T7z7yqE8DIYvxvTGToWNPAgFeO0SjaZ4GYepFNt
 qQ2l+XYwlr2PB7MLxrSqkPn0RogguY3RRnlcDMEYxHfzArEuK7pSmM/hgjTcnhGNJlH0V2MmBo
 1Tk00jqaRGcsDxoTwrYtEzHvQ6br38j06MkIfVZVjsDIKAWkzcpr4AJxsPYR/kJSVXXhpunaHB
 yew=
X-IronPort-AV: E=Sophos;i="5.70,546,1574092800"; d="scan'208";a="132788033"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2020 06:21:18 +0800
IronPort-SDR: 0IFkWC1tlMGGpfb9T++h4RXmzeT++3paYwqx6jTTV+Dxq/bvs0WQwzRIznEZ6cvlWK+8B8jLZ4
 JTAnbPENSTFNKxVLnp0k9u+6AqErqMcHivvIZ1VYY7ExOrh1FR8zSa5ssAa/CDnXi4p9kog04x
 MIE52adXkA9jD39D9YbW+oYCutqA7S9uM1t/5OOPsh9U6Y1MYUqg/HV9/bOtZ7qsgAJ9xQdWyq
 1Shp3C3aOItaYWzUt10i7UGlILS0jPee6Jkvz8yIvEET43F7/KZkpJW7qTpM9Mwi1OkXw65YX9
 nLLr+BPC2tf5UFk3WBmS7xa6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 15:12:54 -0700
IronPort-SDR: JK7R22lJTYQO+0klgOm1ensyYBy3Bj9B1hpLssB0XSuWy6/Uoi9+6/VQqqGXplnr4LkVMYWkNB
 HV082rgzOyYukcQRZLc7aOZU+eQHyhIap0jdkRW1CWbzBl7sB9qXuIf2mp7X6sijfK16j+0x7L
 TBESd929J+Sgy1Ar4Rqr1j1PVugkJR4vr6bJtv0rD0tGjRyoOwRYd+dtiz36FWdFBm45KHesH0
 XEIDm+3yBMD3BanwURdPQ5RCEPqC+7Guoyw0nt0+PcTf7B9Jmfpf4J5lilM1/F9GCoMTVzO/fU
 rWU=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Mar 2020 15:21:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Subject: [PATCH v7 2/4] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Date: Thu, 12 Mar 2020 15:13:53 -0700
Message-Id: <4a7fd05532400d10aa0f684c9043e2ac7b34d91c.1584051142.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584051142.git.alistair.francis@wdc.com>
References: <cover.1584051142.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 909bec94a5..60fd775d9c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1229,6 +1229,22 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
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
@@ -11458,6 +11474,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11469,6 +11497,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


