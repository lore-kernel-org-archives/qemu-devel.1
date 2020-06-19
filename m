Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BC4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F01F20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gfOQFyPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F01F20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKdX-0006LM-B2
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUH-0000lz-Fw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUF-0004PZ-4v
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586451; x=1624122451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wjfXyN3NWwu3m0SqemYRz9ib0aF+Yfq0vhP7wPn1ngY=;
 b=gfOQFyPFNEVW4aNTkEvw4IzSys0XSMISnoz4l/NggEnM8uB0qiHd+Hme
 oiRPdGHlBkHoYQOj/Ub50m2jJwnFfAdE3tCFpiX4uIc43wxpSf83yroz6
 uHHM56DIx8MXqCKTmSm762RXp3LbZPr6nA4IAIJ0zaxM6IsHmjnl2fOuU
 6a7n5lKz/EtAhslTjtEQPxFrzRF74/paBAy9FhxQaOJXkUy6IEO59Hixd
 NQDo10Agtpf276vhYxSnIHIoDy6GK6c01HtRnJWOY1bmyzZq98114bl2K
 2ObmnMQGcsUWx3Fg6HKKygPguVXTlwbO1o5U4jBPOLnHokytWULMfEklN Q==;
IronPort-SDR: e6b6lBzoAGL9cJCUQpjBbTpwXOd5yZarGSMVyrPZO6kM4jtTjGXwgPu/fiqJrnSQfeeXyzxoDe
 VuiYTE8jsgc4evIcuOHWft6iygfwopQS2fvj17Onsa3p8Peyp5hKhfUKYxlhPCfQRWzEUd1k3Z
 xFsrOp6Aa8jo9/wEamrOIdcfGicB9F0OKMRhqbhBU5IEp+9tnUVa5yxjVfMuiAA+5HWfQY77oe
 y535ESfZO2RciwohZJIspgjQSfhxmRf4WKl28BQ13oSYtXhDWJakoXLYnoHvi0kTOn8O2jfe+d
 CrY=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="144763319"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:23 +0800
IronPort-SDR: XGv3vJ+ayckV9rSoEOMzT20sDF9ycmuz/5wu2sVvdUPiU3hETfFLj7hOyL0Jsj6rcSdavEb/dQ
 DHT7FWRd5hrGxAPrwkzH/NoMAMauxWHYM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:00 -0700
IronPort-SDR: whcHO7l//rMB7SOXYwPqHww4eOE4VW91W6ARn71S6Xyz2rplSVBeqHAGxl56KYH+uYfbS8bvU6
 6pLfTtIGWc9w==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 08/32] target/riscv: Report errors validating 2nd-stage PTEs
Date: Fri, 19 Jun 2020 09:57:53 -0700
Message-Id: <20200619165817.4144200-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:21
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index eda7057663..75d2ae3434 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -435,8 +435,13 @@ restart:
             hwaddr vbase;
 
             /* Do the second stage translation on the base PTE address. */
-            get_physical_address(env, &vbase, &vbase_prot, base, MMU_DATA_LOAD,
-                                 mmu_idx, false, true);
+            int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
+                                                 base, MMU_DATA_LOAD,
+                                                 mmu_idx, false, true);
+
+            if (vbase_ret != TRANSLATE_SUCCESS) {
+                return vbase_ret;
+            }
 
             pte_addr = vbase + idx * ptesize;
         } else {
-- 
2.27.0


