Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A34206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhfCty2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A34206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2rK-0001bi-0j
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kG2ki-0000gK-2n; Wed, 09 Sep 2020 12:15:20 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kG2kg-0006YW-OC; Wed, 09 Sep 2020 12:15:19 -0400
Received: by mail-lj1-x243.google.com with SMTP id a22so4268201ljp.13;
 Wed, 09 Sep 2020 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6/NYwDNd+IA/YDq3B0TD+rKGxUyX1pBK+vG8qzvYuPM=;
 b=FhfCty2ZHr0zp75cdnJt4Mky/XEhYKNK2gcryrVt+74OLGS9ZLONQnrN1Pcqx4XAvA
 KumvRmFHfUogniMgO+PEDO3CmZD5AxzXEPQ5TabtX1qHMF8LjmcJz+EagrfGfYkQBrBl
 fTp9hHRzbiGAst63YhFsiKZ9Bf5kXMzmgY1PC4JhYTwBDO86EL6lPS2OCj9OieA/fN7F
 MCYadV96fFwAEKLtYq1DtENCkEo1ixMEesNoBDaPt+j9y7/Ms5mbicInzbVSyWhdVeDt
 to/wha2t0XdB5sC7cXwSmj+byBayrKVSl6JDkcADcd5NBDfSxIovzEraPpY+vu+nokHe
 xH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6/NYwDNd+IA/YDq3B0TD+rKGxUyX1pBK+vG8qzvYuPM=;
 b=Z15CfSNo83aAlTUk043P21RWlSA8l1q9WmxOTthX8BugydI/sImiDU2peeJf62nG4/
 y1hsMMNVErUgkTWG3SsZitH+FI36XqjHCrutnWinRa/nkvKKbn8wdzGmTDoFpUGkYSR7
 sx0vq4deFIP7UdScNeDETHuRBvtRApDUz8rvqAvW+2/6XXWtyMRpknn/NA6MdL1AOMZ/
 w2jXkoavgamGzpSkT2emtMMQtmNdZe7oP2FKKbIeYBtKojRqyTuhqDy8eY8+WUmpT2fx
 ELSPOuVpMj7Xvf9GadmTHqgedjt0smeKz2b3z+NiVPPcDPB1VlrQ5WrfR0/bwZFImd1r
 0ozg==
X-Gm-Message-State: AOAM532t5s/uyBxN5shPXRvxxKcgFkXbjmxO7tbEMNVnOrjmugoFTpmU
 Qc8qohVWzR3m53m1SH1dxZacL8AgdhI=
X-Google-Smtp-Source: ABdhPJyauGOYZ52tUQQLX9lTFKsoHnUpoRvDk7CwLQjpDMBm5xN8wPi6rsVRWPcj11mkOGf+wNS9rw==
X-Received: by 2002:a2e:818b:: with SMTP id e11mr2383129ljg.0.1599668115493;
 Wed, 09 Sep 2020 09:15:15 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id z15sm845518lji.78.2020.09.09.09.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:15:14 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] hw/arm: versal-virt: Correct the tx/rx GEM clocks
Date: Wed,  9 Sep 2020 18:15:13 +0200
Message-Id: <20200909161514.622998-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1.8, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This corrects the Ethernet tx/rx clocks in the generated DTB.
Avoids a Linux kernel warning.

Cheers,
Edgar

Edgar E. Iglesias (1):
  hw/arm: versal-virt: Correct the tx/rx GEM clocks

 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


