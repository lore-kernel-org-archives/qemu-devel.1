Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63E7C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 21:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEF72082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 21:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUzRlCcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEF72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq1qk-0008NL-RC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 16:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1iq1q1-0007vl-3p
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 16:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1iq1q0-0002iO-7H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 16:29:01 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1iq1q0-0002eB-0x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 16:29:00 -0500
Received: by mail-pg1-x543.google.com with SMTP id 6so1589369pgk.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 13:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8AYg1chBm/3+FdlYUxpXHIjfTe3u4FtxJXy2WDGRSv0=;
 b=oUzRlCcp9bapiiBOvv8ocnZ7YGsSBlylxyyJlqWy1HsDqNyZikoLtMlcC7NFaskXRj
 knq0IiYuXVie7+effr89POiismv9xYptzvDwiDQCqVXiy9M+J/kuz9A0VL42nNtjbWuy
 gBdHXMFOyYiTUMXnaOE5AbAwbRshwSsPxJPJ3SouKfvWJnl4Ch6t2pXDQONiaDK2Tz39
 W8yWFA5qPUC3Pxtuba4t02szOGqBlJmE6k4bMmt05J8rXwo5oRb/u0dWVpFEwvWxijw7
 jVqyiEj5DIqMmpxzWnm62mIGAgBaciI8W1Uma3Mp0StjS8s4AhWfZBBffH2CBgqm4B/L
 AtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8AYg1chBm/3+FdlYUxpXHIjfTe3u4FtxJXy2WDGRSv0=;
 b=f/LYWHDnAuzMwqGldZJ7gCMUFApWJEovN3aMOBDOvMlmJIE4VFzj2VD9Z+xtVsGfse
 vRymisVkD8coQgzDbId0k5tnDQJgaOuKRgYq8oLOAkvfqL69Mjm6Rh72lg297yOGC5za
 aL8ymfpVqf8g2tEk0zSnIYuvJYRBtiYHNQ/n0tgOsK5NCm+ywrmvOIwStEbhGT7XWYmH
 aHBFkwS2K9+gbUhPA9rne2G/Pogk9T63av7JNeh30WhDM3pNWZAg9iv/ecbotUW9+GoE
 xU3Miv/USZbsn6kXu6vOYlMnBkmdpaMOgmL4/kkv67T4v7QWDS25EjMskLAcPaRYB3tv
 nONw==
X-Gm-Message-State: APjAAAUj06KDK98T+jCpOzx1UbTGDUMKJdy45AjujicWBrNB2XQeQCdm
 6GINHArGcgRIYR3cU/6DQo0=
X-Google-Smtp-Source: APXvYqzsmjduJWm5gR220qr+f42GOU9/Q7VRiDq1q8hwPme4QfIqP9EsSg9E5kIyu0XllZpLC1aU0A==
X-Received: by 2002:a63:4b52:: with SMTP id k18mr6659855pgl.371.1578691736954; 
 Fri, 10 Jan 2020 13:28:56 -0800 (PST)
Received: from localhost (g52.222-224-164.ppp.wakwak.ne.jp. [222.224.164.52])
 by smtp.gmail.com with ESMTPSA id
 u1sm3844581pfn.133.2020.01.10.13.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 13:28:56 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: shorne@gmail.com
Subject: [PATCH] target/openrisc: Fix FPCSR mask to allow setting DZF
Date: Sat, 11 Jan 2020 06:28:43 +0900
Message-Id: <20200110212843.27335-1-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mask used when setting FPCSR allows setting bits 10 to 1.  However,
OpenRISC has flags and config bits in 11 to 1, 11 being Divide by Zero
Flag (DZF).  This seems like an off-by-one bug.

This was found when testing the GLIBC test suite which has test cases to
set and clear all bits.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 59e1413279..6f75ea0505 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -70,7 +70,7 @@ void cpu_set_fpcsr(CPUOpenRISCState *env, uint32_t val)
         float_round_down
     };
 
-    env->fpcsr = val & 0x7ff;
+    env->fpcsr = val & 0xfff;
     set_float_rounding_mode(rm_to_sf[extract32(val, 1, 2)], &env->fp_status);
 }
 
-- 
2.21.0


