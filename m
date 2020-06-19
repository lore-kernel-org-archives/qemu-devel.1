Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F642083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ggCQZLTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F642083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKe8-0007ZN-PE
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUz-0002AR-31
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:08:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUx-0004Q3-71
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586522; x=1624122522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K0/g3Jw66ncRXZnSbPM1niIHhe1e2k1srPccWkUeogE=;
 b=ggCQZLTwtGqtDqdBzGpEAdeJNWP2QjbNpCB5i0aiSe0CZvzKshys4TXz
 Kg0U/6ZQYqhoNJL/ZU0/EIIA28xobSlifx+X295mYb5CS5yxlox1kO50s
 vt8uAoN060GOHy8OzBa30tJv3zurSUFMvDwTRoqJTcFgDIZBuGR9UBAPB
 Nq5VVGT3bMO+OSI69vMumI6eCt3bTi1FgW/TXvkHgOA1L0YzEXipkQlK4
 TsBOE0JyUNR5aWPoSKBtg2H1ZSz2S+gV2oGZkWEBNY5Y+C9W6PAU1+uZg
 IPCRMPGkJMq83+7lBYTL35BVPXKWidQbJRgzeHRa5NQdXPg4dFnD7vWj/ A==;
IronPort-SDR: QjbyWE0ROaufohZa3iCaze0VpeDXTKF/BsPowVsIda3ytoSy2HlFL3wCYjSpoYzZUvbr/4Em3+
 d1GORhi0b0Mpvx1rQVBPtOO+rzC6KXu43xGrOtvdXTBYzGdhnjfQv2GxuTmuzJwQCPqlIFX1Uz
 tTcIh/AYJPQQqzOukltlwAHuGzIU0MtxlhApjqXQkq/jVuA9io4F2DU+QkTTj/UeesuojE8hZP
 k4fSnMoff9rZa9xc5B9KwKJt/f1gU/Ms7TexfEe0le6yYb3b140toyJlFu9VhXXdGb041AtOhI
 Y2Y=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417021"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:32 +0800
IronPort-SDR: a9c5ZPhi045rhlJZbj9uOMt4tz8B/tTyrkHX+Ad+sfn8VxNJZgSBkaykQpN7aAE+L8K3R3Rsvl
 Ov2pF6O0YmEANE7b03j6GSXEwWgVmBwhk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:06 -0700
IronPort-SDR: 0Os/I/D2aaYaBuQQh6nbAQxdFKMZSsxdNeRUo0vquCOIbx4Hjz4Y8eBRvXHy05qtPHt/Di4c1z
 RWvzVvTYdDUQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 31/32] hw/riscv: sifive_u: Sort the SoC memmap table entries
Date: Fri, 19 Jun 2020 09:58:16 -0700
Message-Id: <20200619165817.4144200-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
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
index eb767aa863..b9d0a6901a 100644
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


