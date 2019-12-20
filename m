Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B2BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBE92465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rl7Mtd+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBE92465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiH5l-0001OY-DC
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1c-0004ms-Eu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1b-0007wr-8t
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiH1a-0007sC-QU
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:54 -0500
Received: by mail-wr1-x441.google.com with SMTP id q6so9153864wro.9
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bqp2vY6ZYjqYdoh+7hv2voXM8FmNpL/WqUxsGE1oBh8=;
 b=Rl7Mtd+wYfO2sBYfYEwqUKijA39big+VB1gytaYA6V223uSnjIWRdhlnwGBl05XELM
 8zDC72ZTf7xpCVG2BCGDO6vn9NBoepPAsMzU2X/PAE8hZfFR6+FQf3XKS4Usae/B4XNr
 oB4Y23OV/6G8SpDEDTlMiOxLzeHD8RWQrRQhUUHGSipZItC8IzezEcehAuLxKcFX6sjt
 +GGDbr5CaRyRyRGwRMMvBbGph3NE8EYxPBrMShKkNYIeFtbIeSC2VKdH0qwbaI2zjFYf
 KslAxqlsuFJcchaEhVPaywhjTNoyUSSZMbn4ppPMkVg/xCb76M7KsHPfpIvI8zoue8SL
 cFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bqp2vY6ZYjqYdoh+7hv2voXM8FmNpL/WqUxsGE1oBh8=;
 b=Ob2kKkBQlFvnrrBzwIeifC12yKIe0IqG0CF6iY+P+U8UsTKf9dCzOBM86Wpz7aQXBt
 Xi0/t/tOYpPF4z5GJfnmnQ20KJ7yCB0tUdAnDITE9VCiBqok2t6sfXZ/vc3NmQN8HYM5
 pQUvCm14E7+y8ti8cdDa1o4hODtWLlGsbpsv4NE8gM/Q5uu6nqo2N0OHhCrWkfMLEO6l
 u3G8RQGAutIhayQpTyA3bVUErVHruFTDJw58NuvsGV4UJCO5uLnsQHrLSFX+6PsB590p
 moTTObkxNZLkBfEgFSvqmOM/MWqFwMjf4INdP3kAPP5X2nwyh/yU5ed6yQNKEhizYF0F
 ULeA==
X-Gm-Message-State: APjAAAWzHf7IdFpk4ttnDW+xipF9Ge/Y+4OQk9BgG1DamY2NJ+dezAYE
 P0h3hwW0MjeRSM6UFDlPAnC7hQ==
X-Google-Smtp-Source: APXvYqxnDgfTdZCHAK78YzWv8LiD4DZJkiTplUF4zDx3TfTfRHF3rSfLEEv1iLr9Jgq6DXA/+shJrw==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr15500657wrq.348.1576843493629; 
 Fri, 20 Dec 2019 04:04:53 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t1sm9542565wma.43.2019.12.20.04.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:04:48 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 80C9C1FF96;
 Fri, 20 Dec 2019 12:04:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 07/21] target/m68k: use gdb_get_reg helpers
Date: Fri, 20 Dec 2019 12:04:24 +0000
Message-Id: <20191220120438.16114-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index ae766a6cb0b..2573ee7a535 100644
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


