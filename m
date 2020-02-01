Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C53C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B934C20663
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V2tr9Zum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B934C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhcS-0007jr-Sr
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJO-0005hF-1p
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJN-0007ST-36
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:11:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJM-0006JU-QP; Fri, 31 Jan 2020 20:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519460; x=1612055460;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dEQS3N7XmNSSFaopgzYel+mWnqSFqq8SNAeeLlwuAfw=;
 b=V2tr9ZumELj0KSy8xOMmOmXSrvPVGXYnkbm7JMCP13PYNZjoxaypNprw
 TXViUnNhAbZl8/Dzax7NZQMCJn/F0r3UdZg8bazo5I2ymlJGgeSxE6pRu
 jm5qQrMDMThega97lX1IyB+WUc44XHz2/PPvPg54W3Zocw1gl89Tbav8f
 PMdqRFaHLVHZfaX0ZIe30NO3SRkBmPxTxBt1JPPkKdzEsougLGy0cOazc
 sSMUFy62Rv4ouHN6LgtcdzKMRdboP3THOYM2DRNiDmtYxfKblj6hQUM4i
 En4id0GGInicfVEjWu4WpJlcI3EoUh4SN65FWCfpbP9Ek2/Ac/sLTBp2p w==;
IronPort-SDR: ND0kWEa7oG5P/gSOINgIel4HFufr7uTjXZQRkLDxZCeVM09HkbG+UciS8t0L8LQ6ktd0KPxvrd
 h8Rd+6TUzyNpsl2kQQGae9iFZFY8dcrpmo5mu1DcrNFZsZz4Ey1kNQdGPzJuyD29QS3Ncvdri+
 7tyDaivHiEtwQKvkobQMuPDPixy57OuqNDCEMuBjcBrt1WXd9stLTYd7lh/YfNDu3YDW7hjV1Y
 SonXG07tfJ7obHdkW2OlB/snayg+wV1tzZwaiHuOCP7frCSXAVmRMRKU356smGeC3nihESTVFS
 NHE=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872504"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:48 +0800
IronPort-SDR: PEwGxSF3L7iOvFPDRQ1auG/n5CYd4ZfdkJPaDOfuIIrLyPtkh5m1DYRwyngkhd0O5BhkF1p8NZ
 TUkQe3PZLz6rnnS5gIflJ+F2o36EHJaqwx96OVGU7ss5KqUsNPUI7J0fjFUY3sSO+1JZAz+ayr
 xHKtJOSGbgtRN7VompYz1/PoxsyR4Eq0pUUxNNQXqouTtAgbHbbdvhTCujZaoomtprTRf74Dhs
 h+kiKucNiGI1H6P4nWFpQjriVO/w2r+KADfKv9ggL4ZKjjQ8LZvdLfTOOes7MCRfmmnmGs4dKL
 bAhKvx4yqGNJcfC2D3A11MtB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:56 -0800
IronPort-SDR: kJv4+SafGc2U0S2L1/DdkMT8oV3GE3oh4kX2nTEwclwM9vvuRzrCZCli//x76CO6wXTLekTW7M
 soBSBqW6bdvcVba7BhanL0P/8neXU1uzGUF7zts9zxK0+tKUrKa9S7PkrQPzbbYkIDt+TsM7gU
 7TGbpyPWNzDWFTcwANFCn2MH9Jg/vdm82kUGL3SWKwOyoCSgxkpKziQEFBbjhlEi+c6Y1pGy0m
 9x1JSCx7JsknXmmPGb3nAIclTEByhTBheVE33GpslmM5aZRH+fL95MHXkE6gJrPuPEJa6uCmEi
 DoU=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:09:48 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 35/35] target/riscv: Allow enabling the Hypervisor extension
Date: Fri, 31 Jan 2020 17:03:11 -0800
Message-Id: <507f36b2e9ce8bbd5f32c8139d1a5727723f5287.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 5 +++++
 target/riscv/cpu.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b27066f6a7..c47d10b739 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -453,6 +453,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         if (cpu->cfg.ext_u) {
             target_misa |= RVU;
         }
+        if (cpu->cfg.ext_h) {
+            target_misa |= RVH;
+        }
 
         set_misa(env, RVXLEN | target_misa);
     }
@@ -488,6 +491,8 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
     DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
+    /* This is experimental so mark with 'x-' */
+    DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6f9c29322a..d52f209361 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -258,6 +258,7 @@ typedef struct RISCVCPU {
         bool ext_c;
         bool ext_s;
         bool ext_u;
+        bool ext_h;
         bool ext_counters;
         bool ext_ifencei;
         bool ext_icsr;
-- 
2.25.0


