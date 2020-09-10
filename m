Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B95C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319ED2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMWthuA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319ED2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGww-0000tG-BF
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGGvd-0006kX-QE; Thu, 10 Sep 2020 03:23:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGGvc-0004JJ-Gv; Thu, 10 Sep 2020 03:23:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id l9so4689138wme.3;
 Thu, 10 Sep 2020 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ze5QYyQyWojYS3caRCg7MlGDCArBjQK7biaiEuZNBk=;
 b=mMWthuA7lfFfckReUdKJD11EGyTiCsucUYTnNgNAYKNKXacZE0IAu3D7lky7UQ8ZVU
 rmAMAKtH2m0PoNQ+9GDOPPYZci7fu7rGq8ElL1VQGHhrH+rRvJIau69qCOMJkZ80zhzh
 WFPRIPA5unX+FOo2xXHZfw8QVFST615jOS8/7fdreULd41m2wwVmHzphZ0+Z5sTxA/0c
 b+Ws/NRF6hpRx8edwtoCJ22MQaduYnO44/19vIsyO+PbmIplIeJJmW/Li9u7NIaMIwkc
 gCcxxYP5T6uz73qlzgc1oLcZQ8Y1iAdG7HHL4rxrkgkQKzrgSSmQViMxQZGFJ2uDB+/7
 v+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2ze5QYyQyWojYS3caRCg7MlGDCArBjQK7biaiEuZNBk=;
 b=rGhnJEjcWrsoSXAS69Abog7+dbKpm5lUyxIxJosKkrmtYVF/ln7d/2xr6XLiXD/tjb
 yLC2rbJ/k+6dbaWiqcaJ2UXlA6tHxpgNqIaED+yT/TVFpAld8H0B49V/C1hmnZHYAYVt
 j7Tp+HyfTEZNUg6mnOtZ8e8G3pjKwVLEc1DTwLWf190DpSH3dZvJYCgWl01J9KjITvb7
 ZLMwN4kaMJeQIX6z8EKhZER4PygzkWrawTN+0Q3QMV/ReoXxADlP0n9SJn5loKhJcQra
 ivCVhbJcTolvCZQz+bNj3wE/J89w9WXA7Xwl0m5vgDWMdyu/OYpLpV1eXH0XlBLVRzQv
 3bww==
X-Gm-Message-State: AOAM533mxnN1zXs9/jqO5NSPIFs/5PUY5PQ9r7NZAxQXuDEjqEvZuUYj
 66bsqFBknvEXHHCoGiDKEQoUuSnKaWs=
X-Google-Smtp-Source: ABdhPJyR+sTyKvk5uqPbgUnZe+Vtyfh7IqxAaJ1WzYZmrVquG7jGuo3P49IiowyPPhG49ZkjeGbe8w==
X-Received: by 2002:a1c:8109:: with SMTP id c9mr7068919wmd.130.1599722610036; 
 Thu, 10 Sep 2020 00:23:30 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id x2sm6783804wrl.13.2020.09.10.00.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:23:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/ppc/ppc4xx_pci: Replace magic value by the
 PCI_NUM_PINS definition
Date: Thu, 10 Sep 2020 09:23:25 +0200
Message-Id: <20200910072325.439344-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910072325.439344-1-f4bug@amsat.org>
References: <20200910072325.439344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the magic '4' value by the PCI_NUM_PINS definition.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/ppc4xx_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 503ef46b39a..930be78361d 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -54,7 +54,7 @@ struct PPC4xxPCIState {
 
     struct PCIMasterMap pmm[PPC4xx_PCI_NR_PMMS];
     struct PCITargetMap ptm[PPC4xx_PCI_NR_PTMS];
-    qemu_irq irq[4];
+    qemu_irq irq[PCI_NUM_PINS];
 
     MemoryRegion container;
     MemoryRegion iomem;
-- 
2.26.2


