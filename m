Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F6AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92E821655
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HiqcWhh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92E821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JLq-0002G3-Ic
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBl-0000cn-GV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBj-0008Vu-2m
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBi-0008VO-Rq; Fri, 23 Aug 2019 19:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603736; x=1598139736;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4fCEIJykJaL9FzeuRrcOgwXmFygv+5KK+9CM95lLsXA=;
 b=HiqcWhh1SYpvm58Y6BxwxRe1eoMXuoUDy69FbNIjc4jX2OCRpBvoP3I2
 MxqOglbd9P/2cSdhuxdcqMda2jH/siw1nV+HPtWZk6Y/MQXLSaIpYMPGH
 edi4kkubpPeTISwg4HCb1ZeCPmk5+makNSiikaqOVnUzvpK4If1bMl2sS
 t64E6pT8ofxefW3k8qOyz0tgTXcqhlIkzHu1CRfqFukmBMI44hC851xw0
 LVcDSmYHy0Hpm5PZxdIaO+e0BGugZuih1kuODKcMO6bIjeCvSyPi8XCdE
 CogDbkNVBr5uqeSHoh7dgArZYeiDVXeh7TbseoVm/WDsLu3VjAQkXR3kR w==;
IronPort-SDR: w1HfI8idvD5gnZN9fWGmWCXzE8MFrmhJq7XHgGay1Cr8r/INzHIKrM/c/Q+9dvAVUH11lNKa07
 H4tu5LKGk5HKZC0jmGrOXgwufq1anKohichpABe02b2beWWY4x9IkTB0LvMRtEaBJY60I1q7EM
 Jm4hvH/NXXyvVommqNdmbcQk9x+MPge8QvHxEDpQhbdUiszbhgtLw3o8HBWa1chX7/iA2PfhrY
 S0cavmW6PF9cS65hChZ1bEBUg53wv/pgJVegGxZMuNQMke9r0y1FAQfoIiIGAs3L+2svEKzwTc
 65k=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="217013888"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:14 +0800
IronPort-SDR: 0DibZqr2OwVTTf8w711kl3ETWmSpfruFplgRuHxGsGk9H5mzZvKyvj/atnAghhfqSiRVlkYXmj
 7Z0VvhyuFsWLGoU+Jetx9EOF+JquMzmIjq+YZLLwalr7mOILgOVQ7Uzneza/oFc2BHeovwBimJ
 jqPPH1fn51LKe/lz890ILh6GF2q4ykZDJalHn3JW6h+bXWEySrTf+GusIISXtaET4Ag7Y4ClK7
 lrnUo+lp6dKxUTCiJgPEhnLVOQNc4C1PoNVbiEiF3AVOrGrNGC2PQC4ZkORvlbmChgfiITJ1qt
 xrqbhb3XM2175KJIM6oq2BEA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:03 -0700
IronPort-SDR: yqs5Gvo/AnL1lQUsdRc5WwW+RvUbcR4d4+686/o0EgWDMnGbVke5TLbTu6Q/sPJujGkyfCWfsX
 n0CPVUMt+BUM/8HeDbok5xdyI3lIVHPBdveeiCGRCcfZtzB22o7J2YDfs0c6UMUosJd/ZPWcHy
 ZWIBmpjHQ0Jth+HK6uU0G8JYThK2WENg+7TAf1Rov3iYPGuKnB6Nczj+KSi+K+G7OVw1wXEs75
 NffPsvGbbneE36q5A5c6+uyFo2DfFXa8OrzLdFXSEwjiX7Agi6NJJA1ZBXVPPgNhqaEHc5ur5Y
 Snw=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:41:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:05 -0700
Message-Id: <413539f43f6b9c120efd4c882ce7341ef3530b81.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 06/28] target/riscv: Print priv and virt in
 disas log
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index adeddb85f6..8ac72c6470 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -810,7 +810,15 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
 static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
 {
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *rvcpu = RISCV_CPU(cpu);
+    CPURISCVState *env = &rvcpu->env;
+#endif
+
     qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+#ifndef CONFIG_USER_ONLY
+    qemu_log("Priv: "TARGET_FMT_ld"; Virt: "TARGET_FMT_ld"\n", env->priv, env->virt);
+#endif
     log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
 }
 
-- 
2.22.0


