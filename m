Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C419C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB0020756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5AqPFbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB0020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqZN-0002hI-Sx
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8I-0002Uj-MW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:02 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8G-0007a5-U1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id m6so18931265wrn.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=M14ia7zdqe++jgIV5QiQr6O0hwvccgqXO2nUDra5AE4=;
 b=X5AqPFbkurODq9K1A0Ff/U84UFpENYFQmNPJJXcnQ/1ZBcU/4jqExthx/HalDbQ9o7
 GdcfcyA0S6yRmh9nmEc4Fuu1S1zy61mGYEdSggi5v8TGXSsAfAcWpJ0//J++oAu0G9uP
 P5zrdkGewnG0xB3bfgxe4wwBNOMY4U52yOzTtsmAfBqWwg46ESEv4UAanNqrJHiNh4k9
 3a4+TPOmgVyFy65/uZHRA5rZ/7lKjnqvdLRI5VoEZRAzkzJYsTMf48u46CMx7MFsa/Ku
 2kDaf2iqHcGXo31zwXeSq29sj1z+VR12x5fVwCiAApR5cytG07w5cfIKu56nc7PCjIG+
 Vp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M14ia7zdqe++jgIV5QiQr6O0hwvccgqXO2nUDra5AE4=;
 b=fpfaC3KrXbq8fOO5Y+tSoD4yJ9+n1UR43MLJWGEiHkhxzOCePaImGrzvzyoFWu5G5l
 jo31c5sdw7lyVlxAWSMrzoY0i1A/FurX2g+w7NB+k0jvf0kbKfUuT8FGmzvCKu1IO32W
 lKBe20K/fbB+G/voQuP7tvRNz/Av9XyfBQ6f6PfipVmVJ4+IlN/hCzWiAITCYxpIglCT
 ph4x6m9OeTtqp5o30Jf1r6GiVLS+fA/1R0lXGYCMc8u7P3e06xeFfdi89dIV0YqJGylv
 UVGOKbpuzN8JV+gpMGuoSf5UbIgTIkMxYM+Fdb/17XUYS5FeudNMCCG8Lx2k4S6QKhr4
 v5Kw==
X-Gm-Message-State: AOAM531OHHPrIi2GPWLbHg129tB5mRpU0v1uEN5YvsNvXaeOEdY/clnd
 zWp7Q/U0g+fKgspnQfuqX87FYLR+9XwFCTcH
X-Google-Smtp-Source: ABdhPJxaTjcu9AfAEkpl0on9wUCPuq1GOgn83/boenpFCaOWNF+8xsxoXmV+ovn+MwpDrryN2YKclg==
X-Received: by 2002:adf:9027:: with SMTP id h36mr15904658wrh.259.1600092419401; 
 Mon, 14 Sep 2020 07:06:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/36] docs/system/arm/mps2.rst: Make board list consistent
Date: Mon, 14 Sep 2020 15:06:19 +0100
Message-Id: <20200914140641.21369-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Make the list of MPS2 boards consistent in the phrasing of each
entry, use the correct casing of "Arm", and move the mps2-an511
entry so the list is in numeric order.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200903202048.15370-4-peter.maydell@linaro.org
---
 docs/system/arm/mps2.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
index 7f2e9c8d52e..8c5b5f1fe07 100644
--- a/docs/system/arm/mps2.rst
+++ b/docs/system/arm/mps2.rst
@@ -11,17 +11,17 @@ as seen by the guest depend significantly on the FPGA image.
 QEMU models the following FPGA images:
 
 ``mps2-an385``
-  Cortex-M3 as documented in ARM Application Note AN385
+  Cortex-M3 as documented in Arm Application Note AN385
 ``mps2-an386``
-  Cortex-M4 as documented in ARM Application Note AN386
+  Cortex-M4 as documented in Arm Application Note AN386
 ``mps2-an500``
-  Cortex-M7 as documented in ARM Application Note AN500
-``mps2-an511``
-  Cortex-M3 'DesignStart' as documented in AN511
+  Cortex-M7 as documented in Arm Application Note AN500
 ``mps2-an505``
-  Cortex-M33 as documented in ARM Application Note AN505
+  Cortex-M33 as documented in Arm Application Note AN505
+``mps2-an511``
+  Cortex-M3 'DesignStart' as documented in Arm Application Note AN511
 ``mps2-an521``
-  Dual Cortex-M33 as documented in Application Note AN521
+  Dual Cortex-M33 as documented in Arm Application Note AN521
 
 Differences between QEMU and real hardware:
 
-- 
2.20.1


