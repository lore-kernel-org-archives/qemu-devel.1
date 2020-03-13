Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BBCC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 00:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59172074E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 00:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ElOZYTtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59172074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCuK4-0004n0-1W
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 20:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=335a9ddda=alistair.francis@wdc.com>)
 id 1jCuHs-0002Mq-NC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=335a9ddda=alistair.francis@wdc.com>)
 id 1jCuHr-0002lb-LK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:04:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59693)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=335a9ddda=alistair.francis@wdc.com>)
 id 1jCuHr-0002Yq-Bw; Fri, 13 Mar 2020 20:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584144276; x=1615680276;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5LAi0O+mTaWDQDimiBocyA7wHcDy5fDRMj7L3Yuk5mg=;
 b=ElOZYTtYcsFZ/DmMpXeJgGLfi4Y+ztLTse/kycwT1F0fFuePuX8jQc+2
 +0QI51rGRkxr/pdY66pSB/E1SwQLFZTyqpCxxjI2uGEnxKX7eLKJH+jhj
 sP6vL1gQj7B0rqbfNI5EnSk0El5VRhuiLKcCcHK95JWIcIMAwI1E5rGM/
 ch+Aj/cRo3qogLZXdFb4iQTlNbWnzSkurtZOmzcPDFsxh3kukZIW/2Dsm
 Ur6c68zJghrQRAHawoKJ60rJdsOqvjJ4NlwB/dNDFpoO+LdD02nsxSCSe
 Brnc5t2qzR1cN8nXyARz/OrZXMEijqny0bdLETICmx6HSG7ecNl3sx3zM Q==;
IronPort-SDR: 0nL148wVL0zZPX73+ib/t/n7QANKk49ILLECVm52iq4FXXMo5iau2bd5Dw1B/9F4DOtGxQeUIf
 jRW6fOHDM7NTCo5+frrqmTun2Z7tz4SdoUyVJWoCRC0MSX1Sy2JtuBkXcVK1N/771DddUUnkuc
 1iyzc1mBdFHoAlQwz00G3jrpNiSz5U+lyR9V2EjZ2kHdEH7nGo7QeexYfBLoPYK6fvS0J4Hkfr
 D8crGoX5lOkCSzBnoVWMw7u8RkIxjGCNfloSozAxD6shjM7735aU9vVaTkYPXsbpec+V5qQzVO
 Wzo=
X-IronPort-AV: E=Sophos;i="5.70,550,1574092800"; d="scan'208";a="234512347"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2020 08:04:34 +0800
IronPort-SDR: e0JnlDK1nR/KaIZceeM0D+GLtnQ3ZoUBuH0MQm4qx2bND8n3j0pNgMvnUq9W2EHW0Kc1DuDSDT
 nwgu6RtFaALdCTgMCZyakJyEketo3pq434y9G3QYTBcZOXl5oEUkEMsz5ca8HTb3yCe1NOppqf
 p/BCvZpBo2nF4Iq5DzrDLMSlhNex6vNvMZpYoDoxdLDKgvOQG8Z54F+6tk+happG92lWuKPArP
 nFCL11/0TvNwrD8gHnv6tSNLN4galTrvo49Bld7h6he8+3H2vHLM19cMydgxDdDQBW5hbSr/Ly
 9BZ3RizttSjk98+KRyOJdg2V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 16:56:15 -0700
IronPort-SDR: 69rhew06GaGn6/i3783P27LMwsehdUKDmth15d4SuoOR9TiTBtogBuz7bSk47iz8UOXUXEhIXZ
 wnS+mYVxuHuqlnWFp4NF4crkF4Asgue0jymQIAU6daRFxJAl/9hMTGdC+Ii8SomB6c3ga9g6Ht
 wQ8UYtYKKwyB7WgXgyVOvYTsXZe6HyAKXWyYDotUBOop67liWdo3LJl+dVG38Vn+ofbou1B9u8
 qKgcRzzPmIGbO1YWJ4wg2W6qlbjS9zbK+A/i/o5UTcJ1Y+N0P5DlN/6BmMn0CnG3gWGZ43vfRX
 eQY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Mar 2020 17:04:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v8 2/4] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Date: Fri, 13 Mar 2020 16:56:51 -0700
Message-Id: <efad6b58d441d93cafc7af634cfefead1fa35583.1584143748.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584143748.git.alistair.francis@wdc.com>
References: <cover.1584143748.git.alistair.francis@wdc.com>
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


