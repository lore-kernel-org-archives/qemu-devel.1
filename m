Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9E5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462A220665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N78+NB1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462A220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAg8p-00078U-CO
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg2w-0006rJ-NH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:59:58 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg2v-0001c0-3I
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:59:58 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ls14so121208pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VbBY1yItMeIkPbGFrNMfYpfJv2H3xsn/XCS3gcTz2VE=;
 b=N78+NB1PhP9V0tYk48fl7Mg3+sokZAFY8wivDWgDC0Lrz1vXqrVdV+5r0Eyp3ry37G
 SUTlqfcwpFC8HmWej7OlcuImek2vapqA5GvnlK6d0a5IodAlRLmTjJrj8QaCDvlvLK21
 dSQESHTmhh3qXbxhoKPjTouLSXaHOaB1Dy9IVBDuonx7qd54O0TuXoD7rLmv+G5jYlqe
 aTDHciyYkSLAV1dVXcksYxO5xvqSM2Po5/Wtr7rGSFlpvhVKDZ9vMiinOHxJZDT0hlzc
 ZEQBhBTRHouvg6M9oht0GuB3c7E81CLu49MXEv+6ZdT+ugnEmer0YN6u5/se2WR7dkTf
 LsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VbBY1yItMeIkPbGFrNMfYpfJv2H3xsn/XCS3gcTz2VE=;
 b=NL0IoVR2uTkvHvUUQd+F8m140VTgyWpfW48tAFfuZoJutO9aVLhDQbmKDw2QF+cntR
 lSRpDCzL63P5XKeXHPTmZhCFFJQ53pxP1X5v606T6mV4/Bb/yaCxj3ahORCJqjEkeaqm
 gPDfM/T95jeTEp0lVrIwgg4m40Q26UpK/E6VAh8fLxlXWnCrKhYCKEqiNZSw5cSWY3uP
 CJ59MC/D5vSFDSCcSGODiQnc1UrAx++7QJdEzCUcGnTh/Nk6y686Bmr2J7hf9+j6D63K
 t9M/jKa4ga74JGruzwWS9wL9eqmuuMGuzvuHDWLWbTlMkH4oGSiBbrl9tS71oeLRkG6m
 wYOA==
X-Gm-Message-State: AOAM530kZaqMQ3MQmB2CGFSzlrTjq91y+9iqxwny5E4Vo3eGFP23GTEh
 5LH+iD4iuDb+/l9mZQ3TQZvAleqdJQbSpA==
X-Google-Smtp-Source: ABdhPJxVPpjcOiCGG9a4G4SfB4CX3Kj4946E+Lw1aEp+hto46yePuvQPiJXW6HP2Diw/rUFOHKJ5gg==
X-Received: by 2002:a17:90a:d510:: with SMTP id
 t16mr3290035pju.210.1598389195444; 
 Tue, 25 Aug 2020 13:59:55 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.13.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 13:59:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/77] tests/tcg: Do not require FE_TOWARDZERO
Date: Tue, 25 Aug 2020 13:58:35 -0700
Message-Id: <20200825205950.730499-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: edgar.iglesias@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is optional in ISO C, and not all cpus provide it.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/float_convs.c | 2 ++
 tests/tcg/multiarch/float_madds.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/tcg/multiarch/float_convs.c b/tests/tcg/multiarch/float_convs.c
index 47e24b8b16..e9be75c2d5 100644
--- a/tests/tcg/multiarch/float_convs.c
+++ b/tests/tcg/multiarch/float_convs.c
@@ -30,7 +30,9 @@ float_mapping round_flags[] = {
 #ifdef FE_DOWNWARD
     { FE_DOWNWARD, "downwards" },
 #endif
+#ifdef FE_TOWARDZERO
     { FE_TOWARDZERO, "to zero" }
+#endif
 };
 
 static void print_input(float input)
diff --git a/tests/tcg/multiarch/float_madds.c b/tests/tcg/multiarch/float_madds.c
index eceb4ae38b..e422608ccd 100644
--- a/tests/tcg/multiarch/float_madds.c
+++ b/tests/tcg/multiarch/float_madds.c
@@ -29,7 +29,9 @@ float_mapping round_flags[] = {
 #ifdef FE_DOWNWARD
     { FE_DOWNWARD, "downwards" },
 #endif
+#ifdef FE_TOWARDZERO
     { FE_TOWARDZERO, "to zero" }
+#endif
 };
 
 
-- 
2.25.1


