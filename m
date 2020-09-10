Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC76C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8722076C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n4G/bSZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8722076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRD9-00065X-0Z
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBd-0004Be-CW
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBb-0002iJ-5Q
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762042; x=1631298042;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X+EkLTge760E+RaPCXwiMO6C6k1oJWh6jTaQjwKLj7g=;
 b=n4G/bSZrYsd3Y/A7lJk1yVo7EykEgm15LpFx+ctVBlEmFmbTqgRGFrwl
 bVkDg2X+KJqfK7DmbJWoLeyfkO53jHHt9V+4o/o3I0/FdHZ88EfI3Axcy
 XcduLpbrubqU/FyLWv9uqaWejEGVxu3YS5xkDn6oEosWip1gAI9NardOM
 rBkOgn3yeU4fuMAYIFhtyXSDqy+rU1CTQOwCuaxBbDw+RW2r+vUH40yJw
 JK7ABZoRqtEqXpPP72h/seOmai4r8QB/7c9NDINGS6GT8mltvZaXXqq6/
 izZYtI4fFEEw8K58bGOYDb/Uc0+AbsLgOdLwI8dU4VsDo2iD8bLXD427G g==;
IronPort-SDR: /duqkYYr9twEa3AjHGR1sv+IdAg16zyju0M1WtpHEE+X4EkgOhPrkR3nFzPib9TLA7WxSPE3xB
 WyRjba/U/L5HvuDlcNW4Sx22jKL5IlDgq/KntTuBdrSyUW0k2yzKQ0Vn1bjz7OM0RpNhjYTkX6
 BdM65mDgvVrc3+f11BqZ71Y+qK3zgb1yzNjNIGvsI/qL7W/HWWrQm/qmZqM7JH+pK+kFvW9vdY
 23IQ5vsVGDLQITGo5RSX05ihA9HV01dltyDrRm9RVYe2kpOqY6IF95oM830qhXEVg6cBnZhVsW
 8ow=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979231"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:18 +0800
IronPort-SDR: OAygfP0Eyx339KpVQKiaLMGea58xaNDfYVNw5/6OCTseZ88KbZTCgD+DCoGxyu05fcCEfgBDpg
 YXHW5jBU8hXw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:35 -0700
IronPort-SDR: VqDL/9PMDiUi/0HXZv6BcVzuDw6DFmZVkkm7Im9LnaAA+quezsPYOOO+DkZEmStkD9X/iUFSt9
 LJk8flnGNLhg==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 13/30] hw/net: cadence_gem: Add a new 'phy-addr' property
Date: Thu, 10 Sep 2020 11:09:21 -0700
Message-Id: <20200910180938.584205-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, alistair23@gmail.com,
 Bin Meng <bin.meng@windriver.com>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the PHY address of the PHY connected to GEM is hard-coded
to either 23 (BOARD_PHY_ADDRESS) or 0. This might not be the case for
all boards. Add a new 'phy-addr' property so that board can specify
the PHY address for each GEM instance.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1598924352-89526-12-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/net/cadence_gem.h | 2 ++
 hw/net/cadence_gem.c         | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 54e646ff79..01c6189a24 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -73,6 +73,8 @@ typedef struct CadenceGEMState {
     /* Mask of register bits which are write 1 to clear */
     uint32_t regs_w1c[CADENCE_GEM_MAXREG];
 
+    /* PHY address */
+    uint8_t phy_addr;
     /* PHY registers backing store */
     uint16_t phy_regs[32];
 
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index a93b5c07ce..d80096bbe8 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1446,7 +1446,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
             uint32_t phy_addr, reg_num;
 
             phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
-            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
+            if (phy_addr == s->phy_addr || phy_addr == 0) {
                 reg_num = (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
                 retval &= 0xFFFF0000;
                 retval |= gem_phy_read(s, reg_num);
@@ -1569,7 +1569,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
             uint32_t phy_addr, reg_num;
 
             phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
-            if (phy_addr == BOARD_PHY_ADDRESS || phy_addr == 0) {
+            if (phy_addr == s->phy_addr || phy_addr == 0) {
                 reg_num = (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
                 gem_phy_write(s, reg_num, val);
             }
@@ -1682,6 +1682,7 @@ static Property gem_properties[] = {
     DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
     DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
                        GEM_MODID_VALUE),
+    DEFINE_PROP_UINT8("phy-addr", CadenceGEMState, phy_addr, BOARD_PHY_ADDRESS),
     DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
                       num_priority_queues, 1),
     DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
-- 
2.28.0


