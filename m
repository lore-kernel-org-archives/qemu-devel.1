Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3478C3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F59B20675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lkVN6WlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F59B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9IIh-0004su-MY
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 19:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IGf-0002Ps-My
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IGe-0003vn-Jr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:52:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IGe-0003uO-Bn; Tue, 03 Mar 2020 19:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583283128; x=1614819128;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ev7QuWPvB2uWjQGNiISx6hjAH/5HFRBbPQkiNM5KelA=;
 b=lkVN6WlPQgZwG4cNSYiHzmtLtoA3YCt7+reYDK+nSq2/KJTIh8hZeVHN
 lTwkBT7KX+San4BAFnjenGlfdVa5k4lcf7RrveoeIiplGfGqpWCWb0RTm
 O5H3OlNqT7+v/kbjfBPfOMBVsyMi4iA7SFsjJ+4QhUjz1RSHFqLOA1YBK
 wVzlyFzpgQYheSs5n7zechz+X37LzuG4XNmDBHDWILxqDiEiKSWs23ykM
 3UOFcotks7GjF/knbD3wTJACHv1u2pvmX+Jx8AQIyFzOzAeCFZuszBkYx
 axgnAn49U3FnJ3Nay8+HC+/bsCYPz+Ui7YNEUKYInObgYd5s0tz/ruseK A==;
IronPort-SDR: uN54aoKjUrC+vaQPCgfvF40RsrFAwxMMBqrQxjsz/2SU24V04NO8lL19Q+CV1jpAmPfqZIhj/I
 +BZjTSZqGkIaM3CsFwQRfjGKCMOPS3k6FjA5xGwjCNxJvL5G0atJkDE9D3NRKaJjSyjuMysszo
 iclwlutXOsK/Ij/DMTsOz4mhtjZux0OPz4blGIYvhrIr+0sl+SM4yyAox75C68ZAUyrV6I/HuX
 P71DyujtW+C26XCJ2hY7TJuy4WOMkk3LA/YMmc8zxw8D6ps+eb4Qxwb6StX5W/4i7gtxalEO3S
 CIw=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="131861941"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2020 08:52:07 +0800
IronPort-SDR: XAgzP5Mx3LodpH+Zt/fRvdFONsnHMZNU4f/19HWNjIYL30c/7aAYxlBpYFZ/IxtVJt/Ze78hgc
 ZGyQR/KTh6v3zSdNXH+80Au1QYFguKP2RqLeBRJyUlZzhFDu1LnRkQVoxDgtBZ0DSfOEox5RYc
 qsVmhBHJd9gMGfbxdBbh+/gnDcZEfIS0WcWZVT1weN/hL4okPqBRV76FSBUgWirXQ3A6VpDKhV
 ARsYk4Z+YTDmnfd/6il/YUS4L1GkhMzuFohbr6yA7mkbwOM6c4ZCh4iVtmppaam3Zi/Ylo1N2I
 05pM/CyxPtR6ejRY+4284cPQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 16:44:21 -0800
IronPort-SDR: s6E6nAwfKrR3/I66pI9YH2e3NW2rGkgF5VprEC/uucRDO64/xMaiy3VF38WpBkYRXUhQdcOmi1
 JBur0oHEupWs2fOtJHJtktbXZaSndVpPM4UrEva9MOfdKksn2Iyh00iD895gCHy9bpCGKnWugI
 g2mofUoICH58fVe/uwiKIiROyPDlDJAuZmHZgUIMl/AeNV5GmpQ5Nssh9XV+pqLfVy9GGbbHRB
 082NOdMNew2KI9AvbRSOVZlFVu9US870InwWKX/IVqN/JwJayDrE8THAaiLuwKOorRn7sHG7vL
 gc8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Mar 2020 16:52:07 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v4 2/3] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Date: Tue,  3 Mar 2020 16:44:54 -0800
Message-Id: <406774cf394d785da30a30d99169f0b2cf1bb1de.1583282640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583282640.git.alistair.francis@wdc.com>
References: <cover.1583282640.git.alistair.francis@wdc.com>
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

Add support for the clock_gettime64/clock_settime64 syscalls. Currently
we only support these syscalls when running on 64-bit hosts.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c000fb07c5..82468e018d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1236,6 +1236,22 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
+#if defined(TARGET_NR_clock_settime64) && HOST_LONG_BITS == 64
+static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
+                                                 abi_ulong target_addr)
+{
+    struct target_timespec *target_ts;
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
@@ -11465,6 +11481,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_settime64
+# if HOST_LONG_BITS == 64
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
+# endif
+#endif
 #ifdef TARGET_NR_clock_gettime
     case TARGET_NR_clock_gettime:
     {
@@ -11476,6 +11506,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_gettime64
+# if HOST_LONG_BITS == 64
+    case TARGET_NR_clock_gettime64:
+    {
+        struct timespec ts;
+        ret = get_errno(clock_gettime(arg1, &ts));
+        if (!is_error(ret)) {
+            ret = host_to_target_timespec64(arg2, &ts);
+        }
+        return ret;
+    }
+# endif
+#endif
 #ifdef TARGET_NR_clock_getres
     case TARGET_NR_clock_getres:
     {
-- 
2.25.1


