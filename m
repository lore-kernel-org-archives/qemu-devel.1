Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3287C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B37207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JfLbaKfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B37207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI5i-0007aC-RP
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4i-0005vb-Il
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4g-0002hc-Rh
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595437114; x=1626973114;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eahIFHRMeR0LnO7tgOyPitM8oejJA4NIGSEjXK5pM8o=;
 b=JfLbaKfHLP6/A91sqdn17maa3QWtVjc4Kf7Vuvgl8HOmTDsFWFf/x8B8
 OwTtP5+BnoaJ1+uhOWaWGVfOg72SpicDWlW1Prpiq7GTNJZMG6E2kRdHI
 GUOkjVesDF6OJSdYFvC+WEHi1grHSubvlCa32GBAtRG/WVbOcUzlV0hFp
 EbTwR83fLTohCPcEQ/0juwoXvpXkqMmHHAWUuc5NCJhcuKzSv3ktPYQE3
 pCPSu1cXLhXL1fvUsnRdrZYl3mmRYD4BONHDqoKNpNHDH/7YElzoNONSC
 xUDl1WJX0NQuwB5ULZNqprnBFvkBf5KlCf4b94Oe/GSX92WYb8U2R1M3C w==;
IronPort-SDR: 48AHoJKr2inbsLChdOCOXuDtGORRtuid25aSnNrTAK4RDrWemlmBCawn+kNZP8MtSEyraINwg5
 Y/f92elLhS5GkEhmYo9Y4LWZI+7xRtLoo2dH2SQEet1W+5nOp1RQErsm3IpJ9oTEGfj7gcgVqM
 /wt6S1RH9FxFprTl8WNaycVGDnuIrcmZc/MaUW7l3AhpAnSyeITNEyYR6co8UA2MoZBB9ALRcb
 hYmNzxOduAIRntkzJV6Aq9lpplscs27ae1pGpj//tqkeAiJc3mLG7JpknWKRUmnRgY3M9uY8qV
 0K0=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; d="scan'208";a="252418635"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2020 00:58:21 +0800
IronPort-SDR: jFJyApldowyMXXzxnJsDX+JWKwxIcLaLYw7RU91W/b1L3CRKoeXhvup1jwPI1Er/DH8HdIy6rT
 9+GfqqhuJ8QPRXmvs/zLFKLKai/+EkliU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 09:46:38 -0700
IronPort-SDR: D+NuNUA7RVmU2zAKy1+pSyUxkRjF76Gb58HiZValYhdkd0+LDAZ72h0cn6ADnYj70zxYtzFGhI
 pzq4NGdIudTw==
WDCIronportException: Internal
Received: from usa001575.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.115])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Jul 2020 09:58:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] target/riscv: Quiet Coverity complains about vamo*
Date: Wed, 22 Jul 2020 09:48:35 -0700
Message-Id: <20200722164838.1591305-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164838.1591305-1-alistair.francis@wdc.com>
References: <20200722164838.1591305-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=465c3c755=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 12:58:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200721133742.2298-1-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c0b7375927..7b4752b911 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -733,6 +733,7 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
             g_assert_not_reached();
 #endif
         } else {
+            assert(seq < ARRAY_SIZE(fnsw));
             fn = fnsw[seq];
         }
     }
-- 
2.27.0


