Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E606E21927
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUveLQWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E606E21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWvW-0000mI-QS
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrv-0004B2-1I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:07 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrs-0005y5-Cf
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:06 -0400
Received: by mail-wr1-x42c.google.com with SMTP id w5so6835368wrp.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=15TOMWdMbV0LEopJFhIt4fA//f4P0yQsJTt3fedk460=;
 b=vUveLQWW+sygA6daERBU++h/VL1X77e//KmVsbL/lgu3082A7FN1z3G+E2kvnUjD2Z
 LvT+3s/B60nn1u1rtwm5Mh2KFOd8/0eESGbhN4rr5ibo6IC9C2jIXnlm7yt/n2cHWkBP
 JXfJtFD+L7wHVPq2q+MVoOtt15SEpzUjXDHJV6dXCMgefmLjCkqJ2wUy36E52dvcIL2u
 AGKQDHJcGdrDgXraZJpmc3N/JiVH+YkbT0JYAwUd829OCYq0wbUfMSssJQDUqQbGPatv
 4MWKdwDCiwO2CzZZj5F6yEozXmKokVRU0dVppa8XCPoa43YTBYQpytlS45Np5O8+q2o0
 kwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=15TOMWdMbV0LEopJFhIt4fA//f4P0yQsJTt3fedk460=;
 b=n0eJnB1DySZG9ard4pKcl3YN+SZIIM9yG3XmnsTvBHYfq/Qkegm06qN5V/WrJlHFQB
 QnmVNboz+lNXyZVb7w3usEMNx7eqVos93exbRDi0YZk0qUw6T2NpiCXmz0C+wre1VxIi
 pht9ehwcc5IC8dh6LMhNoJu3Pra62x9HBtxAQb/5wVQGDBRRUSGAzm8mApm/KLBoHgW+
 YjQvK/ueYTzAAiq9nK/nRevMOqRWm47OM3CnWG0RG7k/KwkS6b+iymN4bQelR4apIDoX
 1Lbzx62ZuIyq70DGP0khK/6Ttr35yow8eSb90v0o/RM4qaPKH+7vH8SxJupNm1WtJZUk
 I0lA==
X-Gm-Message-State: AOAM530g15e5XLUqchy8Q87ciKsVWFRJSsac0WfF5lgzJYQPUsqOVRR6
 LUPZyYgE3meyilOdHRYPvzWeWqScflcTa14X
X-Google-Smtp-Source: ABdhPJxD6iyXzxcUFdZj2VTJX3ZpMKIgmx1c4dSGEAEyFPyFsa/CpF5P/oPzCcwjhRJTKkELd4dqNg==
X-Received: by 2002:adf:9ec2:: with SMTP id b2mr9798466wrf.107.1602167162690; 
 Thu, 08 Oct 2020 07:26:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] hw/arm/fsl-imx25: Fix a typo
Date: Thu,  8 Oct 2020 15:25:47 +0100
Message-Id: <20201008142557.9845-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201002080935.1660005-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx25.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 971f35dd161..c1603b2ac21 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -179,7 +179,7 @@ struct FslIMX25State {
  * 0xBB00_0000 0xBB00_0FFF 4 Kbytes     NAND flash main area buffer
  * 0xBB00_1000 0xBB00_11FF 512 B        NAND flash spare area buffer
  * 0xBB00_1200 0xBB00_1DFF 3 Kbytes     Reserved
- * 0xBB00_1E00 0xBB00_1FFF 512 B        NAND flash control regisers
+ * 0xBB00_1E00 0xBB00_1FFF 512 B        NAND flash control registers
  * 0xBB01_2000 0xBFFF_FFFF 96 Mbytes (minus 8 Kbytes) Reserved
  * 0xC000_0000 0xFFFF_FFFF 1024 Mbytes  Reserved
  */
-- 
2.20.1


