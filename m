Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD065C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D542077C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5BhKRB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D542077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNzC-0004aE-Rj
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:18:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfc-0005BA-PA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfa-0001Yc-Ow
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfY-0001Vl-Og
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so26962613wrq.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=tO2IbzqkFfPLxQHEQtP7KD/Py5uleD69zDN6a2d6v0s=;
	b=g5BhKRB7QoF5P+fGXAexdSpC1m8IYCNpc8uaDDbaLKubN4BHTVCGY3h6IB5RWIqQZA
	MbV0nk4g1nemo1xF1ayKqp3yRJop5eu+ERgC0mI0DrpjQQ2eE+4hJ7pBjZbzg6GplElH
	Kj6pOUeoCx+0P5kaz/buSy3cYm9Fc1yEjB9hMMksAw9KGWU/NoKcvVMjP4qSM+aPvEVC
	xArfrW0aM1oLfNFTFRkNaF/aYEH0gIC0adBh0y+SVtLsMdBQ2pIyhvNhg1NofUke05U7
	5z/KAkcV6d/7FQlR7UjRNmj2HInRvIJX6xQcGaaUgGqWLekq4ecwrSfQ6HwsyZjLHXFd
	m3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tO2IbzqkFfPLxQHEQtP7KD/Py5uleD69zDN6a2d6v0s=;
	b=MadBPL6Y4zJ5QeUJh1uPO60CtuQ1itiudLDPwGmX6n3Hz/qe9/mzwUa/+AeBaZa/W8
	ei17i2+NswzQVG2RfNhl3959fPNAq0qQZVPSJhpI+gJ3WJ+QKWgkeNya6j+5xDkRtZyZ
	35t//5F7rLhcMO63vJOqe69837KvodAKFpktdDsISUQsOfmGV+9pFdo98IpJpgJs4Y9A
	nG+KQzibuLmGiPUJb5D4aMuTWVxPWuje3/ZZP3X/oaupF58pQAtyvE7qRCSqrIu50X7Q
	sGN5Q6mzEXflNM+42XjKJ/9nundc4lXh6WSXHYAJg2VMFticzmFgzv2k0t2MnzbghwLa
	xUOw==
X-Gm-Message-State: APjAAAVPZUD38euyVtLiy5abR2/WuJ5XkU9yW9TatGxTrvEaHJ97n24E
	BZh5dqL3WpjYU61AcX/97vPVdEjHoPs=
X-Google-Smtp-Source: APXvYqwh7/cSxCAppGXQHXu3W1Z4WJSBow/CYQ2cdKHKfXAsWyggL2b4uSB8x1+qi96fCuRF66YkJQ==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr51758249wrp.194.1555419515116;
	Tue, 16 Apr 2019 05:58:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:44 +0100
Message-Id: <20190416125744.27770-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 26/26] target/arm: Enable FPU for Cortex-M4 and
 Cortex-M33
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125744.denULOxJfHyaPtaTXFsigHsfeCHnv5xvj2CaPw6PXjo@z>

Enable the FPU by default for the Cortex-M4 and Cortex-M33.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dd6c4f6da8d..00d3299e212 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1494,8 +1494,12 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
+    cpu->isar.mvfr0 = 0x10110021;
+    cpu->isar.mvfr1 = 0x11000011;
+    cpu->isar.mvfr2 = 0x00000000;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
     cpu->id_dfr0 = 0x00100000;
@@ -1522,9 +1526,13 @@ static void cortex_m33_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fd213; /* r0p3 */
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
+    cpu->isar.mvfr0 = 0x10110021;
+    cpu->isar.mvfr1 = 0x11000011;
+    cpu->isar.mvfr2 = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000210;
     cpu->id_dfr0 = 0x00200000;
-- 
2.20.1


