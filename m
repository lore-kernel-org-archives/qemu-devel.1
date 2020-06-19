Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6A1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D0920707
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jnQdFOcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D0920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmApc-0004Wv-UG
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAcd-0006gk-6K
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAcX-00028f-4l
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548525; x=1624084525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cG+lTw6NJcZGe01NywzuI6sjGafJO+wx2fJIsdjfiaU=;
 b=jnQdFOcDnSQaPggnTdNKXQBpQ7yL8xuT/URciPj6OtIMRCcC7LogTu0M
 AdTsG646YsP6VdYFwcWwh++qjpqlW86J/TVTwrD60cUlNO53fQqFzVK9I
 +/+ZsuXhrEI1DUnuw+taqHm0jL9JZWlq0WM5M7VyYpZ2t51+mS3wDQRi3
 n+op9An/MQAJOwYBOngzbVPq5NROB2RzCqpUVyqUwez7sa7wGpKV3rM3C
 U2ea58jidW8LNt1rUsFZHSF8rnLBDSFFwcBYoFGpLWobsTGDtPCjIOWqH
 w73FV0f26b4s7Zk74AQmVCFU/tHnuDyRa3fkiAv/HP/Z4PjIZZzsjwVgf g==;
IronPort-SDR: RxjNH9xH0jXssNWImpUxJiTs4At39b8BnEfPAtlvNs1yOLRC46kh9Mu0mk9L26m20bgtgihMY5
 j1rVn9oT1n4fVY8qSQ7KdRFDUbVm3hPNKGP0sLUsU2Z2kLKaTXX9/NBqCplOvPVyMRQT45IC38
 F3UpFsyYnWFgv1k24Pr8VpbOK6ODqG9BC6rmANlaSMPftI7hwcSwZmAQOXdu6S27OXhdNP6+Us
 4UpydT4Z+cRGEtSiCyL8G1tJs9Uy2tSCCWxUYKBYJ4/AGIwh+F08ZSGHJiVr+Bgat/yO7XI5Sy
 h9I=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781956"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:34 +0800
IronPort-SDR: UOdZS9PodPaTdqLoE+yrHqDb678ttt6LCc+A02G7yHRhHvzdYnu0vNGwmerEpSZ6cEdziyKShQ
 BhLPCyxSwmP/NwUMv/pWjZDHz309XILh8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:44 -0700
IronPort-SDR: LArEO/wAtyqt1uOq0jkhPXJN7xRS0afRdySAt3QiOhm/kTRGtbw5jhxHNgPWOgWfppluGKBfC7
 ffG5UrWEV8fg==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 31/32] hw/riscv: sifive_u: Sort the SoC memmap table entries
Date: Thu, 18 Jun 2020 23:25:17 -0700
Message-Id: <20200619062518.1718523-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Move the flash and DRAM to the end of the SoC memmap table.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1592268641-7478-5-git-send-email-bmeng.cn@gmail.com
Message-Id: <1592268641-7478-5-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2560c1ce4e..052ba85ec7 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -80,10 +80,10 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_GPIO] =     { 0x10060000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
-    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
-    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
     [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
+    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
+    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
 };
 
 #define OTP_SERIAL          1
-- 
2.27.0


