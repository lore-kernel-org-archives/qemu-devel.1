Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CEBC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EA820775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EA820775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgXA-0000ra-Tv
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGgPC-0006AP-Uo
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGgPB-0000fE-Qv
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:30 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45343)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGgPB-0000ev-I1
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:29 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNbtF-1isfD40MKh-00P4OT; Tue, 24 Mar 2020 11:03:17 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] linux-user: Flush out implementation of gettimeofday
Date: Tue, 24 Mar 2020 11:03:11 +0100
Message-Id: <20200324100311.588288-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324100311.588288-1-laurent@vivier.eu>
References: <20200324100311.588288-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BDgKtJ3PdH38sT4Jmsw0Fn45Lmg9valKYxqr6lfeLDh3VR6EOxW
 QkdRhqFTqyMzdapPI1bsoGxPg/rh165/6KTEAAVh3U0C3UsBgIZQfiAwU9dChvEq956NInB
 BKUY1n/9Niflk/85K9MiU+mTPhm53uSZfgFAAMLSRe00P7OxiLNCyhskWGaU0DBTdTZBCuE
 9Y5C3pzg1lyWAeXqe/p6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YA3TI2wChNg=:Zvy9njpM/w82aGvMT1aNE9
 v+sEmeupzbMp7WAjjkSfUWzP9VSu7vaHKDrfy7GclHAb7co5WQhxMwd3PNSmQYWUgEQURT5c6
 kBH3uZKXzNfaSeEygsvXCC2zqHWCzvGmkCF1SQaADaNEHqnAi6tcm1PI0E44S0OQKOAxHzy5D
 VBcPTAySslMqDnitHajcDdZgVcYHVkojPpWGhN/qI857fSmueWnb3nANxmokc+oTn4QROc3vI
 tKQLzRUJPqPZoNL++nWxpKchUXKzLHojoglhuLZVY9ekyxxL31raiAmfmJa77aCsefj2Kx7SH
 SaPDo4AmO/z1DI+MFOABzyXUberenh59lnLMpEp/YmXMFhE9u9BOw1lKU2QYs3GBkSFcdVN25
 nR2333e5/rTnk41cHHkTkFd4gL0KpX62FSr77IVg4avzqGZPxv9/6IWftfWXB6XLF065Le5SA
 0971qXlNDRAsSXtPxPJe1467R1Oy4UOwCk1pIjZ456Vvjp1jo2YDfTfgOeojEIAhExFN8Dszj
 ZSHhZu729beTG7Mc/XhOA+rNaLGywxKAXgCsH/jvx6FRNHO4pXSigAsSsprCGi1L/QXMyuQta
 NJJVPxwIaPbxZgSeq/aNQUBctSiZp/bVvCOe2lc1XW+giZ8ZrX+x+zWZLG+iu/l6dzH3PGWdk
 U9rEqawb+b1805Ml/KmAMet5pxY6VChaKebtOgf3LmTyjtfyPOm002MdKvoyxesgq+bAFutqc
 WeeEp7E4SYBAIfkFToMqyALMwtK2X5tJifhPgp0dFdummiEzYyAyPeERWDmrzwdy90nJDU2rh
 LT0tO1tbqlWAsPQT8C1/QnlvMtJiJq0t/4gTllO8yzZC9MEZq4QVR+3pWgDXAb1WceGJiMW
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The first argument, timeval, is allowed to be NULL.

The second argument, timezone, was missing.  While its use is
deprecated, it is still present in the syscall.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-6-richard.henderson@linaro.org>
[lv: add "#if defined(TARGET_NR_gettimeofday)"]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5675eca962d7..b7e8a98d4dc6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1273,6 +1273,25 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_gettimeofday)
+static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
+                                             struct timezone *tz)
+{
+    struct target_timezone *target_tz;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tz, target_tz_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(tz->tz_minuteswest, &target_tz->tz_minuteswest);
+    __put_user(tz->tz_dsttime, &target_tz->tz_dsttime);
+
+    unlock_user_struct(target_tz, target_tz_addr, 1);
+
+    return 0;
+}
+#endif
+
 #if defined(TARGET_NR_settimeofday)
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
@@ -8710,10 +8729,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
-            ret = get_errno(gettimeofday(&tv, NULL));
+            struct timezone tz;
+
+            ret = get_errno(gettimeofday(&tv, &tz));
             if (!is_error(ret)) {
-                if (copy_to_user_timeval(arg1, &tv))
+                if (arg1 && copy_to_user_timeval(arg1, &tv)) {
+                    return -TARGET_EFAULT;
+                }
+                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
                     return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.25.1


