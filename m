Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCD4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DA62074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qcYptYB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DA62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1KD-0000Ft-HJ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BS-0002Gu-Oo; Thu, 04 Jun 2020 21:30:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BQ-00009O-1n; Thu, 04 Jun 2020 21:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320608; x=1622856608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VtHdnJq5ImYv37heM2J1mv0YP2m+yGx3hpVtb9p+DiA=;
 b=qcYptYB8uQSvOO57C+UpZiLEk7rUmb0uXFD4L+bLJJlnZ0Svoo8vr+3i
 P1hsSbHx7kU7Afm66bTXYFB6DivYmfGrWGLIFJePlZ4abXQVkfkvOiPpL
 hPNlUp9B9vfWKTwk/US/IOQ4XgeQMeSm9D9+wh2AWIDy6edbDmf+q6cm0
 juMBn2lKcabuZz8bicpluVN7oj+kE0AXWrOujZm4Q02qnDRY/Nzki6nsD
 27eWpOducK+UM8GpDCmIuEk9Zhm/J0u25d8YNidLETjWYsKLFe9grDRuT
 nz+oR8ahdfW0NXlbLtPUj3arMyy1Y/xvW4YGWDrecFYGFzKC2F/0Rt89q g==;
IronPort-SDR: VuRJl+xwZy/NZuoMctTcMV5KP5MQNqoKSNLIq7gngRBnu6VeRiZySHl80l/GMfZRrJ0SvSEoyL
 6LyWRgZsUbjeo/3CQ/vD/DhkfVMKAURcd4NnItU8RKhKlyI3ZTdBi15UOzwPbBBjiXH90e82M9
 rsbd3IgBFCPCqLeo/WHTrY7cWT3cv1o8RbZCUFXoH+3+oPa6F++1FVBFz99kBdvNfq0ZNwZ06j
 dyN29TlqytcBCawUh76Lky/w0aTm0GN1AHjFCCkSM/19s7M8kYuMu2/erofrueEcaphxiXjcjW
 K1s=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="143573576"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:58 +0800
IronPort-SDR: H1suuYac7ZZvjgsDkv+XxPxlu6UQhGBS1fglnMxJPbgAfIu+V5K/KFWfxJKIV5TKNiGAPmM2lt
 XzMh8mxUpLrru5XJrgllHOrqDiyo32hdk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:00 -0700
IronPort-SDR: h9S6t3m3mgY0IO7IYUh3ux3o6KdwKC9uIkpKt/5UdnZ2J56YjCHI8I4dIvIDbKRT2oiX8DLwsf
 7EftvlPmIt7g==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 18:29:58 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 10/17] target/riscv: Fix the interrupt cause code
Date: Thu,  4 Jun 2020 18:21:09 -0700
Message-Id: <84cca34ad76360a24f69da609b03c8d21bdad603.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3b1a2f75ca..4ea39d5641 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -903,14 +903,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
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
2.26.2


