Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27596C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80982063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="chlyxwyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80982063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bCj-0001kW-7p
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asU-0001yv-PE
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:42376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asS-0005EX-2g
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:26 -0400
Received: by mail-pl1-x636.google.com with SMTP id f5so7158283plr.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hydI740Zf/8EsRb0a02832++22NPxTc0ZDr0nHkfk50=;
 b=chlyxwySJ+/EfDUWqIRKC5BjUX3+hmAvOPFORhOgjzuOpJ/LibCqoYivD19ok0xxVV
 On+wsuSAiyx8VbNjIN7WMPWQI3AWQZbZZpXWW/gdJm4Z9QFwO+uymp9gQmWQSVmINJgO
 LDc54TMzzLmohkBUy8hSSKCx4Kw03UR/ZVJFw30VwmGmLtvSE3wBsUuCO1uRM9y2PRuf
 Z4rstQ8t8xihXSeGp+/9HRk+lYhTqCshXiKB3lKfBLjOcO8bb2gKzhsoHv8Vm5u+O7PI
 5+f5yrRkEyler5O58KqFMkAfTvSO8gGC+RWCbtoU7waqqD+3gKNo0b4fn4RRiL/QKeaE
 yaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hydI740Zf/8EsRb0a02832++22NPxTc0ZDr0nHkfk50=;
 b=M9RRaJHNxMXGmXQad6BYMhCv1VvskYAFc2rm/kC+wMGjJlDRzz0jBO78uxEodA5j78
 Wa5/0+jAIra5x7iKoUvHwNQkT9lZH6qSkml0ofQwNBq5rejuB+NWF9GutejJyK/brT8w
 ksd5SHmsAk6viTfX+ZyprtG1o+vcLQkwgll6MGj+3J9NqwRblml0Yo9ykD4+JP5nrrU6
 NE+mnVdKigxYD+kV3n6/gWvKQsOYQFTVKxUBE8bfWRMjm45y4zzeYNeUZ9eKkAnL78EE
 O+Ier5FlmWE/tOh3rgvblPVK1pfBY5S4Zq32txy6Y3YqutcaGeG30kEixf+j/lTYWncR
 bDQw==
X-Gm-Message-State: AOAM532B7XQysUBgxMxrPSgV8a2GEwvOtoa4fiuKQBG5tND5gPrNL6mX
 CDYfChyqbJydoIo/drU/UElGRMO9osIcMQ==
X-Google-Smtp-Source: ABdhPJzPRMnwLYQkPK2vSnLv/8YjdgagyRbaa5PkUzQfyqto55egMpDpr0XR4MMyr9iSH2AvFcx73Q==
X-Received: by 2002:a17:902:d30b:: with SMTP id
 b11mr10465868plc.107.1597654342246; 
 Mon, 17 Aug 2020 01:52:22 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:21 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 49/70] target/riscv: use softfloat lib float16 comparison
 functions
Date: Mon, 17 Aug 2020 16:49:34 +0800
Message-Id: <20200817084955.28793-50-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f80c13b0857..e6441f18465 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3980,12 +3980,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     }                                                         \
 }
 
-static bool float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare_quiet(a, b, s);
-    return compare == float_relation_equal;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
@@ -4041,12 +4035,6 @@ GEN_VEXT_CMP_VF(vmfne_vf_h, uint16_t, H2, vmfne16)
 GEN_VEXT_CMP_VF(vmfne_vf_w, uint32_t, H4, vmfne32)
 GEN_VEXT_CMP_VF(vmfne_vf_d, uint64_t, H8, vmfne64)
 
-static bool float16_lt(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare(a, b, s);
-    return compare == float_relation_less;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_h, uint16_t, H2, float16_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_w, uint32_t, H4, float32_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_d, uint64_t, H8, float64_lt)
@@ -4054,13 +4042,6 @@ GEN_VEXT_CMP_VF(vmflt_vf_h, uint16_t, H2, float16_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_w, uint32_t, H4, float32_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_d, uint64_t, H8, float64_lt)
 
-static bool float16_le(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare(a, b, s);
-    return compare == float_relation_less ||
-           compare == float_relation_equal;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_h, uint16_t, H2, float16_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_w, uint32_t, H4, float32_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_d, uint64_t, H8, float64_le)
-- 
2.17.1


