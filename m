Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8AE320671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1qai1NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AE320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEee-0001ma-Qp
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEch-0007Eb-Kt
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:07 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:33388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcg-0003lN-UH
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:07 -0400
Received: by mail-lf1-x12d.google.com with SMTP id z22so2806244lfd.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1PhlQHMBIBZyhaIVdNeOmpiXX6PbldkHvHxVIsbvZwc=;
 b=E1qai1NJLvdh6rguS0SM/8QbbjRIzvPX+fJFDUh1V03wPnHAzDUXDkBZWDPW5paO9+
 CIWG+DVWatL9DJjksyppeThBa/PbDj2OJ8agLhL9rIop18mvddgnAgn/1YLuK9g3oc0H
 KCQUMIXIGRU/e/KyFBYUQF1dlCEc2tKxLuRK9xDXd915g0VdPjUHO9mH0UO39/FgkcpD
 7ggJOAeEsvcfTEsvjlqpYyFgL3ATsO9VPm5z3ZoB/38gOxuzavqkpDNDaDwqBMWmI4UL
 A667xHgxQzM2SS66rgchhs/L7r8R/t/2Td1gIgAcTVD0tq3PxqTKaViE8kTL3d2iyiUM
 fhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1PhlQHMBIBZyhaIVdNeOmpiXX6PbldkHvHxVIsbvZwc=;
 b=RI59c+RgeSUPqa8dHWhxXZMt7A+/ptFGItF0ikfviyYmDRCAvIGYdhRBDMj9UcSUJH
 7OgUEyhp7EJSS5ZUOzqSJr9fQPTE8VJtXzgj6KCfNm0Eq0F+6TegVMESNQbESKVX7XL4
 KVP6Ugrl4rD4ORVIfcIGQ6A57bFLpPGAm+kPPaX0mK8Ygu/xsXmNTonbFzhMZIFnAkZx
 fpwfyNx++9WEARm/iBdms+qujHwaGO2RT+3PhwKqf9jRXkR4aAw23DgPbNE/IHePT7jv
 emFmKfsHGXaHdGezkqD8bKBzSuk3SKrhj4Up1BB+f6Qbf75+IgBG1jz1tnmXkqe8ZZAE
 DJvg==
X-Gm-Message-State: AOAM533knGv4VFV/20UvQ6tcz4zNEHFE7OApb5UMCdIyHUCO3UNUL+RU
 Ax++4K2pfZ6pyG9KV1/0OsMF/EoEo5M=
X-Google-Smtp-Source: ABdhPJx61lXYooqthv1DVwyn+D+vQxgeA54AujYJpCrFVA0ZMuS2ByV/C4+s5DhM7DpvGQRLZGPVgw==
X-Received: by 2002:ac2:599e:: with SMTP id w30mr2757177lfn.188.1589465644922; 
 Thu, 14 May 2020 07:14:04 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id d9sm1917486lfa.77.2020.05.14.07.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:04 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 01/14] hw/net/xilinx_axienet: Auto-clear PHY Autoneg
Date: Thu, 14 May 2020 16:13:49 +0200
Message-Id: <20200514141402.12498-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Auto-clear PHY CR Autoneg bits. This makes this model
work with recent Linux kernels.

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20200506082513.18751-2-edgar.iglesias@gmail.com>
---
 hw/net/xilinx_axienet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 704788811a..0f97510d8a 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -149,8 +149,8 @@ tdk_write(struct PHY *phy, unsigned int req, unsigned int data)
             break;
     }
 
-    /* Unconditionally clear regs[BMCR][BMCR_RESET] */
-    phy->regs[0] &= ~0x8000;
+    /* Unconditionally clear regs[BMCR][BMCR_RESET] and auto-neg */
+    phy->regs[0] &= ~0x8200;
 }
 
 static void
-- 
2.20.1


