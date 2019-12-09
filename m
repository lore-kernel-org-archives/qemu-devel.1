Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ABCC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242E9207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F6jO8qVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242E9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNtr-0000bK-Kt
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaw-0007Zk-NW
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNav-0007Xf-Or
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:18 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28155)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNav-0007TS-Fp; Mon, 09 Dec 2019 13:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915437; x=1607451437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TFSujUNdp0fo5gAIrnEbfPJsI1zPU918UV3JpgTjZL8=;
 b=F6jO8qVfEFlIkZctV86NO566xzgUPV0njeGtvl+hhfkbqvdHsRo0DJyR
 2+LgJcNQusC8nk08H+svlJKczGaowD34WXHkBugEwLNnSCYk7a2eJSRdX
 CjUF9Yp3po4AV9bydKMoKVO5dT18WCnmbAsBaa7M89MYNsajTDsjDWWd4
 Rt8LUfUXhTqZu6nLlrFjU74bgdGQAxJRa3i0R1qc5hdNYFG5VY4HN2l77
 beZjzHt+e0Vmd1av4geDt7XICIvf0GBQuZeo7GuKP9U72rlv+yw2/ouPn
 QEPDPatXI/aMH7hJ6Awj+m9Fwdml5T9nkI9+vOPHGMvspH5xKMUObJibo g==;
IronPort-SDR: u6jASHphV8PHKQSJGmF5Qr+2H/9vZ3po/tGaFSsM8L5tWKjpngK2W8mh0g80DDBj0fFZxZOp0n
 aNWNN8UAelVsDbcPrGsXL3zh6eny8pCHkwHQciRghDHSEoWzJJZGmJ1y1XRFHSeZahJclnC7yN
 q3g2jIf0ndCBMo3JB28lwVSlHJVpt6Kvcqc5lmpswwgopDwF8CT/kg6BNJdekcc9srsQFkeCp2
 EWLq9cviseYPUcF/puYFgJAajFxb+QBOkC7QW1cESHOVmb5NVMI1EZzZRwcy5t6UNfbhhngWcc
 Q3A=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="232461567"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:17 +0800
IronPort-SDR: epEIDOkEFfExFIDGFPtGlU7mRPXEkrrswQk1CxKG5W695AdeDCeN+BJRkylOd8BUldRz24DlFj
 6H3QbQ5QkocyDp2ALIB9fiV7VSeeVEmZ05j4nOPC+EGphgx+F+1FZ1SdyywA47TH3lSzmF8kBE
 uIXc+/UeO8F8iQzMgdLOCmmZbiXbaBrA/SKMQqTxVfm6TpNTOtwCpfdNjmEYlyNo+AMzvx8Ujx
 LnGiOt9+gi0QheVol+ycMj9T9yt81u3J7inf143DeL6BeHbIdFUQZxY2T0R/s4WHyNyS3k7iud
 NGqFB+CynzsMz/40dFoawlc2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:33 -0800
IronPort-SDR: v5Roef3/032ULFTDUhDn59Nc0BqOW0C9tVGptykmuKPEFG1Kj6u24HlTs36+7BbrdG0a4gN1lM
 wFjMm3slknIyRRdlfROQzDhHjMlaFXfbbwbaJz871iwu3DWD571Tj2J1uQoJ4/MWqpdGAOksRh
 RJyuOlwt7GYFDq42MJ+VEuxvnkoaBfWZ4n48fpllS7Jg4wC2odch8axQizjnoqmdwRqcZdoMK7
 jegYdvQp+YCEUZ5DZgd1b4V6KR/oP9NWNnRKjpoPtFX8NAVHm1u+d5ILcOzSxYnZZZQ6ovXn79
 V/E=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:16 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 21/36] target/ricsv: Flush the TLB on virtulisation mode
 changes
Date: Mon,  9 Dec 2019 10:11:35 -0800
Message-Id: <a2d1713d75b21824bee2fe71a2633acef4c22ba7.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

To ensure our TLB isn't out-of-date we flush it on all virt mode
changes. Unlike priv mode this isn't saved in the mmu_idx as all
guests share V=1. The easiest option is just to flush on all changes.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 85eed5d885..1b747abf93 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -183,6 +183,11 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
         return;
     }
 
+    /* Flush the TLB on all virt mode changes. */
+    if (get_field(env->virt, VIRT_ONOFF) != enable) {
+        tlb_flush(env_cpu(env));
+    }
+
     env->virt = set_field(env->virt, VIRT_ONOFF, enable);
 }
 
-- 
2.24.0


