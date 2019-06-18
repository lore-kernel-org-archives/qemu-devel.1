Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEE4C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8D02082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MYOC1BCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8D02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd33o-0000KU-LX
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd309-0006cs-PK
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd308-0008Ue-NY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd308-0008Ta-Ec; Mon, 17 Jun 2019 21:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821612; x=1592357612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fQX+cG1dHeaRtULmRePJFSd6JTXSO12ulMWO1V2QRmM=;
 b=MYOC1BCozjgb87Rjk92azcqd8ptHW8nb3+HyhWg+hJ3/kAtQERQxcbZ/
 cy0SjsPsoJ+v2pw4ut/p3Q+zuxFOiBNWC0nnl2SmM29xK4QksXwcc8N+I
 /zX5tF3Y6AqVGZmpyABkmNLA1Ze8m5M3P5ff4OFRpqltUcdRspQZ3ALcU
 sdUM+SYs0tDL1uZOODYcSH/vF38z7vCXiBMDZ2STQkT6X9pdkCPn2lHL9
 dqcVQPJUzUtnNylPrgz8g+w1KqKh0OJ0kD1EqKSO5xBGzJw+ooie8r/Dg
 k9V9YfROJPRsmmJhlc8UGZPKHGwUII6DesseBNqTC/zFtKPGRYLk0RvT0 Q==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="112457248"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:31 +0800
IronPort-SDR: NQSOEOZiLa4568M+FVKFKvvyq2EameQZqdrkof07Ax8bpixmr4BNMU4Au6RMMOFjOQcII2a+nN
 fshcX80/9Mbdpd/vdQGAibyNO9BXGtdE8kNudiM0jf6Qj12s6j5Lt+16equn5eHtL7YdWs88aM
 q7o4iqkmGasMRrPgRVPgEc2lloOYTaGNnI2kf9efOtKwhutVC/6GMB88IIZm7D6N6dM9rkBHZ8
 qNrHFQl/LcY0BgG79EgypVIO7t3XbjcYkCyuSMxx06F1fHz80f5hG7j0LtgkjTxADegIszM4Zg
 pqtx8VQBnDEIg+PD2KwZ0jS3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 18:33:01 -0700
IronPort-SDR: PnhoWeBSZG2DKf0SQU9P6AF2lge+IA7BxVUUis0mxYjgcpYY8FoPcsNal+MiWkIgfcgizQ7vYX
 TH55qx0pFtg8RnJtRcRjXtujxJKFMFNe0gtNFMR+MNi4NgZt30XbNHxmgCeWvQrpsmJQ8wvFmM
 9hWvqnysb5v/ubdnxKD371Zca2r6Ms+epFZwlfIbSF9JwjTveqL3kEP78txqntxL/3q6myZy8w
 bzB7dc5PAi3fOstwggdD+j8iB1JC9SsAAtboqlj5HWigh8upDi8EMclrqmKy0EyS3Vnksg0sm4
 Qh8=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2019 18:33:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:11 -0700
Message-Id: <313968903b6233d286c32bb0f52ac1620033a761.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 4/9] target/riscv: Set privledge spec 1.11.0
 as default
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set the priv spec version 1.11.0 as the default and allow selecting it
via the command line.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a4dd7ae6fc..a23d83921a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -111,7 +111,7 @@ static void riscv_any_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
+    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_11_0);
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
@@ -316,7 +316,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPU *cpu = RISCV_CPU(dev);
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
-    int priv_version = PRIV_VERSION_1_10_0;
+    int priv_version = PRIV_VERSION_1_11_0;
     int user_version = USER_VERSION_2_02_0;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
@@ -328,7 +328,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     if (cpu->cfg.priv_spec) {
-        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
+        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
+            priv_version = PRIV_VERSION_1_11_0;
+        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
             priv_version = PRIV_VERSION_1_10_0;
         } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
             priv_version = PRIV_VERSION_1_09_1;
-- 
2.22.0


