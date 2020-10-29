Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B1C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316220825
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XT4BUOz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY90W-0005FC-20
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rz-0001Z9-Lo
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rx-0005fG-I8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981537; x=1635517537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P/qi2faPiuz4u3dNR7xsZrZ/3Jx9//l1Rlurl6tn9Fs=;
 b=XT4BUOz1CHjLcZ2tXXlRf5gCjW5fJ46DbGvHa7avmyZf8qyfxhJEfqRB
 Xi8enxpxUFAyqeTyCAxpnw3CJr7RGwnQSdcHgRWjXV14ovw1DRtJJQv09
 MP4IlmNPOj6Ufaz4S81ALo496rULeX1aImG57LCeUEDrNEO4RGmbS7/99
 t3lFVxTyuoM1kstf4pQ8cXb+ZrLcOCa64M9VIz1md2Ig58sZKHxZdXsqD
 wT4wpprQDp8Yzu7msb0rl6Ml13jwCeUFUPEsT26zE7d1y5lgnwyk7m3Z4
 OY5CZDAfsa1IxGo0kPgolHOJjnCP2ZG2mpbnpSnEhXveFL5JJLvxpBkHp Q==;
IronPort-SDR: ebZtykrvj3WXOaDhabRlspr30TZsEK37M4nPCAQu0cb1ro+0uQYz1Bb8K5lQ4nK8oWQdfRTyoq
 Fw4Gn+ENqGpMeCPPh3QtZORLYyvv9P8tePhjH+Aa0FE9LkpwdNXkg74QmhcMD5EchwFBvTIZPK
 c0wOB9LzWaDUw5hhiVCV4XUQi4MlriXSQQnXPgoQmx+RE15IUEh66Mz0pouKhzj9A9yeOg6ShJ
 pcLZP0zRWYBCv0S2sAfYajydhnre3y8YJ/jWWlI1qsgJIK81MAIPc00pIUg2vpt9VVWUCg/1h4
 Z4U=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317886"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:28 +0800
IronPort-SDR: uyKjs74lHLVFJr9JKQkkLmDCsVptTkc9Y4EcvucPzK3qZu+hVxYw7WVi++n5I6QoJCl1LWz08y
 60ia/hr9BjRRhyndMW2+h5k3CYPLW4m/k9YfoTSLYycvKcwM+9j3uHQsoxntIvj3Dz5Llc86bq
 2k1W5CpjJhryE4UVQwPvURBq+9KsgoSSMe9oAYPqDlI03uWj1d2BKuvT+zaEeorJeKG/f9196Q
 JTbNcqN7g+AEgKh1Hbl3xDL7QHBm6bgfG5A2cW5dwbID5wSuILDbsw321emKqTJ3zWTj5pPHR7
 uTajVOuy5qXaWZ3r11wwpjh6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:43 -0700
IronPort-SDR: ZGjxn9xYFV8Xn0WVUejTdpHrKYsNFu03UR6UDeiS00QNzvkfnVvmca70y+UmyYG7K7x7lQknGS
 H0+ioS/acS9xBelWG26v7ywsqbxQv2TpbCHJw+N5ewbh0ICaUfGhugjiK/2HRmHPa2sutvIZTM
 o2L/bMIWqystIViyvPlD3DBFQD8GDgwkUtcEXrLKouYrfsXM7KsZaeT1hUV3eZfv4yFw3TNPBe
 W+fj88dwgiY3FWBXvItiOzdoALYZvPMijztpMQ/0pzyqA2RO1SRunwtPQyLRKMtEu3PJvPzQkl
 CEQ=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 09/18] hw/riscv: microchip_pfsoc: Document where to look at the
 SoC memory maps
Date: Thu, 29 Oct 2020 07:13:49 -0700
Message-Id: <20201029141358.3102636-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
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


