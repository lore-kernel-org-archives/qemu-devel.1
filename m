Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDA4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11B12074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5fcyUrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11B12074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Df-0003hU-2U
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ar-00070I-Hx
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ap-0006Qg-SC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:09 -0400
Received: by mail-wr1-x436.google.com with SMTP id l2so4115583wrc.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PRLfK+qPAC6gSDd74XPBGh+NxN06ki9WKWBJWChAWs0=;
 b=z5fcyUrLACUZTWdlc4vMHpSStzN3FIcdIAMod3h5V4Cmtcd2iPCVN7uM+OedNYAGya
 qiERAyWYLM+eb9Wa/6W6jMX1oLUf2+WUCy22QYtvsPH3TFQhCvbrEQHzUO7v11thLVNL
 eMcnVSuwfL+b9QYwM6rsTXZ/GrFf12EYH59dFChKwiPomKV1CxVCJG+HqXq/E5E77s1x
 ydQ8SKofD97L//1aJKrmFyHG0u6x1dvnZr11PdviM71FC4DRVf8wFiDEmn3KRVrKQ6u5
 Oo7QwwpzzmU1oGiwHEfZY0vK+3G4rj7fycOZQcdaLrj7rPQjloqPX81U36wvtRh/Ikh8
 9V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PRLfK+qPAC6gSDd74XPBGh+NxN06ki9WKWBJWChAWs0=;
 b=S467ZN5fWB0QmeX4xMR2oaD64uU+GZM+SsAk85b5k1NXqejQWA6jQgbLYaRqVBiUq9
 ba2B504I07mK6U6AZ5pHegF3v5r+gC8r8vrXsY418o1YFiIJCIDLt6DD4izxwkfW5tIE
 vO+lhKGzTZvzJN0RdMLMtY4nQ4ZWCe+KjWLWWokmYJ5dIvrJklLZcW3z1fg8bZslfZ8L
 I5WQCoZGPT0tUGGe+UVNHZDotw0ApNXhdtPt1T6474txsBe9P9JmeBEQ7RBCH+9jkclc
 AroH5TnQUS5KXmiZ/KQvXMlWEIBXtSeOJLCsm2dkHHNCrpr5rRF3v/OdnUOyr7iQv80v
 gNwQ==
X-Gm-Message-State: AOAM532pBYfZFcLOdFsWUdEAAXY94HjB8E/vKh0XC9RW5dlerlWcm7wh
 R7ZyodLCgcqmtKTNhcuDxNHLEg==
X-Google-Smtp-Source: ABdhPJy7KGkGQOLMdN5ycsanaSFDtnBwd55EsSTwoyF4XV29RlB91vBt1hCdctbtwdl2y1jwrSgcWA==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr19243983wru.1.1595852646497; 
 Mon, 27 Jul 2020 05:24:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 128sm1890066wmz.43.2020.07.27.05.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:24:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA0F61FF92;
 Mon, 27 Jul 2020 13:23:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/16] accel/tcg: better handle memory constrained systems
Date: Mon, 27 Jul 2020 13:23:47 +0100
Message-Id: <20200727122357.31263-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: Robert Foley <robert.foley@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It turns out there are some 64 bit systems that have relatively low
amounts of physical memory available to them (typically CI system).
Even with swapping available a 1GB translation buffer that fills up
can put the machine under increased memory pressure. Detect these low
memory situations and reduce tb_size appropriately.

Fixes: 600e17b2615 ("accel/tcg: increase default code gen buffer size for 64 bit")
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Message-Id: <20200724064509.331-7-alex.bennee@linaro.org>

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2afa46bd2b1..2d83013633b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
-        tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        size_t phys_mem = qemu_get_host_physmem();
+        if (phys_mem == 0) {
+            tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        } else {
+            tb_size = MIN(DEFAULT_CODE_GEN_BUFFER_SIZE, phys_mem / 8);
+        }
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;
-- 
2.20.1


