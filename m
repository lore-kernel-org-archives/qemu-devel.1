Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066A7C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B8120862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PA2dh/mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B8120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKHA-0000JR-Sm
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:11:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK49-0005Im-Cp
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuf-0004Gh-2F
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:47:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJue-00046f-Mp; Fri, 24 May 2019 19:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741670; x=1590277670;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=CblKzUydaPdK2Acz/EA2QEHx8CBOtgxc7KlVwn3Fylg=;
	b=PA2dh/mVW39E4Df8HyTgM3xSlc8u8R75oWf6+Cq39pSL0nwKWGV6qBko
	rWFjZjEX4FwTVb5URmGkF8nIiLNIW/1JwveLCLHEMxrcrb3RdZOWh3ASy
	30oe7/VlrFqdKlnHN5Ld97J6kHu8AXM1wLlYtgPyIjNgb385aVqeAhXz/
	v5qHrI1B3EZoB3yXPihhaD3Ez9Nzu9udqRxsavM3V1Bz+TvtsOn1nt9xd
	GHp8rTP1hqTxdNDQMajTcpjqGh2rgJKlVk2UUz37OByn34PqAkP0tkp0U
	d06C4ePFwDPSRvMV5j8KPFyqiwGo/Zh7izuyHv5RhXe+1iRiNtVB5xJUb Q==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="110307765"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:49 +0800
IronPort-SDR: s2BieHkjQTnc30J+tooQ/mPdIZOi4Uc1xvrsgJKxj9e2LVWeHm0oWIPh6GMxIsp9Y2XQJFaTfk
	8UBuJEYdfctBh3T0h6GXQVQ7KaeOaUdkj7pMIchwNynAOuAifTm8klIEAFydLccd07Hdi0zsEd
	hBFUXY1H/GZSfuN/0/6Z6vmSnau1hBsGM2GTxuhi+RIWU1Tter1arApvJRxfu7B9C/Ma3URt5d
	OKjUKOVceRs4q46Zn9T+Mzsl+Qts6sqd79zi2QnApZQfSBlB+gdLIh8uZ62pvKE8gTpvh5FjGM
	/TSiO9cHbQhxVR3GfnQoMmzo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:27 -0700
IronPort-SDR: 9IZHx4XQlvkj3vhX3JiPlaS4G9HineMSSqISM8pKwSiXiZEtrAmBA2Q2chU5vS09P6u12OlPjq
	fE4WaUvn34AM9bU3xVidA2naVboyjo7Jbr9sLCYyccnmg+/JfIGVy4+V0Bj5SxJGuqyMHsdPzu
	vsOBJ3OrZFemtAu6nVmhzgkywohmTa1L38DusQS3LQXbwEwOw+2TI7VZf9BVZOVsZO6J3Wxsom
	V9C927Tk9LkM/j79y6R2qx9D85QjbgpLlG6WNXMipnrz4lYJig+ByIEQ/bt7YZVDwQYe259pUC
	nBo=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:47:48 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:45:53 -0700
Message-Id: <6706cf56683e5a934ca90f0ea09d03987d86b608.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [RFC v1 07/23] target/riscv: Remove strict perm
 checking for CSR R/W
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The privledge check based on the CSR address mask 0x300 doesn't work
when using Hypervisor extensions so remove the check

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e6d68a9956..c1fcb795cd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -771,9 +771,8 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* check privileges and return -1 if check fails */
 #if !defined(CONFIG_USER_ONLY)
-    int csr_priv = get_field(csrno, 0x300);
     int read_only = get_field(csrno, 0xC00) == 3;
-    if ((write_mask && read_only) || (env->priv < csr_priv)) {
+    if (write_mask && read_only) {
         return -1;
     }
 #endif
-- 
2.21.0


