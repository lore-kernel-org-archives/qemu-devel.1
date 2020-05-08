Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0388EC47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87A32173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NB2V41QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87A32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5BE-000859-UX
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pU-0004kk-Mj
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:24 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pT-0007I8-66
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id s20so858506plp.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Satlmvku/pHGor6xmZAkPC5FD5Q8goGXCeVbGvbx+tw=;
 b=NB2V41QMaUYgyy5+LQORYYXwax1Bq7vky0SwxoJr4i8PnpnbnMW/GvT/FGHuhpEMuO
 1uRW/VNsCchD9LXy1fbsJ0JPOBCEWltUJBYfd36t3U5vjM83Zj93gZA2YjoU3vw07ZEu
 nmA7O4LCsgnhvoClppU809tIkgI10uHkHHs8/CRZwvBczNjeUEQbGJvHcFbOaOgzXDp4
 cP/8JOy/pbIMnCyRpj4Fp22Uk3eAjKkF/ImvUsTb17auDbS7mA+s73ZjVgiWEfF98r6l
 mORMTukZq411JKDskOBmdkx8JqO6IhM3skIGDElndyLZtcZDzkqS7C6xslMlzYlR3gRM
 dI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Satlmvku/pHGor6xmZAkPC5FD5Q8goGXCeVbGvbx+tw=;
 b=iApy3mkRTjArKMoA/B7NR2UxkxqtKveGm4p7fGTpyK6y4GXJZh3XlHYP/xFuoQW5O7
 buNg+ScLt/bfXmIH/Dv1ePA5yU36kd+1SSb/9L2L25jifqEBGL13hCIFmP/vCTGYqIUx
 IZ7cjvHLvq27EH/kbqu4In7P+XWW+lIiYPN83doNTxeHvDFQEy6UCHh46vv9a6UI/p+Y
 SB+HAEeOLjxOOoPZg8Y0IURzqOmJJdDYcniUJxINuX342nafVc3U0wKLq6U/TvFALRyd
 kHr5xLXIkFHNZyQSwlOPrfYjkKXlnxUAJTQ8TMOvUwUBm5je/moP5VWeqZMu1oznE31L
 0RNw==
X-Gm-Message-State: AGi0PuYiA69KT/bw3yhZFns23HogrHvYo8WkCbysOAyybEO3gTivQHT2
 f9GOR3IKJb+noVfguJd3sVgFEwBasDo=
X-Google-Smtp-Source: APiQypItIA8cHCF4y3HKU/GN6fZdYjCSoLssT8g+6B5X9e4WVOkbDnyZYRfwsEmcdEy+appIugw0Ow==
X-Received: by 2002:a17:90a:fd94:: with SMTP id
 cx20mr6922796pjb.157.1588951341477; 
 Fri, 08 May 2020 08:22:21 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/16] target/arm: Clear tail in gvec_fmul_idx_*,
 gvec_fmla_idx_*
Date: Fri,  8 May 2020 08:21:58 -0700
Message-Id: <20200508152200.6547-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Must clear the tail for AdvSIMD when SVE is enabled.

Fixes: ca40a6e6e39
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vec_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 6aa2ca0827..a483841add 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -747,6 +747,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
             d[i + j] = TYPE##_mul(n[i + j], mm, stat);                     \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_MUL_IDX(gvec_fmul_idx_h, float16, H2)
@@ -771,6 +772,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                                      mm, a[i + j], 0, stat);               \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2)
-- 
2.20.1


