Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0494C4742C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2D220729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWN4lVou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2D220729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasau-00034M-2m
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRs-0005Pq-2p
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:00 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRq-00073g-DX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:59 -0500
Received: by mail-pg1-x543.google.com with SMTP id 62so2859345pgg.12
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UM21CD1mNWN7mJCqUB/udHXRZq9uSUYW+rGuZNQcpWU=;
 b=mWN4lVou6WXoGKcq3p7fbPc6jIhkoS5I3k1g4rfo41b8DG9GYUmtR7LustisERj0PC
 f8tO7MZLvWkfmRUROWILIjfnDoDOiIF8vSViuG9XEZsjBg0Ei/Xe5/P22kOehKmPH1+A
 PJSQWauqbzhb2VG3EAKTM5toZq2U0dfVq3wDrANw25eIFFcvS/38MAAUBYt5GWPaxXWh
 KpfjFIAlIQPivuPEUztGP2uDVmKqGFIx4VIBdbazP6gZz+D6InT/+MqCxvgbCXNmytS/
 IBjQpumlFzt6lJocQukUcrZsi/u99na3Kyi0G0zSYloJAqFB0e0EhnUxUaJG3sZpxe9t
 uEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UM21CD1mNWN7mJCqUB/udHXRZq9uSUYW+rGuZNQcpWU=;
 b=k2AdQShZG+5FMUt0yEWnDvZzlm8GAq51lNvaj/s/iSB90pTAynZ70pY83T/Pkg1cC8
 ykJyHLrG35CbtDxLrmEyvX3LE9QAWwxINW1CIAKPBqgInwq5Z19lhnhgWfjBxEuAP9AL
 eC5aRNtUKujcpwDR9xSpyh5aRgDOD7bwr6WAN8YEgwJmQmz2txJZupb0VjKYbZAhF4x/
 LLtPNG/47wSi4uCSWAvfe0Mnx/tFPFc/m/hpZ66BVmFTxvfSt5kurFcQvpVzVk79mhQX
 S31K/Iel85sH3udfGfHNcMAPLjVdA2PxHLCTIW9svrPIrfBQD/mRl4YdC8JTbhHui+II
 ANKg==
X-Gm-Message-State: AOAM530rbCeCgc8s1UUTugUVG8YO2S4m5Hy7+T4nPDSsj7woXzkbk0Y1
 CNGF+FQH+UEA3nhb6bHwy8wpmcvkQ2s1dQ==
X-Google-Smtp-Source: ABdhPJzGVn8gGyy5bmTTCNO9XzcyM32F2d/pqpd95f1KExqexBK+E3Gfc5Yz4IlVS2j36StrIFukIw==
X-Received: by 2002:a62:1408:0:b029:18b:78d:4c4b with SMTP id
 8-20020a6214080000b029018b078d4c4bmr105881pfu.25.1604633396758; 
 Thu, 05 Nov 2020 19:29:56 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/41] tcg: Introduce tcg_tbrel_diff
Date: Thu,  5 Nov 2020 19:29:04 -0800
Message-Id: <20201106032921.600200-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 67d57695c2..90ec7c1445 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1141,6 +1141,19 @@ static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_ptr));
 }
 
+/**
+ * tcg_tbrel_diff
+ * @s: the tcg context
+ * @target: address of the target
+ *
+ * Produce a difference, from the beginning of the current TB code
+ * to the destination address.
+ */
+static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
+{
+    return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_buf));
+}
+
 /**
  * tcg_current_code_size
  * @s: the tcg context
-- 
2.25.1


