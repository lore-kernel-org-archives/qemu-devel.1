Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF297C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8734B20693
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eq2G/QjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8734B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmmU-00062d-J3
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLS-0006sj-R1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:46 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLR-0006Bh-3m
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:46 -0400
Received: by mail-pl1-x642.google.com with SMTP id k13so3225923plk.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NFMrG515781fPkhuV8GqRES+jyHXpSFNJfiQ1prWFi4=;
 b=Eq2G/QjMwh1Lud9/DfzphAKW/OOoMT9096Ls4XhI0plD82Ti/L9FE6SxHlUEzXllmo
 OAZqmCFsmiFpU3PTjLwvduWtSMh4gxca9SPyA6Qastx2hZgkgFF2KO03ybOMCKxNO+xM
 w4hQ/YaBPYADuNKL962McDeBV9+bnNjt4V8R7uGv3uUWNL8GZgPVu7SgAzSPV41fdDP2
 LDs69udQczV0lIic5dEWKggEE4cWkd/G+Nt5tkYHz6rjueBbQcX1a1oQxB9+epP3YOwF
 TXMQCgd+7UQOzrljVY4co3dQbGKuB4kdxw0whpm3FRIYBdS6OJ6XmnAE+9DlKMiVHa74
 0vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NFMrG515781fPkhuV8GqRES+jyHXpSFNJfiQ1prWFi4=;
 b=nUS0oTFDaWVNTH52Ut4x5kmKD+u84mVX37HmZnLzyhSVess2SAaAy/KveS4RjHqbNy
 RLvSpt1erv9KFyM4YqgeOZiE3QssikgEUH2qlkeuS24pamwqq9nTuKThvyOdCCdwMg0i
 waQC4pXcifd3UpAJn4IE0J98c7x4FhptEzfKHHBP5/Jg9KPRecbMb7v4KAyMRuQJnzj6
 UC/TnGMVRPqbINnxiQdxlCh4ta5Xam7imabZBAtoGkCSHuMK+cnym5GT1DUFcO1QOneO
 X/sk666TX7Jx6fOGcfM3Wg8Ki4JLPYaHyTJDopo6tLQQ2C1nKy0DTGXt1mJVCHCL9Mo/
 a5jw==
X-Gm-Message-State: AOAM5308vdKXFhVTXNpDFeqe5+79L7PdVm8YF7fzAOarw9ROx67W/zH1
 YSevufG6bav+ofiR6tBl7KSjF4v5RqnLmA==
X-Google-Smtp-Source: ABdhPJwQnPRqEYc24API2DgEvxKw9MmSElFjqQ5Tm1LLagQjvxcSIPH7SzbHM+hq906YM/LH42pjVg==
X-Received: by 2002:a17:90a:2b88:: with SMTP id u8mr76295pjd.37.1598890063437; 
 Mon, 31 Aug 2020 09:07:43 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 74/76] target/microblaze: Remove cpu_R[0]
Date: Mon, 31 Aug 2020 09:05:59 -0700
Message-Id: <20200831160601.833692-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not initialize cpu_R[0], as this should be totally unused.
The cpu_for_read and cpu_for_write functions use a local temp.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8f69ca50b2..8c287457a9 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1842,7 +1842,13 @@ void mb_tcg_init(void)
     static const struct {
         TCGv_i32 *var; int ofs; char name[8];
     } i32s[] = {
-        R(0),  R(1),  R(2),  R(3),  R(4),  R(5),  R(6),  R(7),
+        /*
+         * Note that r0 is handled specially in reg_for_read
+         * and reg_for_write.  Nothing should touch cpu_R[0].
+         * Leave that element NULL, which will assert quickly
+         * inside the tcg generator functions.
+         */
+               R(1),  R(2),  R(3),  R(4),  R(5),  R(6),  R(7),
         R(8),  R(9),  R(10), R(11), R(12), R(13), R(14), R(15),
         R(16), R(17), R(18), R(19), R(20), R(21), R(22), R(23),
         R(24), R(25), R(26), R(27), R(28), R(29), R(30), R(31),
-- 
2.25.1


