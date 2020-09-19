Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD3C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3ED20874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3ED20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJhz2-00054w-D4
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrD-0005x5-W3; Sat, 19 Sep 2020 14:45:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrC-0001JM-Aq; Sat, 19 Sep 2020 14:45:11 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MwjO6-1khPuE0TQQ-00y9Aw; Sat, 19 Sep 2020 20:45:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/17] hw/ppc/ppc4xx_pci: Replace magic value by the
 PCI_NUM_PINS definition
Date: Sat, 19 Sep 2020 20:44:36 +0200
Message-Id: <20200919184451.2129349-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:h/h2VcDIwTiLg/hBUwZ4awmd4hH1wKdZFS7+HpDwoIumxXIBznn
 YsFVomvgZ2oevY6URh5oj9G3HP4KUomazxXYArjoFvO98qc9mgqDUjkVtReXwpFFvK8mtRN
 siBxP4t6Fl+Utib8vBOiCbULvcoBf5C5JEF3UvwtzhPIxiJ2ADVDtlFfFwcygxEPM0gMrAd
 PAsd38Txln/0syX/0+q6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ml0MAjfjsk8=:pPHBOo0xFLotnDC52G50bp
 NCnFlgCavHHtfGYiEOJ8VUvSwXMgLuVU74r7N4DTavgt3Rg2ocgJo6214C0J261nTO5+VK4rf
 cUdlkhSAZWvbCEuH6y69G+j1fPAWMTtt0z551NOz1Z9QwcaWpFjuMNdmtBCwg+eokkJZx/ZQ/
 Oube/cqZquJh0mUjAxaH4l9Vk29yG+lgNQqcfM9abLqb8wOQf70TYuI/st51+X83WKSHYI4s9
 hMRzXdmzUc4PSktqx4ScDOnPk/barjG+V/R580WPLJNpzPBQOYEobDMgkfmjO3CytQsbdAAcQ
 xGeeBfYrtDKv1DzOi8KliiO09ZaLWF1SUBMuOETwbXSR7R3/Ey3eFuufm+8iBpn1jlObioUwX
 ++nD/J0LasaYO9A+zfR7ew5u0mPlc3gRCC87Y3q7Bo83n4rsx33BQww/9/02hTcZd5Z3fR9GR
 EvlgNCsBdUmyeM8SL6GXjJPg8JlC+Ts8WwO7E+PqXMnG0TFJ2Upqwiqv3/pqJlihV/Fe6/Ty0
 IZ9UIgrjT3K5n48nrr+iNS1IfvkAcVOBBP09ktuTIIBh61OGIdGaMJDSty/21AIpwxE3Wvx5f
 z6mA9OuddSRnqO8Ts2zR8yMddvlGNfWf9EyChdULFp4zGt21kKEFV/JawygerMIQuBQ80T3rk
 UroyEKNccIe+DDrv2i4Hab7ccI2+5yM6NeHr7jy/KRN12kLzu/jP3SgkwvlToAhQZQFS1jtWe
 YsmbfDW5q31vVOuroKfdmrOm2qNeNZ61wawNFV84vtOtIq9ITCUQ/P5wPCwqTXci+NgKJHdyx
 DbhVLTnQLJ0Rg9SHscnFIxV16GCvA7KwIgZ1hW6ifU4LHYbbX2GS8IRQJgBd69o6n5TG54G
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace the magic '4' value by the PCI_NUM_PINS definition.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200910072325.439344-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ppc/ppc4xx_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index c24bac96c32f..ca2553bf8b75 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -56,7 +56,7 @@ struct PPC4xxPCIState {
 
     struct PCIMasterMap pmm[PPC4xx_PCI_NR_PMMS];
     struct PCITargetMap ptm[PPC4xx_PCI_NR_PTMS];
-    qemu_irq irq[4];
+    qemu_irq irq[PCI_NUM_PINS];
 
     MemoryRegion container;
     MemoryRegion iomem;
-- 
2.26.2


