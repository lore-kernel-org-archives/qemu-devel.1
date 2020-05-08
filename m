Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65663C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339902192A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAqTNPkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339902192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7sQ-0006Dj-D8
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7ho-0006yp-KZ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:40 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hl-000788-O0
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:40 -0400
Received: by mail-pg1-x543.google.com with SMTP id s18so1223426pgl.12
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n208OOL/5mz9BQVOgVsrwweVrr5EapOZuk9HWHgyuak=;
 b=vAqTNPkN8xkxkY+8+YQPsFhC3R0dMR5VB3bStjJkzwXj2bUolwMUh/h/GwA+fDgL9A
 wDlQDJCg5VvBkOAxDxDYOXUurCMYPwsdKsQGAnb2CiSyOkmCY4DUjch872w6FQXwrQFt
 evttjGW5RZw3UXzJU+ognuo6n5wnx7oaD6pfCQwSzLeKa6BrQl2uKQxR5MLf2NB8OEAH
 ejzF/P4WPyQkL6R2lYy8u3eIGfBxekuwH4lpzqcyF9Yc3XOGCWcOqjHJ9/e37j3+jStV
 lcoKtrm8H2qjZLI+Eu537L+dcf5ocTgxwwogkjImJ7w1iNj1gdK3txB1ev249fuUnsX+
 HN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n208OOL/5mz9BQVOgVsrwweVrr5EapOZuk9HWHgyuak=;
 b=FtL2JI+hpoO3UptI9dKouSnJcnRg0ihMvvHUTk3Qs1ZixlTh5Ug2YZB4/3TKgnkGB2
 /c5sk8oQdvacnTWJDtMNGfZQyXiZo6Le/sXsmmbzyxjOmSIeWJeucgeRKidPer1FAjHu
 JXYNSyAt4BTM+prSmSN2u4mKoYnW/y+Yfk9ksANkx7kwEzRLwmBYiH7yZwcI1ozvnlBO
 JG0+kTxTXMSO3WoeKqgc9OKjTVVvuQbmcxF9lkmTCuceJrNGekxQGT6oJfBNxvevFNoh
 Nr/33/4VprsXbNumnQnFZcqFidJJuE+7TtYHb0lMRpIxu67cytpKeUhWZzWidG0yskP+
 YlBg==
X-Gm-Message-State: AGi0PubpRWIi93M8srpuIfoB5B7C00jEM13wuMM2B1b9FPqipuQi8sg2
 /qxkB+O52yuHvodvXNo7Ybju3VP1S/g=
X-Google-Smtp-Source: APiQypKNULk7HO277MVFdV8OsdQ2H7GRsjl7l4Qrbaa8vhpc1NVMTI6cb0jbCjqXgJvC+OCnGtjc5Q==
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr3094707pga.243.1588962395946; 
 Fri, 08 May 2020 11:26:35 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/19] tcg/tci: Add special tci_movi_{i32,i64} opcodes
Date: Fri,  8 May 2020 11:26:10 -0700
Message-Id: <20200508182616.18318-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The normal movi opcodes are going away.  We need something
for TCI to use internally.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 8 ++++++++
 tcg/tci.c                | 4 ++--
 tcg/tci/tcg-target.inc.c | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index e3929b80d2..5a941eaa07 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -272,6 +272,14 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 #include "tcg-target.opc.h"
 #endif
 
+#ifdef TCG_TARGET_INTERPRETER
+/* These opcodes are only for use between the tci generator and interpreter. */
+DEF(tci_movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+#if TCG_TARGET_REG_BITS == 64
+DEF(tci_movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
+#endif
+#endif
+
 #undef TLADDR_ARGS
 #undef DATA64_ARGS
 #undef IMPL
diff --git a/tcg/tci.c b/tcg/tci.c
index 46fe9ce63f..a6c1aaf5af 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -576,7 +576,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             t1 = tci_read_r32(regs, &tb_ptr);
             tci_write_reg32(regs, t0, t1);
             break;
-        case INDEX_op_movi_i32:
+        case INDEX_op_tci_movi_i32:
             t0 = *tb_ptr++;
             t1 = tci_read_i32(&tb_ptr);
             tci_write_reg32(regs, t0, t1);
@@ -847,7 +847,7 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             t1 = tci_read_r64(regs, &tb_ptr);
             tci_write_reg64(regs, t0, t1);
             break;
-        case INDEX_op_movi_i64:
+        case INDEX_op_tci_movi_i64:
             t0 = *tb_ptr++;
             t1 = tci_read_i64(&tb_ptr);
             tci_write_reg64(regs, t0, t1);
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 992d50cb1e..1f1639df0d 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -530,13 +530,13 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     uint8_t *old_code_ptr = s->code_ptr;
     uint32_t arg32 = arg;
     if (type == TCG_TYPE_I32 || arg == arg32) {
-        tcg_out_op_t(s, INDEX_op_movi_i32);
+        tcg_out_op_t(s, INDEX_op_tci_movi_i32);
         tcg_out_r(s, t0);
         tcg_out32(s, arg32);
     } else {
         tcg_debug_assert(type == TCG_TYPE_I64);
 #if TCG_TARGET_REG_BITS == 64
-        tcg_out_op_t(s, INDEX_op_movi_i64);
+        tcg_out_op_t(s, INDEX_op_tci_movi_i64);
         tcg_out_r(s, t0);
         tcg_out64(s, arg);
 #else
-- 
2.20.1


