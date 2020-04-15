Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D49EC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1874720768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOxIZEg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1874720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfZ1-0002xy-7P
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUv-0002O9-Pl
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUu-0003Ai-Gz
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOfUu-0003A4-AO
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id i10so18515803wrv.10
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GnU4V1ssA1vvrZAqgpc7l1Tr/eH57b7BySlJY/PvGWg=;
 b=pOxIZEg9XzXXexDMvObLCzOlHhXv+fua1xazJDYfVWTIFR3twymeWGfi5rc6T/sGNu
 lE0c5mgI4HAGfpxJnE3bcsIuv+w+n91LNqPY1dijXi86esrtYRqkyOxfR4WSPlPBywke
 8ycQR7iZAaFHfnxri+IUqy+D4/u4tSw/Nz4hUiNxLRENEp63jNAFQOaY65OicB+jcswi
 xCp/6GZsCq/PHRbWrdifaJqIlLyHfgGu8NRigS5QLDY0l+XwMBsZBKve8LkDvm3jckt1
 Eq2a6iaip5q4ue5sajKeUz5eecIaBszg+14YqYlDkc5yVAc47KJbvf7NsyxD+ZL/o7nb
 +fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GnU4V1ssA1vvrZAqgpc7l1Tr/eH57b7BySlJY/PvGWg=;
 b=Qc5EnylTagAKyy4c5Q/1uEdtQWaz84+NLR6N5BaG6QxpSSMtSSzDD3zpsBh11mQUQd
 9KUOCOq/Bz1yK/gHB2HmkF/4PEcShoZ9J1kWNhlVgjF57XJKFTvLK/FJG6AvvHLMMzq5
 9ciMFU5cfuQo1DSwlbFzIzJneqaXCITl3cDQ5Bc0v1hXo+aAQqpAOPSTEr+sNRiKLgY5
 TAWN/oDQNzyI+k2g1u8smibXxHoGx7rNMM0xUUK3L4Lme/4AHncOjWEZmePGPO3OC/Oz
 AseHKpCG2rP3lNUsLw1n1llZInhWNy+2fZwe5pbvJZQbKgribAhP/ontOe9ZCgzrwfgV
 HCow==
X-Gm-Message-State: AGi0PuaHlWXMwMAHbMsCu3Kfrav4/0jynlhi7TEx+BX4eQUKxz4dCOcO
 JZ/1Wpc2IxXRKex2uFH367ytH1J43Tk=
X-Google-Smtp-Source: APiQypJl48ouiU1VkrUrqvMGKDSloOtdgVKfSYlBFyeJ/sEE0hyPzarLJ1ziW/RMeCjOs/npr1v6jw==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr16409449wrn.390.1586947343281; 
 Wed, 15 Apr 2020 03:42:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h137sm17314440wme.0.2020.04.15.03.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 03:42:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B2FA71FF96;
 Wed, 15 Apr 2020 11:42:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 8/8] gdbstub: Introduce gdb_get_float32() to get 32-bit float
 registers
Date: Wed, 15 Apr 2020 11:42:11 +0100
Message-Id: <20200415104211.9388-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415104211.9388-1-alex.bennee@linaro.org>
References: <20200415104211.9388-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since we now use a GByteArray, we can not use stfl_p() directly.
Introduce the gdb_get_float32() helper to load a float32 register.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200414163853.12164-2-philmd@redhat.com>
Message-Id: <20200414200631.12799-14-alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 3c452fc50c0..20e10726929 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -125,6 +125,15 @@ static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
     return 16;
 }
 
+static inline int gdb_get_float32(GByteArray *array, float32 val)
+{
+    uint8_t buf[sizeof(CPU_FloatU)];
+
+    stfl_p(buf, val);
+    g_byte_array_append(array, buf, sizeof(buf));
+
+    return sizeof(buf);
+}
 static inline int gdb_get_zeroes(GByteArray *array, size_t len)
 {
     guint oldlen = array->len;
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 49fc4a0cc69..34ad3ca0508 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -58,11 +58,9 @@ int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_regl(mem_buf, env->fpscr);
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
-            stfl_p(mem_buf, env->fregs[n - 9]);
-        } else {
-            stfl_p(mem_buf, env->fregs[n - 25]);
+            return gdb_get_float32(mem_buf, env->fregs[n - 9]);
         }
-        return 4;
+        return gdb_get_float32(mem_buf, env->fregs[n - 25]);
     case 41:
         return gdb_get_regl(mem_buf, env->ssr);
     case 42:
-- 
2.20.1


