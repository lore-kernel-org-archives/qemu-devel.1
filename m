Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BEAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDC82065D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHu6zi3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDC82065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuQI-0006Lh-I4
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJT-0003d7-N4
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:32:55 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJS-000206-Mb
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:32:55 -0400
Received: by mail-pj1-x1044.google.com with SMTP id e6so11215539pjt.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2WJ6plpfPlfef610n9KhYRt52HX2ijIyS18DrRrsIPs=;
 b=yHu6zi3v58tBaVlgx8pCuRGdfufTf/Nf0iEz1oczi01XRLJgh0KxCS4r8UW/sZRvU8
 6TLIjCDJVaUf7qJAWux4U3jhowBNP8C0+sH55PV8fagWm8DmeVmS0cqU1mGXsytaF4mt
 8+6PrU5rdaQWoA/AlBru3wLHfb/lbQqiw+oFmHsAK6oFQfQ57Lf8wqlzxNsBHAiM8tKl
 4F8Ijqpl+wBzjuaI2wqPMP2TfY/Irg0oSRItTGnQEARow3FRUKeXkoH3hCCfgXXVJGGm
 xNuePPAt5dfkEHNSWXjQloM9tjppbrfC9CTOIgwt38aX601NLJnDqp2lNE8hL3Mrh5YY
 02/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2WJ6plpfPlfef610n9KhYRt52HX2ijIyS18DrRrsIPs=;
 b=b+Xae/4ut9hpb7l+JDcpJywyGkeHHibqFWDgmL/66oNV/lWk/7wr/2hQQ5k7cs4+mo
 5m3djqBC7SQhrxg8dewSP++xbSdUPapSNEDTqa2nLnS6/Pb3RzqMF3111BK2fhVVQ5IT
 rpP3XlJMIdXC2LdxBUIvMRIKRAf7sF3p0XaODWcW1AE3vQuPQ26NWxgRTYPNAeYFIgpr
 pRrjUtxnNOmn4LGOq8zz58VBz1ih2Cx3ceM9WtHsyQRCSjzohqokvNchxJUd56z8/n3w
 Z4v0B3FK/CFYnoXMYo55WaL0K1aJFDZUDh9sQfUJV9jv4pqQRIShevy4DcFuH5fy8YLr
 2Chw==
X-Gm-Message-State: AOAM533YWSwbyjGWmUMrF7YdjR7GtC/r9ZO2xYziGm1K5CWgr2T4Au0o
 p6nU/w1koaS0OPdsuB9JcmNyKBf9vy4=
X-Google-Smtp-Source: ABdhPJzYtv8yvUdiBqq3u1TVQ5uUscwlDOA0nBsIv+P6GgaUXBMFrq4hDI5k61NU9amNHeyu0zUoCg==
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr70073pln.38.1589387573009; 
 Wed, 13 May 2020 09:32:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b11sm158025pgq.50.2020.05.13.09.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 09:32:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/16] target/arm: Remove unnecessary range check for VSHL
Date: Wed, 13 May 2020 09:32:33 -0700
Message-Id: <20200513163245.17915-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
References: <20200513163245.17915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

In 1dc8425e551, while converting to gvec, I added an extra range check
against the shift count.  This was unnecessary because the encoding of
the shift count produces 0 to the element size - 1.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3c489852dc..2eec689c5e 100644
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


