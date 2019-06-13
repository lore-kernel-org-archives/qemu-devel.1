Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EEEC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2156721744
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBBy6Nq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2156721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbP3k-0007Ss-EC
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOd9-0007ut-TA
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOd4-00046q-Vq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcz-0003yc-Pm
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so20482716wrw.13
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZhjXNJSJoB8D/a7FDJ2SYoWWjcFDVf6Du9Vt4AtT2SM=;
 b=pBBy6Nq4jA6qSsB0H+Z5oLcxsqrI+1BxbnePD41XiExzkxOFtplE9kTOigpI2FRTk8
 dN8m2Qn9LKY2RQ1Q6CVkxTCJbjPtb3Xm2rDrbyhEVj5fUQu8yLtJN2FNfYl0kxROskyS
 omwEBV7bTVU6ZcvI/0I93yqEDULMAaRPwsDhNtz/beFS/CYPALjLx44hUXWnPYrRipLF
 wpFeBDJBSMO1MSBBQ1lHKqMRB78hE+k/DnP1RMJKWmSgnm423AVx2fI+ne372iXR7oav
 7L63uWbx1h1Acube7Q324lb0lTTiZCJFORcv9sThE1F18CbR2qaUzfbVPhz8MUidjNtL
 UGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZhjXNJSJoB8D/a7FDJ2SYoWWjcFDVf6Du9Vt4AtT2SM=;
 b=rB36LrbhRkqHcadjHTZ0lnxub5OfMbvBM9SPNRJwDOGDVcMX6w6DCqT0Yu6W+1hljt
 YUn2yNF1PV5Jry9JRrGldiJeOtpwRKu941Ee7MCPdenx9bOyGn6Ykk6IW4An42LAzM1q
 6/xT64rXmssaqudPv0Bq49w0cxk/sJ6Qa3zO1BhoV9ig7BveLRX91IOWe7WMaXG/cFEp
 ZkC/SKWEsrwh0dn38uh/tiCCihzi5ExC4hRV41PRkSe67gbAKSdWpiXJVP8eOgLThbey
 jz+PC3VzZRKrx58ECO1fUZvwYq1vce6HKhfOsLPR1Xm5E9LOed2DtsnWm1OxdhfEk9Ub
 ueIw==
X-Gm-Message-State: APjAAAVw3hH0XXHp7DTvkzFHx5Lrue1HGwyCXJ6ReAYkG3LzJQpwP83D
 T8iVEJvL0yD1a116JfVNdDbC+UxlunC8/A==
X-Google-Smtp-Source: APXvYqz4poARwnJqeA/7kTyVwPuxJDb149TbTtcD4RPRMI7wg2WFSEwascxZOciGN8m/a89YydUyFQ==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr60392889wrw.306.1560428086167; 
 Thu, 13 Jun 2019 05:14:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:55 +0100
Message-Id: <20190613121433.5246-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 10/48] target/arm: Fix Cortex-R5F MVFR values
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

The Cortex-R5F initfn was not correctly setting up the MVFR
ID register values. Fill these in, since some subsequent patches
will use ID register checks rather than CPU feature bit checks.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4d5d46db7f0..c8441fc07b7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1609,6 +1609,8 @@ static void cortex_r5f_initfn(Object *obj)
 
     cortex_r5_initfn(obj);
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
+    cpu->isar.mvfr0 = 0x10110221;
+    cpu->isar.mvfr1 = 0x00000011;
 }
 
 static const ARMCPRegInfo cortexa8_cp_reginfo[] = {
-- 
2.20.1


