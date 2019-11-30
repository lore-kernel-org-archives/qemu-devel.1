Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A87C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629B62075C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBbAsR6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629B62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayVX-0002ZZ-7n
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOT-000312-Bp
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOR-0003NM-79
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:21 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayOP-0003Jp-B9
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:17 -0500
Received: by mail-wm1-x341.google.com with SMTP id l17so16314092wmh.0
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/oYMZm4PMhPvYkXOCpY3r3pyiwYZIMr8ITabnwYT2cc=;
 b=OBbAsR6QVTpGDfkUR3PPmCRUwDZ/Aw/zx0VEUQ3Zz1oPgxRlTGCftDd/ajxXCwdBSz
 RI3POHzojjFJDSbgTwQjwmGRdfwFKaWHLJ2uQV4sUBmEDNT4l4+Up03BQFV3rbYMChTL
 EohhCJOR8QN4DXTRpxCRRdEiXbIppRXwx5XR5W2f8Ycuyk0ot8cCJCLwsrdDkmgVIDB/
 wbxTUXEpf7LA/A12CvvLldk1bcYzc2wnmOM71EEuA1gGwxFxsue3NHVhlvttZCbM52Qq
 9Xz84RA+NWMZyQZdRUt4WTuEwSE98S2RHmShH2UUzR0rkrHbvICSDHTt1fED+5j7j2Il
 OvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/oYMZm4PMhPvYkXOCpY3r3pyiwYZIMr8ITabnwYT2cc=;
 b=udkxfwqli6G0ES+0D46t2NJKmiauMDtWaEasGWh/jVXx3aMkZyM5wZ30r+aAJlCI/H
 u8bIr+P0eM4T3LnG300+3eez9wdihGpuCBR4f1LWUFpqjjna3Y8i7Y+wcTSujZkumx0Y
 Do0PKA7Zfs9mhz3jZeqM4guIrbfKbmRCdFCSbti+CJWnU5P8NL1+89GzU7Oykk+Qk3IR
 621VD+ScQy7k2oBs2zMlKzzmwaBWfkgbfxHLwqCmWzY98oc4rlEELO360vLTz1VCWrjy
 MzHLLtxjoM/Na1lBGpj9MZd5DeRGkLlq+9w7ayszBCPcbNb4z7DDIXB+qlIbSFjXoUYl
 dh3w==
X-Gm-Message-State: APjAAAXxiO6uwoP8cJYYnhuIqnk43LBbKrkt/g3LUyn7Nb3VWmk1q1DI
 nHw2EIQplQvHqXIGw91kdw0zXQ==
X-Google-Smtp-Source: APXvYqzeAfwJPFFaNqRpNo+PqNCW50T6QiZIpdKLSRqT4iM+R4Lywo2Rxpndx+hLQywn9R6jM9CM3g==
X-Received: by 2002:a1c:9a8b:: with SMTP id c133mr18188441wme.82.1575103574569; 
 Sat, 30 Nov 2019 00:46:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v15sm15648602wmh.24.2019.11.30.00.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:46:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BC171FF96;
 Sat, 30 Nov 2019 08:46:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 07/14] target/m68k: use gdb_get_reg helpers
Date: Sat, 30 Nov 2019 08:45:55 +0000
Message-Id: <20191130084602.10818-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191130084602.10818-1-alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 alan.hayward@arm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/helper.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index ae766a6cb0b..70b0c0b5076 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,19 +72,15 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
-        return 8;
+        return gdb_get_reg64(buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(buf, 0);
     }
     return 0;
 }
@@ -112,21 +108,18 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 static int m68k_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
-        stw_be_p(mem_buf, env->fregs[n].l.upper);
-        memset(mem_buf + 2, 0, 2);
-        stq_be_p(mem_buf + 4, env->fregs[n].l.lower);
-        return 12;
+        int len = gdb_get_reg16(buf, env->fregs[n].l.upper);
+        len += gdb_get_reg16(buf, 0);
+        len += gdb_get_reg64(buf, env->fregs[n].l.lower);
+        return len;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(buf, 0);
     }
     return 0;
 }
-- 
2.20.1


