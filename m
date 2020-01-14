Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF90C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8F2222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5d4CIr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8F2222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNsR-0000NL-65
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpW-00054h-FV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpV-0007Sb-73
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:06 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNpV-0007Rl-06
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:05 -0500
Received: by mail-wr1-x442.google.com with SMTP id g17so12518138wro.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dc2TB96P20SvqSbGdvpR700XiNQtXmvcj8ruUddj/b0=;
 b=E5d4CIr457WSRRiN8poI2FFI5MrAAEL2JP1aKIOMu6l+96xSRKNtJ3yg1G+A5kXR0N
 FyNs30RD4BABNlN/TZz8D3EGZKmsM9xgK6Aq45AFR3B9/bKXFQWV+6k4mfv4/iofGMzi
 TkmTow79QX9xQLzKeCqp1+etHBi54aaRotdal7kP0AmQA19gqwgZcdQM8a4jO0jyQl6Q
 ZS/3XVp41450qkfI7RKYJTg9njnrbL/eBKcV3YZgGM60oAQpihJLHO5VmCuJFIBeevC6
 XyVlVWEiiPvDGCJrwIb1UB8cxKz0s0/7HGP+zgPFdqhZ1d65LONu5o4ozHO3MuggYmH8
 +ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dc2TB96P20SvqSbGdvpR700XiNQtXmvcj8ruUddj/b0=;
 b=ZdfDtyiJIHQ7tpHcGxlDa6xNicZPyLdjW2QDIOgUFYthRsfT2pRMZLbyOtJ5XeUCFq
 tHiRXmJLxzQArHNKm5LTzhXm5WeNptolh5iNyxD/OBLqbNeNwqIKhfyL2ro5W30Y7cKw
 S2KbwMK8UWjuLSSJlFPlZwKnsoEr1XQmawXa7qmSlG1AA6mpknm6KJ75SN3uA9gTIvo0
 hbLiG9fLHMUtr+mXHc/bELWXCFyLE7GiCO0lMEfoRe3I0Udy22g/Zkan+CY3Qra7g8Pk
 7YXnBwueJwjWs6kDbhujm3WnuJiqaHau9lDg1iQQMvs5UtPcR89wYdW9Vf3+Witx3mu3
 qK9g==
X-Gm-Message-State: APjAAAXVKLpkB6BdRNRe5v7668RVFM8qvduQGySZYFTskFk80EExvwr1
 w49e5dtrUWcTqcUXimjev5CSCA==
X-Google-Smtp-Source: APXvYqwCLtaGHWS/Uf4HJLlI1G6cGlx2IGfAXH3HHx3vIz/P2ir2sCIdM4OcttQPMSFeS/4cT5XAeg==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr26540999wrq.348.1579014604017; 
 Tue, 14 Jan 2020 07:10:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t1sm19255049wma.43.2020.01.14.07.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:10:00 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B37061FF96;
 Tue, 14 Jan 2020 15:09:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 07/22] target/m68k: use gdb_get_reg helpers
Date: Tue, 14 Jan 2020 15:09:38 +0000
Message-Id: <20200114150953.27659-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

---
v3
  - fix mem_buf references
  - fix mem_buf + len cases
---
 target/m68k/helper.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index baf7729af0..c23b70f854 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,19 +72,15 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
-        return 8;
+        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(mem_buf, 0);
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
+        int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
+        len += gdb_get_reg16(mem_buf + len, 0);
+        len += gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
+        return len;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(mem_buf, 0);
     }
     return 0;
 }
-- 
2.20.1


