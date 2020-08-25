Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6201C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8E72074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eOCo1Vr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8E72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeHU-00088J-Or
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAB-00045w-Fh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeA8-0002vn-Tp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381958; x=1629917958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yV+tDkE0bdWABVC0vficSUBZAISIRPE0qfR9dB7A1Ac=;
 b=eOCo1Vr0EYEd6oUMKay4sN+UcMqSnHIo9QsVTqMlKINAp4FFm+g15N59
 5/Zjx6XdTIJ+Gdab+HV4YBLM1f3OFyVCMkhvCl06HqRZTejrEZAdmxwsK
 ZyJkvn7dvNx/BMknAkMC7UXE7Ihy37GfiPOwyx7oq0X8kyHmay3nQNzGz
 5jhsWOf4c8PY7C4Lz77UdoLv1JzldUFLDgfRtHRHwTnICp3OZHo/fM5jD
 76LZUi7kKn8t8aHTWPOGC6Cvwz99v+2galAA3MMRCSEbWBCHRB5jAjEAg
 SLTLl3G/qCZURwiK8xdc7Ld0hdah+fmus19sMY6Orpm788vFQofv6aK2V Q==;
IronPort-SDR: do2KZ6pHDUAPnu/8Kq3nxB6vjVOZEBcyZDKZBLC8viCE6/jG/3ZthNDxjyg35S4OpqHCCnrEb5
 grs/rS9cBtnLMbeVcnjdFmAruKdsMA/9jt1JmJs/AP2ga/rvsqstZnLe0tnevaesXF175ImQLL
 qNGlNei3zAo4sOtZtHCp6FHWGPewghhJOtJ37cTaFrNnBNFOdodm3hmelAAHafR5j8zWBDNAO0
 FG9aNgr/zqXpC7LRFviNxpgVCtQCuJZISvUH+4yo3gmLe/vhHUT0MxLVlt/wkyiiX6aj8spuVM
 +xE=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145293"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:57 +0800
IronPort-SDR: iICafPTWUCyyMBLmXVwO+RmuMcA6ueszf+b25/C3KgybmnNvd/KsssmNyDqBS/In1mgAjSEzkX
 I6Vqb8bUkYsQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:32 -0700
IronPort-SDR: JH2hvVqGynwZjwoAW2SLX6tO/tS6IeG3ic0rflYoFJ9JfuYYyaTN87h0vZGtOQxB63an2N2IAv
 l/+EegNPlmzw==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:55 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] target/riscv: Fix the interrupt cause code
Date: Tue, 25 Aug 2020 11:48:29 -0700
Message-Id: <20200825184836.1282371-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 85b7fdba8abd87adb83275cdc3043ce35a1ed5c3.1597259519.git.alistair.francis@wdc.com
Message-Id: <85b7fdba8abd87adb83275cdc3043ce35a1ed5c3.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0b4ad4bf46..661e790fdc 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -916,14 +916,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
             if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
                 !force_hs_execp) {
+                /* Trap to VS mode */
                 /*
                  * See if we need to adjust cause. Yes if its VS mode interrupt
                  * no if hypervisor has delegated one of hs mode's interrupt
                  */
                 if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
-                    cause == IRQ_VS_EXT)
+                    cause == IRQ_VS_EXT) {
                     cause = cause - 1;
-                /* Trap to VS mode */
+                }
                 env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 0);
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
-- 
2.28.0


