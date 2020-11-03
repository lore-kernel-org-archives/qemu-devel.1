Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38FCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2E520780
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kVzY1glR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2E520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZySS-00076L-C0
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJV-0001bk-QM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:37 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJT-0001FT-9g
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417615; x=1635953615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P/qi2faPiuz4u3dNR7xsZrZ/3Jx9//l1Rlurl6tn9Fs=;
 b=kVzY1glR6niliEgvRbYYw4QShcT0fFDczLReBkK+3qspM4MQpMtCDXjO
 dLZ3PWQFknRhVSgcIO1vxxndP0wI1FSw5h+qz6hkh0ekAqCHuQmA6Q2Fx
 voy9MRqTLYZr/FXt7FI896VObL9A6a1+h2fxXUz2crZE+ya+RbU48ADpP
 5xctLae6d7AAjY/7GnrqtRXbf0Ove/7i4gVH8wj5JH+0c0ofgDOhLXNRH
 Xe2utxEr+5QvO8T3pQjZZ1R0d9KF7Hhng3+a+moHqFrJw8MgxfKmLfhyL
 nZvzrpzQlUh1+lhs4KBzLDOrajVvrYhkMCch2Lt4OgUjK4xESq5aec+vy w==;
IronPort-SDR: OZw60kG9GYna+v6CHCfKy/GbKnd/H9dTwJ/00fXhdl4OkFHF3KvKRf5+mFaNy28M5fM9y1GmIG
 FuXFsUvrzkVbmgFWQcIGzWcm0ab9+og7r/1HvtCsb1QwcDVIWXeeD4A5ogYOsR3arvRyZlmT8Z
 kz8uEhN0Jp0aWYgwkgRe+t4WYDTWAZuOZcRp+S3/UWPAYUuBn2HH8iOUmfbY8eHtlTcL4dG17D
 KjnJaFfunoCbvgO3XOG1AeAA9ycPD1BYj8pMhauVukEVaiiODETZdwUQRtNbMmecg3jgUCFaU4
 xiE=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867467"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:26 +0800
IronPort-SDR: ZXtY/2v6NJZDOxh2ijgPdRyq/v5hl1nETuIT4v/D9w9aGAGI91oJsp3Y5asl6RdMVaGiyXy/9a
 q4H+XTV1bD8cn7/MGE0tJPOtQ99kUP1b9fot1ERdV7tycNbxZIeI3Cllfbw7U0YCho/NEyRjcD
 8Zy1Ci/Y14Wh5su0RXD4qu/6tyDoHk40skRe6YrA9EdfbTe50wrN1nSNodcBKAl455EuLmLIQc
 DeB/oDInv8OKM/cuk3BpF4tfvrdEsayhtNDCH2MSVGSL3zFiwZSxUaYCXi7yTizdvTu2cWesq7
 i1Rrc8yYZvPVTeuN1B1y+IqZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:34 -0800
IronPort-SDR: PW7nqYWDT0F28ke6svIt4DO2TqMISCY+uaoR8H72EcY6scWscudid+HQl/cZs7JSsS2SAWRV2s
 vyVmHBW5jr8jV2WPcyfYN4tX9KYFCR9sBE4ZcImMdjM6GDv09W6VHYs5LIbzUCtPkYNscRhANy
 /wGr65hJcABWP8prOd7TuwQ3yH7sqJoEjBeykGM4Lw0s2mzvrjRzz46IvUoOtCaHvcoBrhaIrq
 iN1znbBYKd2FToORlovEJanF9NqKZ917/8FTpDpSuJ8dTypOs6OjyGKpv7U7JvgQiWZIV/RbKp
 eVQ=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:26 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 09/19] hw/riscv: microchip_pfsoc: Document where to look at
 the SoC memory maps
Date: Tue,  3 Nov 2020 07:21:40 -0800
Message-Id: <20201103152150.2677566-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

It is not easy to find out the memory map for a specific component
in the PolarFire SoC as the information is scattered in different
documents. Add some comments so that people can know where to get
such information from the Microchip website.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-2-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4627179cd3..6aac8497fc 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -66,6 +66,24 @@
 /* GEM version */
 #define GEM_REVISION    0x0107010c
 
+/*
+ * The complete description of the whole PolarFire SoC memory map is scattered
+ * in different documents. There are several places to look at for memory maps:
+ *
+ * 1 Chapter 11 "MSS Memory Map", in the doc "UG0880: PolarFire SoC FPGA
+ *   Microprocessor Subsystem (MSS) User Guide", which can be downloaded from
+ *   https://www.microsemi.com/document-portal/doc_download/
+ *   1244570-ug0880-polarfire-soc-fpga-microprocessor-subsystem-mss-user-guide,
+ *   describes the whole picture of the PolarFire SoC memory map.
+ *
+ * 2 A zip file for PolarFire soC memory map, which can be downloaded from
+ *   https://www.microsemi.com/document-portal/doc_download/
+ *   1244581-polarfire-soc-register-map, contains the following 2 major parts:
+ *   - Register Map/PF_SoC_RegMap_V1_1/pfsoc_regmap.htm
+ *     describes the complete integrated peripherals memory map
+ *   - Register Map/PF_SoC_RegMap_V1_1/MPFS250T/mpfs250t_ioscb_memmap_dri.htm
+ *     describes the complete IOSCB modules memory maps
+ */
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
-- 
2.28.0


