Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E05C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487C521655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4/SS01M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487C521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOFy-0003HJ-5p
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPZ-0001LO-AW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPQ-0004U4-L0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n18so1537302wrs.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=O5Fi8dzQWj056a5kaTxdeFGMOF4n1yn3p2p22rp/J9w=;
 b=b4/SS01MyKcHtGGMLjUbKCCT3U5jZhcV4O572BLC7gE2YP8Nkw7lNOsYNOT10f1hGC
 9WIVYsO532W9olGT8gZrWeS03ljXVo6MZJnY91y+UuSnCs4Ls/bOtFILDCAXcl2qIsoC
 +a1TFMDjJn/f9VwOnhuij4WAAI56Wgx/yO4fhuKTwYmWKoRX8ish16OB0ho15Ik+Gk9C
 vLs4xbyoGcfkpENrN9R9JdCsV26jBr9QN3Zfu1VRFTzDpHzucsk4MOi5S+JAQDwbm0uz
 zeurR/xNxuecPu/QZgylIgSEtfMxG3XRGMt9ykuMQrIYclGqk4UFjiwPwoUPhZ2cUhlQ
 cTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O5Fi8dzQWj056a5kaTxdeFGMOF4n1yn3p2p22rp/J9w=;
 b=ItMHtj+twvRIe+HZ7PDZoxn/e9sd3kIACAC6E6J2P1dW1mFzWlmEaFBzyt7iwJlmbH
 XDXCiBi1bY0zV8F3D2Iuwsp8ZasJD4TlOczEi53S5dBDrHzd1GaWbhC5j87l9aWio9RM
 WqGn1y71TaljiMhKVIZ7GXrxR3+hDI18rFsCf1e5aJEQD+kyYd12CorIyAGzK7srYjNY
 jnpAW+uF108RaIegwOOn72hGP4VcBXXGOuLeivI3EGzIoqZ29YeAhZukw0Lw9IN6rYpL
 14onAnh5XBlhnb4k7tjkA5iot7NlsLFCA3PHZbTyAVWb+X/hn7JmGq3nhtEjAlivlfBs
 K35Q==
X-Gm-Message-State: AOAM533BK/9R0afr8F+TeU2LybqSvFSMMLoSZ4CG1Y7Y/MPKoCDjsZO5
 +WPZ03XtmlvYDAVfOPnE2858qlv1GwnCsA==
X-Google-Smtp-Source: ABdhPJwFjkTyPfGalkGyxXDNATe+oA2x7f4HOG4QmaoCACO0VGhUaieswbFu+QyZaRjI6GXQu+C/Og==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr2540815wrw.132.1603799098559; 
 Tue, 27 Oct 2020 04:44:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/48] hw/arm: fix min_cpus for xlnx-versal-virt platform
Date: Tue, 27 Oct 2020 11:44:04 +0000
Message-Id: <20201027114438.17662-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

This patch sets min_cpus field for xlnx-versal-virt platform,
because it always creates XLNX_VERSAL_NR_ACPUS cpus even with
-smp 1 command line option.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 160343854912.8460.17915238517799132371.stgit@pasha-ThinkPad-X280
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 03e23201b1a..ee1282241e3 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -561,6 +561,7 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Xilinx Versal Virtual development board";
     mc->init = versal_virt_init;
+    mc->min_cpus = XLNX_VERSAL_NR_ACPUS;
     mc->max_cpus = XLNX_VERSAL_NR_ACPUS;
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS;
     mc->no_cdrom = true;
-- 
2.20.1


