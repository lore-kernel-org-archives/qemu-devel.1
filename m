Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286DC2D0ED
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8861206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFqvlcxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8861206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYQH-0001Ej-1Q
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKN-0006wH-II
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKL-0001bT-EH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:07 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:39017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKL-0001as-A8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:05 -0400
Received: by mail-qk1-x743.google.com with SMTP id b62so8193688qkf.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KjBP9WZwlnczZ3SxEnPdyurMaB67UgSlf8Umf0tpZgo=;
 b=uFqvlcxooVEiTGNEsNcsRcXt5/VC1HstqJIHUqxEgyppf7yIbMNyrJInVP1QctuzPw
 63uX8s/uSWBSLH/So4Oed3318c0pAXxUPD7ebHDl/yXpnJJS41qaN8cjGkO1FOJzIKNW
 DPc9nXYY0iKKsyodj0FXRqrJ4PBx5DgVndwaxo1dlAe5NXFueUx1mjPH1L0OCUq66obg
 6E12viiSt/Uy1LXbd4NGpV0GtIXie9UP9YhIgV2vTEvEo4CaLwUNeXg5nCz+vNBoz/Sp
 9ehmsmSMvWRtC0kXAPNimTkPckoqnd/wdpRKQN3SizerFXKX0XEofCtoC9QSC8qku6sB
 2Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KjBP9WZwlnczZ3SxEnPdyurMaB67UgSlf8Umf0tpZgo=;
 b=WypUmJu4ic0eqUMAUSwl5lFPXGTSqx6fv+kXKDPPfZqYws9WIcK2phVCrNeSmHI8G+
 hbVKlXul1DYqvxHRb82sg3tEo40WVbkaEHLzOCxLz5VdrA9Yo+MyuPfsZ/tQd2RrJDo0
 l1xjGnlk6sP+FpFjvj5lQDxlvcVXEEG2ue+WZj+BbAmFZSLAzyK2BcyoQABfwdX4s4pJ
 gqzlr3wnB7DDxSHUU0a7LwjKbjAesEVqZlPNweJq/sWuPBmVyK3M4ve+nW3PMagXySt0
 AxDq2lHIAsVwZiOGU/+snzjiTpPb1/os0UZc9ffnFe2yaIrlGmZFGDcoT3oRvj1jSIXh
 xukw==
X-Gm-Message-State: ANhLgQ0N1b9bBKAin2iI85Qu0rZvfQfz7l8ef2Nfr9XPLgNBWhYWwtBW
 Jj6WCqV/3NFCu16+9Fjh4Hexf+f5KUncKw==
X-Google-Smtp-Source: ADFU+vtANT6goS5StLO/8gP1oOVpiOtjSlcNja9efNYcLEFWAWFP81dXHSl8Im2ka9iyqbHnDFB8dA==
X-Received: by 2002:a37:a505:: with SMTP id o5mr10355628qke.30.1585251483153; 
 Thu, 26 Mar 2020 12:38:03 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:01 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 22/74] lm32: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:04 -0400
Message-Id: <20200326193156.4322-23-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Michael Walle <michael@walle.cc>, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Michael Walle <michael@walle.cc>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/lm32/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index e39fcd5647..8e0bd57b9d 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -32,7 +32,7 @@ void HELPER(hlt)(CPULM32State *env)
 {
     CPUState *cs = env_cpu(env);
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     cpu_loop_exit(cs);
 }
@@ -45,7 +45,7 @@ void HELPER(ill)(CPULM32State *env)
             "Connect a debugger or switch to the monitor console "
             "to find out more.\n");
     vm_stop(RUN_STATE_PAUSED);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     raise_exception(env, EXCP_HALTED);
 #endif
 }
-- 
2.17.1


