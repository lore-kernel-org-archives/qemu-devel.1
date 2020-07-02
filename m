Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD04C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65D920720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hGESMtAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65D920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2CF-0001L9-Rz
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29Z-0003YQ-SH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29X-0000AD-UF
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707615; x=1625243615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D2Vh/QRpt0AodHQ6EDxh6Wqu+PBuRVSvD9geAaTNtds=;
 b=hGESMtAxNnCVVnsWw+O54URWMiuWdt8+CzWPOmQifp+HLvsHQKXS6WGT
 Q7YQ2BzH+khaBUleohHd6hog83rzSWMXFBB2yl0RaZjBtr191JiG7q04W
 4P9newLt/ndOaLfbqA9l/pkKY50sT/zh3fBOUNO+Ju/i6LvLKgcdgkCwR
 79xrAA2BN8vN8VMHVn1BLE49pscKg/qAHIuBEVxiscZlwY5adhZHZA6T9
 ByIcDQOIFZz+WOCtixkpTAeamtbUJmzSCIp16Z1oP5j1pnHPwExBVDOJc
 Wq+9wNfV4kJgV3ezPuj/StKb5dnn6lhc2JpMtpY4i418yy04VQtGVAW4H A==;
IronPort-SDR: oGYTJ7UemHNF5lBZg+rU5k8g+IswRE88ZEs/yZl+2lR7Gy/F4c0DGIXZp+UzbCd383boGPwG2S
 NM/nig4JSdNx8Wr9wZ0mcdhl195vdHCYrR4YqyPCnQtBSMjcVdK2CV/L30crvBsLM+tQButwcC
 kMW0IGxuRfTlpJRtQWem/rIn86bTXDjXEcYRQWRZv1OFTSCNlI1YLFTqO+JyEVRaN8Hc2ORoxp
 AUDY6DxXDfrRkpoRHD8nU8FZymy0Y70R7snOACCCNsFv876WpRtpuKeGsi2wbSIWjywA3n5n2L
 14A=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498463"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:20 +0800
IronPort-SDR: 6O0He1zUgHEun4hTFDsnyPjvPg6iIiP1IdIHMUOp39qlxo0AE163oYHSaMnm2lf67Ar2L0nNDg
 HrJqzqj0DapmJMtp2Fz79gjcelgCkyW+E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:35 -0700
IronPort-SDR: +BtPlX/Lvl35HspGrH+u6gie+KDDcbsSigaVvfddsNkDBgXuO3cAFqVXPkmSu7vDw7gGwOffWp
 o+fyErEQ2ilg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 03/64] hw/riscv: Allow 64 bit access to SiFive CLINT
Date: Thu,  2 Jul 2020 09:22:53 -0700
Message-Id: <20200702162354.928528-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 5d971f9e672507210e77d020d89e0e89165c8fc9
"memory: Revert "memory: accept mismatching sizes in
memory_region_access_valid"" broke most RISC-V boards as they do 64 bit
accesses to the CLINT and QEMU would trigger a fault. Fix this failure
by allowing 8 byte accesses.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei<zhiwei_liu@c-sky.com>
Message-Id: <122b78825b077e4dfd39b444d3a46fe894a7804c.1593547870.git.alistair.francis@wdc.com>
---
 hw/riscv/sifive_clint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index b11ffa0edc..669c21adc2 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -181,7 +181,7 @@ static const MemoryRegionOps sifive_clint_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
-        .max_access_size = 4
+        .max_access_size = 8
     }
 };
 
-- 
2.27.0


