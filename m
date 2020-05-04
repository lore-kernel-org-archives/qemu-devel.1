Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09542C47247
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4382073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSIh2YkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4382073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaIa-0001gA-Uh
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHi-0008Ih-DU
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHh-0000nc-JS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id r26so8850494wmh.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SAclrjD7SOitws2kvsSrHFg+/NkOvMynkRjg1fJ44t4=;
 b=lSIh2YkES7Tjad8wSCzD08Wh3D7ZSQDHUGEn/0/YgmteKbFhzy5cjBvWlHpSRJtxLG
 3c5pKnohdxKIKeDFmyIHL6cvYKazUOAOQ7QqmIrqygxRCBm/O32TpRYP4E0UD+glgg0K
 0WMUjle+C/FEHPRu+nUXS22PVOc3qGeb8jh4YgPDPcxk7MZIxa3g5nzRZhmql461ckOc
 EdOW1r43L38UrtK017CHHgx01orYKdo2GH2riaffdcKmfpMZRq2p5CSqCB6Q8tuIh2C4
 Pj9Um+2jxMTdEg75jvS2FueOcSylmfrstgty6lHiWsDaZjt/4SubjOQCLomES42EHdZH
 Asqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SAclrjD7SOitws2kvsSrHFg+/NkOvMynkRjg1fJ44t4=;
 b=azSPikVshbK4b4Cdp2lsYrzMO+JhhFG4RuFM2EtXK3nGD1EicY93CnxyNQc5WKpR5y
 WpOAQ52CPYyE9fN3bjLWo63mRQKMBN02wssSt18enFbi5d9hFilYSXwm/Z+yaDwNLyEb
 SQz3K1Pai0VB1iAcWUFQgadR5kJLtIpnnv4HbYBLL7QWjD5gBJW1DI9KkP6FsLUM/ix3
 VNS9RXp1G5B+o4kEWRidNApHcvZy/kYJmBW8nd6HhkpJorMhfsgBoEZ7KQ0RKPaX89bC
 KaBIsHbK86nwOLc0Ffs8mmErZwC6ZToFTHc2oi5QQYzJxpHwaWqXVYuS62uae14qCwUs
 YLlg==
X-Gm-Message-State: AGi0PuaBbBw3QoyHUUiHsf8Y3boohxSU6aBFuKCwGD5uesVGMP15Y+C0
 zoshhaDuRX4sOIQZkdh9dSV3RM19BADeTw==
X-Google-Smtp-Source: APiQypLQSx/m6ioaRhNNweRjciS+tS4cf1Y/PJzmyUqZ8C2FskcRHmJJalAKIVPb8mwYJ2fgkmMxHQ==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr13926654wme.38.1588595596534; 
 Mon, 04 May 2020 05:33:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/39] target/arm: Use enum constant in get_phys_addr_lpae()
 call
Date: Mon,  4 May 2020 13:32:34 +0100
Message-Id: <20200504123309.3808-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

The access_type argument to get_phys_addr_lpae() is an MMUAccessType;
use the enum constant MMU_DATA_LOAD rather than a literal 0 when we
call it in S1_ptw_translate().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200330210400.11724-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f785e012cde..f17841ec24e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10052,8 +10052,9 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             pcacheattrs = &cacheattrs;
         }
 
-        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_Stage2, &s2pa,
-                                 &txattrs, &s2prot, &s2size, fi, pcacheattrs);
+        ret = get_phys_addr_lpae(env, addr, MMU_DATA_LOAD, ARMMMUIdx_Stage2,
+                                 &s2pa, &txattrs, &s2prot, &s2size, fi,
+                                 pcacheattrs);
         if (ret) {
             assert(fi->type != ARMFault_None);
             fi->s2addr = addr;
-- 
2.20.1


