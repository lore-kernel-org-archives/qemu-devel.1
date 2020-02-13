Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2AFC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DE021739
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebFsybtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE021739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j257x-0006xK-TG
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j255H-0002KQ-4W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j255G-0000TH-5u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:35 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j255G-0000Pw-0d
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:34 -0500
Received: by mail-pl1-x643.google.com with SMTP id b22so1740614pls.12
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 19:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=loZSDj7GbxB0gzb7RHJRf8hxO888UT+p/O47I0Z8QQ8=;
 b=ebFsybtErAWS33ZnmSR9QtMslkJ+yhZ1QYl+bDmPK8/RDQ4UPTffxGbi6DXGB54ZS+
 R+vbhhSCdcQSMfT5dERWaIzUJfa1Oihc8oCYDvLx9h3LxCciGYsiS8vmGnEb4KnF0ntj
 HiwkAnilA9x4gtnDiiYimLfCblFIpDri62aW9NXAC0ToiwdzQoLfRiGx2NHCWnZV4EVP
 LIipGOgtOSqbyaPJ3iGg8XVWVKiq7P+XmWs9IqcI6XsQ570HiI4jEAF8opERscEnoCVt
 1z0BQUhxgwAfpb737KDnQjd4wfRx6cxQUibhVRtiy+9qAYUHe9PFLi0y8lZgV3znDg+f
 tPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=loZSDj7GbxB0gzb7RHJRf8hxO888UT+p/O47I0Z8QQ8=;
 b=o7rh8FzJ/tctknX9aaO8B+fzLuEXf2C3ozQqlLAq0XA/sI8QemLBnd2NyDZ9a4wRYL
 YxXzgBw8yeaOy5deOlg8S1Kut2do2kIAfYD/o7D33jH6fAVtQT99HWZubajDe1o0GONr
 LBYSXvpLXCDNdIHFYyZrU9NUtdDaChKQK0q8bmEamujLpHd0fvzFQkRR1ZF1ADMU31f7
 2fxDExWES6VraNw5tCfjMD5QUFxiDj/pKPcDCY7dymGA1l3Pu+3zxDqeW25YKj0CTVXC
 /h2KVLmSqPDM3NWQk5Hl6XgT8nIIa4HieX1abapBFrJ1qrh1vVivQo42/JrhkVdK1P31
 4hAw==
X-Gm-Message-State: APjAAAXxQ4eJJA8ZR4R4rh1RNCEWJfXdHMMgnZXXDyMxL3i0VkoOZr5l
 FF2pLWtl7K0HMLYTz3V8Bsx6c3hTtGA=
X-Google-Smtp-Source: APXvYqwNvfsmkw+VtaU2TON506YdcYh+9hUlHOtRy3wqRYCVU5ax3+zzKVox8eLZ0IbJDGRUELqkyg==
X-Received: by 2002:a17:90a:e509:: with SMTP id
 t9mr2534894pjy.110.1581564152733; 
 Wed, 12 Feb 2020 19:22:32 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm536067pgi.31.2020.02.12.19.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 19:22:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] linux-user: Flush out implementation of gettimeofday
Date: Wed, 12 Feb 2020 19:22:23 -0800
Message-Id: <20200213032223.14643-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213032223.14643-1-richard.henderson@linaro.org>
References: <20200213032223.14643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first argument, timeval, is allowed to be NULL.

The second argument, timezone, was missing.  While its use is
deprecated, it is still present in the syscall.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b684727b83..a006e53088 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1224,6 +1224,23 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
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
+
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
 {
@@ -8575,10 +8592,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
                     return -TARGET_EFAULT;
+                }
+                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
+                    return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.20.1


