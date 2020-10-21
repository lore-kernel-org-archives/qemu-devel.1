Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED966C5517A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307B221707
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9ULPFU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307B221707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6Hi-0004pf-9d
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 01:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66a-0000g0-1h
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:08 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66Y-0005kU-5M
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:07 -0400
Received: by mail-pg1-x543.google.com with SMTP id j7so738718pgk.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8KTCdxjlJBVxcdguTe2Cz9K9OkOOhurBPmgTH8Me1bg=;
 b=Q9ULPFU8dhQw8aiJGgYBOPJtq9wfe5Y/nkpSCRWc0b9hS+uuRrQBDhaiwFLxkebz7Q
 BvyJ4CQdbsDtYKNPEdsudjEICs17QD7dPrnFC6eTyceSTzhOStPCUD7WoAnduVZeVeNG
 KEG5dV4D0mzCOqCdt7lfk84o5IHXLEfGRONYOzb/v4+GK659F96XYuxIl80PF5K1bS1m
 DlpccO7S9B+FEroeiCMjSe2Wg/jgoa0F+hLDGRT314I1CvBcWmzJxaSZ0/KOw7128abF
 SpIKqiA3VGU0PuDc6+qgANbkrZxtwHokkvSyD93ZPMJOyC80jadiCcUlT8kNNRna6Lyd
 KS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8KTCdxjlJBVxcdguTe2Cz9K9OkOOhurBPmgTH8Me1bg=;
 b=lGJUTycOwao7GQp8AvUrIlI5LokxVu0NJi2z9B/vmP8vhElfSTLMGBV21qezy3un0i
 M1NXPYo6ttL3BPaHxnkcCQbS+MBaq0tMAzJs5CKb0eBIsRPMsU12bmbDexgiVFA0+YjI
 w/+QKgs+v2oGuKDOpS2KevyqIAOBSF0ZKB5dYnVzUYTYvCv3Q7HxnKGa4EgZEEh9J8z0
 O/1kbTAZY8GykGsBZ5gALr/9JQGgR3JW29AX/a6CbJ5KkClE9xEf+0NiAB6oCtStpeIO
 LS2Pka4v5+Fd4FEOhQcvRIDhJJfPlINSbWR95d01Dvzs4oBOwg4L7nYuOw5+opjUdfpk
 NPqQ==
X-Gm-Message-State: AOAM530Gl+ae/EhLRC6LZiCaHwpHnf2b6tYreK8VkUK/x6WftcmBG5XI
 W0YmpL6MaLOED7zEYiS4DR7gUm5Kg0n/rw==
X-Google-Smtp-Source: ABdhPJxv9HR9jQfJSI1CernTrstBJpGbZogKVZKFP3IX7GUn7gY4D3rky8UONoDdZwVncc0xUZ3ZOA==
X-Received: by 2002:a63:3fc7:: with SMTP id m190mr1556251pga.293.1603255924565; 
 Tue, 20 Oct 2020 21:52:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:52:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 10/15] softfloat: Inline float_raise
Date: Tue, 20 Oct 2020 21:51:44 -0700
Message-Id: <20201021045149.1582203-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h        |  5 ++++-
 fpu/softfloat-specialize.c.inc | 12 ------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 78ad5ca738..019c2ec66d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -100,7 +100,10 @@ typedef enum {
 | Routine to raise any or all of the software IEC/IEEE floating-point
 | exception flags.
 *----------------------------------------------------------------------------*/
-void float_raise(uint8_t flags, float_status *status);
+static inline void float_raise(uint8_t flags, float_status *status)
+{
+    status->float_exception_flags |= flags;
+}
 
 /*----------------------------------------------------------------------------
 | If `a' is denormal and we are in flush-to-zero mode then set the
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c2f87addb2..0fe8ce408d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -225,18 +225,6 @@ floatx80 floatx80_default_nan(float_status *status)
 const floatx80 floatx80_infinity
     = make_floatx80_init(floatx80_infinity_high, floatx80_infinity_low);
 
-/*----------------------------------------------------------------------------
-| Raises the exceptions specified by `flags'.  Floating-point traps can be
-| defined here if desired.  It is currently not possible for such a trap
-| to substitute a result value.  If traps are not implemented, this routine
-| should be simply `float_exception_flags |= flags;'.
-*----------------------------------------------------------------------------*/
-
-void float_raise(uint8_t flags, float_status *status)
-{
-    status->float_exception_flags |= flags;
-}
-
 /*----------------------------------------------------------------------------
 | Internal canonical NaN format.
 *----------------------------------------------------------------------------*/
-- 
2.25.1


