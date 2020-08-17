Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2330C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FC820748
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf2yhCXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FC820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fkO-0007tL-2V
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fhy-0003JC-TZ; Mon, 17 Aug 2020 10:01:55 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:44239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fht-0001W7-Lj; Mon, 17 Aug 2020 10:01:54 -0400
Received: by mail-lf1-x141.google.com with SMTP id x24so8402227lfe.11;
 Mon, 17 Aug 2020 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hCmudOOZ9aY/+riJSRrIyYnafB9XQ90ekRagFJVmQlU=;
 b=hf2yhCXzMnvAgLqxwWgyoQdxFSr7Py3jsCEWqkKTqVnoXZnMjJXne5E4r103GtTsuY
 +DFSQiAm5KbvivHnpYgVRwh58vNkggpc3GGjqZrqOdCzkZke8uOz/5Cx8msai8rN0moS
 V6jZo+9hYZOW/uIoa1ekWTnD/qj7DEKwR03q6DMijewOAu4/k7TWBx2Sa6XoLTP8Mrez
 EjlCAzMCetxkJXQcNX3HJiXIE+JL/yk1wl1tq8gLhXYVgnvniPKA6rQvSn1+3+2+D1S9
 iNqX1VkNzJht2kHPJXCd6WgELer4VVzRoIYSZpMty3BtMFP01igNX1grsSK8lxFsfkSv
 qdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hCmudOOZ9aY/+riJSRrIyYnafB9XQ90ekRagFJVmQlU=;
 b=kWK7Ie7AxOLaorw219i0mtrjAyy4eBWWkjo/xxQ+g/kn5dYTPQGHIiyBzpNAcdUbs/
 rfH3Nj8ISmk+vc8wEw1TFXrQ1zNOtclmdpBb+NYVFLOWBc1W9CJ44yl4P+xRZ0DHsbLf
 5tIJ+eubk0Vf7cnvjLkd7EaHVgyMBnneXYGcmXJkwBoXNdATTeMcEqJabVzvpf4nH3l5
 UpN7avfLtVG2fuat0jeCgKTpF03JK+CrwqkfZY0LDtvDcQnlYXUzFfbyJ8OtE9J+xnkg
 NCiB4jhH4qOfIkzl/7J7zvjFDdVS6vldBYhFJOC26vO8H1ppgGlbwVUAG9gl/qkQhUu6
 rHRg==
X-Gm-Message-State: AOAM532SKRtBR41mHOaVjJG99EkEIniuThI3YDWDDX8kKrBIksFowlTJ
 kr8NqQtE0d2buq25qu3RDbshJaEjkfr6IG58
X-Google-Smtp-Source: ABdhPJxoxwvUMAXqMz5OdfMeYlbDMbtYIjn2xZ33uaN/rkhpAftw7FvIZFUbjFSMDC+3PeWHqjUj6A==
X-Received: by 2002:a19:414b:: with SMTP id o72mr7588320lfa.86.1597672907372; 
 Mon, 17 Aug 2020 07:01:47 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q189sm5013030ljq.68.2020.08.17.07.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:01:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] target/microblaze: mbar: Transfer dc->rd to mbar_imm
Date: Mon, 17 Aug 2020 16:01:40 +0200
Message-Id: <20200817140144.373403-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817140144.373403-1-edgar.iglesias@gmail.com>
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Transfer dc->rd to mbar_imm to improve the readability when
comparing to the specs.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index f6ff2591c3..47637f152b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1229,8 +1229,10 @@ static void dec_br(DisasContext *dc)
     /* Memory barrier.  */
     mbar = (dc->ir >> 16) & 31;
     if (mbar == 2 && dc->imm == 4) {
+        uint16_t mbar_imm = dc->rd;
+
         /* mbar IMM & 16 decodes to sleep.  */
-        if (dc->rd & 16) {
+        if (mbar_imm & 16) {
             TCGv_i32 tmp_hlt = tcg_const_i32(EXCP_HLT);
             TCGv_i32 tmp_1 = tcg_const_i32(1);
 
@@ -1246,7 +1248,7 @@ static void dec_br(DisasContext *dc)
             tcg_temp_free_i32(tmp_1);
             return;
         }
-        LOG_DIS("mbar %d\n", dc->rd);
+        LOG_DIS("mbar %d\n", mbar_imm);
         /* Break the TB.  */
         dc->cpustate_changed = 1;
         return;
-- 
2.25.1


