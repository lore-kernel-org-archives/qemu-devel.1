Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB07FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9519520737
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdmuVcDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9519520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjf3-0003r4-Kj
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDje6-0001mx-L2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:26:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDje5-0001lI-1C
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:26:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id k15so1556089pfc.12
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4W7RubWumEglnK/FyOQH6KhBEYuwqvp7XgB4+69Mg6k=;
 b=ZdmuVcDHiJr9yePVeA24YPoRw68sgDQUM/PZRBTzV9WErDlZBus98X4x0jDr0B67wW
 Sq6JfrUSC7Ih7Xi1LiUOQKqVWLFJByD/f8+m7GTE/xuwQgzd1rgIHNZfA50PSuWfsbKV
 4gdxpV8Rj3kS2Lp3GmLdIPdzus50EJvLDcwUsuDEGJcSTg776iS0ZO4CXy+hiMBQMpHX
 MtiQFTJ/b7NfnB/4JXc8JF1UwtOHrFn5OrCKIyEUHd3euq/ZlEs6O29P7bM4bTAVr/f5
 UVvFuTMyiKtpetEFhcXttleKzGcLC+jSwoW5+cCiuLceFGry0rFYro9lcbh3yrxyXtnQ
 Lffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4W7RubWumEglnK/FyOQH6KhBEYuwqvp7XgB4+69Mg6k=;
 b=k3W8ApqFnfHQdrLhbuHS/cfeFHor06Vh27KCFSGbs+L4fD9Y9MYzMQUtiNtG7nFOT1
 G4SPWI1kWAuqtvcXsX57+bBH6QGS3cuRT8u6C8H4UvIcsAhrMeNESCAgTfqb1Uj5Pca/
 yQ3OtXn7fKB7IHBkZR0rJzcUIvCaS9m6thStqlqBy8zYUT/ef3/GrbTkd0yb6Gpp57Ll
 yGcn3YYiiPgsjaNPEIWzLbiks7BHIV4lvSjJEpLoExPzEj/JMpCdcWnadi0HduJ06Kub
 yMMOjotsuYSgkjYQ5OJmg/zfyQ0xCyBJ9D4k8ya8HPoBYWZyyhxXKfVpx0IVgVyVlHTS
 Y85g==
X-Gm-Message-State: AOAM5332CmGnRM1PO5upSbJimPxrT2nCKntMeinWG9MgDsVnPPlRH9sK
 PhP9C8zijeqfB0xIYbAVvu0lB0mF+N7jzQ==
X-Google-Smtp-Source: ABdhPJyomxk/TVThHmtznm2tXIFyBSFBddEoFjhG+aTO/HffoLKEMAernNET6ZgbTmou9q6qDtLhbg==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr2571674pfh.125.1599118015191; 
 Thu, 03 Sep 2020 00:26:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x185sm1930229pfc.188.2020.09.03.00.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:26:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] target/microblaze: Renumber D_FLAG
Date: Thu,  3 Sep 2020 00:26:40 -0700
Message-Id: <20200903072650.1360454-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903072650.1360454-1-richard.henderson@linaro.org>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ESS[DS] is bit 19 in the manual, but the manual uses big-endian bit
numbering.  This corresponds to bit 12 in little-endian numbering.
Let the comment about matching the ESR be true by renumbering it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a25a2b427f..32811f773d 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -264,10 +264,10 @@ struct CPUMBState {
 /* MSR_UM               (1 << 11) */
 /* MSR_VM               (1 << 13) */
 /* ESR_ESS_MASK         [11:5]    -- unwind into iflags for unaligned excp */
+#define D_FLAG		(1 << 12)  /* Bit in ESR.  */
 #define DRTI_FLAG	(1 << 16)
 #define DRTE_FLAG	(1 << 17)
 #define DRTB_FLAG	(1 << 18)
-#define D_FLAG		(1 << 19)  /* Bit in ESR.  */
 
 /* TB dependent CPUMBState.  */
 #define IFLAGS_TB_MASK  (D_FLAG | BIMM_FLAG | IMM_FLAG | \
-- 
2.25.1


