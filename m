Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A9CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC552070A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsgLtBv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC552070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEwZ-0002XJ-7n
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkA-0002v6-I5
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEk9-0005Qj-NX
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id y16so4392980wrs.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VujTw+p8ldleMJAla0UUCCtvQHPUZGUi0dUrbSjbmM0=;
 b=tsgLtBv8JoRcrggJG2YU6Z62fpw2VjkYLCz+rZ65qJbt1lSjK7mtclRnRFL1v0WzWY
 KnT6BqCvL9ANCXQ5rzXMQur8xZ5mpwBYf6eEWv5DXxJYPpJtUMnYwdj7+6YUEIGbIv3+
 yVu4ap8+ZNhnigbQynOXy9LKAvvUkhGohSdliY8KN65/wdAbkcBJ95Hyya/vQIFVIkrj
 hXmZRLYjrf+IyFBqEOW9afWf4Diqu3WL+OApKwMWGc1zFZMWQq5RNLp3nFAqMbXdfFH/
 G/leFddaiooOLxjk40sObbLnenmpllYU9aFn4vZr5s6B4I+JKW/cm+LUtRk5b/osq4OD
 Y+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VujTw+p8ldleMJAla0UUCCtvQHPUZGUi0dUrbSjbmM0=;
 b=g3coF6R2m3Wf21lf6vsHNFbWZzrtXt94F09yKvhWSfTi1UjLdy37OvUh6zlar2RNeB
 2DGsO3spuWLN2ekcmCulkV1ayXF7sgN6B6bO1hHQ8x8Xuz2q6S7wnyR0n11bDml5hfmX
 qDo0HzrxVwLUUQFoJF59qxzXnu314WfhmZSjy3B/upAAxXf7h9FDSe7BZFmxziknb7zl
 6Qxeut40/rtgzAH/dWv3pV6q7hpkvt/qEVrkoS5Y+AN5fZONuSJWh5L54NtSAykIOcVR
 jYyAzN9jzJJm/HmroVDfq13Lvl9/AvU6GtOu1hGclmW3PjCBFUTL5z3/oeZpoKDy2SIx
 Rjbg==
X-Gm-Message-State: AOAM5316uoZP7oIuryr3/YKmZA6moJxp87paQU28Mnv9HqMMRYk+NufF
 WGiH8gLxOvj9/RNnjnhSvI8fwm5IQ3Ekgw==
X-Google-Smtp-Source: ABdhPJxXyk4NJHdz1g5ddshk/fMRDY+HxFUWzMtMCI/M1y8VSldzaMBZctpJ2CEY615RVXxCiedjZQ==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr5864408wrq.121.1589466108079; 
 Thu, 14 May 2020 07:21:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/45] target/arm: Remove unnecessary range check for VSHL
Date: Thu, 14 May 2020 15:20:58 +0100
Message-Id: <20200514142138.20875-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

In 1dc8425e551, while converting to gvec, I added an extra range check
against the shift count.  This was unnecessary because the encoding of
the shift count produces 0 to the element size - 1.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3c489852dce..2eec689c5ed 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5752,16 +5752,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         gen_gvec_sli(size, rd_ofs, rm_ofs, shift,
                                      vec_size, vec_size);
                     } else { /* VSHL */
-                        /* Shifts larger than the element size are
-                         * architecturally valid and results in zero.
-                         */
-                        if (shift >= 8 << size) {
-                            tcg_gen_gvec_dup_imm(size, rd_ofs,
-                                                 vec_size, vec_size, 0);
-                        } else {
-                            tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
-                                              vec_size, vec_size);
-                        }
+                        tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
+                                          vec_size, vec_size);
                     }
                     return 0;
                 }
-- 
2.20.1


