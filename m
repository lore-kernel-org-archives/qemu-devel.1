Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5836CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D2C217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RD4ciCcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D2C217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmPb-0003mb-E0
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmA8-0004iz-38
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:28:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:36657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmA3-0002Y1-0Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:28:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id j4so1914692plk.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7e8M8ic84VXGl26VraVqHK13nZ7Td4XreFuki7rY3nc=;
 b=RD4ciCcl46CugQHElWtxOsDymijcKjYDoncjVmfVP3hit2Vjx0htsVBMIt/2RWRa+l
 g2/IYf3FiBFmSXshXOUUKUct5kY/mQIPb2CnVWEzb4hfeytO+4mz2l+4akcXJxq2HfCR
 nBUX1HW5n6CSg+XfDLLIRbxerL69WYMqjyYn7zBfxnKWZWcqgSejQtRYz1pvHSAeKLj4
 3jAK8E93q4emGxz9xOextxflmXrAepkRWTOTkt/oWNqloy6zbLerlx3+v9/UdgvGRS9e
 YysfSYVKLvUnVpVEVUl98KBtfhU53KJRgQ/b4dFTJTLJugLcmwPBQwAJsiNEt1Z88m9j
 93iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7e8M8ic84VXGl26VraVqHK13nZ7Td4XreFuki7rY3nc=;
 b=iJ1DUHmppR87E12Net82ZbccxR7eLf9maTo8UnmLPvuxmjL6+LE6mbjn16+k6YNH4F
 JlHqV6ajcoBU1sP5i9odT/YbPomYXwXVjjKtW2031RR3nsREbXHxj1xC9JlfSrqY6z8o
 obTGNDAJet5Da3T5jYcKddRiq58H0SC37zgBsHekjFnz+oh6DlHscCSnqJcjHf74JJCH
 pzoScRdnURclCJLIVr7guLD+zC3UmYFjQAkYcrsDwJvPkW9rDlV/PN3DbStcvE4M+i2b
 PQXfb2HG9LxYXj2Y7aL8uSNyiRyx2ybV3OlklRf9RF7bL4x/BIMZfZEvjKytO35f/qW1
 oLjw==
X-Gm-Message-State: AOAM533uIh+wP50L6IF6HwdsrP7IR1l1M/Oj3s/ZUGNqbr3jNblj0MRf
 bZQhzZHbXfwPc9f8KF0AvLU9pZnpLkw=
X-Google-Smtp-Source: ABdhPJzpC4JDWqazsc8dAEfysUe1a+95YfVCUN3ECFOmA9kvhRHkAqwW/tVrqFYz32rQ05pGAxlEfg==
X-Received: by 2002:a17:902:aa0c:: with SMTP id
 be12mr2181716plb.45.1592454501353; 
 Wed, 17 Jun 2020 21:28:21 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l134sm1154412pga.50.2020.06.17.21.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:28:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 025/100] target/arm: Implement SVE2 integer add/subtract
 interleaved long
Date: Wed, 17 Jun 2020 21:25:29 -0700
Message-Id: <20200618042644.1685561-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      | 6 ++++++
 target/arm/translate-sve.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 84fc0ade2c..91e45f2d32 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1181,3 +1181,9 @@ SABDLB          01000101 .. 0 ..... 00 1100 ..... .....  @rd_rn_rm
 SABDLT          01000101 .. 0 ..... 00 1101 ..... .....  @rd_rn_rm
 UABDLB          01000101 .. 0 ..... 00 1110 ..... .....  @rd_rn_rm
 UABDLT          01000101 .. 0 ..... 00 1111 ..... .....  @rd_rn_rm
+
+## SVE2 integer add/subtract interleaved long
+
+SADDLBT         01000101 .. 0 ..... 1000 00 ..... .....  @rd_rn_rm
+SSUBLBT         01000101 .. 0 ..... 1000 10 ..... .....  @rd_rn_rm
+SSUBLTB         01000101 .. 0 ..... 1000 11 ..... .....  @rd_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 13b3ef1a2c..14508cab07 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5582,3 +5582,7 @@ DO_SVE2_ZZZ_TB(SABDLT, sabdl, true, true)
 DO_SVE2_ZZZ_TB(UADDLT, uaddl, true, true)
 DO_SVE2_ZZZ_TB(USUBLT, usubl, true, true)
 DO_SVE2_ZZZ_TB(UABDLT, uabdl, true, true)
+
+DO_SVE2_ZZZ_TB(SADDLBT, saddl, false, true)
+DO_SVE2_ZZZ_TB(SSUBLBT, ssubl, false, true)
+DO_SVE2_ZZZ_TB(SSUBLTB, ssubl, true, false)
-- 
2.25.1


