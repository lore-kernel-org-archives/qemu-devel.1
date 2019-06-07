Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82465C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEF520840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ddDjH/KT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEF520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNFE-0003FP-HI
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsX-0004ny-3l
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsU-0002CV-PH
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsP-00026x-GZ; Fri, 07 Jun 2019 17:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944701; x=1591480701;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gGFuqft3Gy+jQsmp9J8ov+i4/Ieho2R14R8oFQ3Co8Y=;
 b=ddDjH/KTwiZJfWqtotw33DW7xbb9i5ZEXXzzVagI0tdeqMOpyO83vUpX
 oe+A38xvWN4LZulZ/dU9tVaIjdk9E7BzG3pefZVJuhXxbPDFejbVFBu1z
 adN/414AoEEyo0tr55gr5jlmUaQwuBsp8lr9Ql1dFOOVFf5s3eFyYdE5q
 3/oVLs3i5eRKJbh9eKhtrpCSDDM9EG4C0fpLFA0S2GKLu76l/Pim3BMHh
 fGszX/VZr97r8h3XkxlYCZDiRGPD9RIUKHx9eD5bepC/VU/xWlbZ7WzYC
 XNQP07cZ0PHHXFTizBYiV4ugN6uWjMfttx7bUjZqRFthLUK6itU99Se8K g==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="111342563"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:14 +0800
IronPort-SDR: 9MeOQndkkDRPWhpT/SKaS95N91QMbRn2T6dibyjN2jmuG4QY6rgI6UwHYIpMXXpzQIeIeAkzcG
 BVO7A1CY5ANUVVEvhCdSUaocElz8BevcSKPiMx1X7MIQNx/cBmJdgWJRjQvrJHscuuTcEd+H7m
 BWhjohZwAOIBQv8XB0IVBtDSf4X+plDNvMeTGACGE8k8Dp8jDt4GHbcMSvb7ZFRi2ghIvuViyb
 MtrFs75acXvHgLjjbAyblcMMZs5hvVeWYzdhs1Xy39alRqHldHWf79+IHCgNiQ+rHuTUcLpzCc
 2yxdT22Sw7JcNDXvxqMi/jfh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:33:06 -0700
IronPort-SDR: TC2oH1R41BcXu/z6Xv0gyN5CebPw5jbzEnMAT3zAujhtga0FEL40VFawciUiDpxZql3+CYjs/G
 CWrU1K0vfmGV792ShbdCacb5Mmjfrr4akNHl3VLyd+Q8QpVsnyrDO0yzgal9D7RahsqX/R6v+6
 +8o3OSk4GYeOiyYqy83vi00b9RUGIy2TlWQtJQpvB30QYqWb01xhfFp5T+gWLjD0WTTbNv8NyG
 zMJjU+TPKWdPVf4w0sKaRqN6ZkgOCj/UNA/83MmppSFrmcYp8Om45ADzxA0bdtCRSVqvBGD//M
 /p4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:13 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:04 -0700
Message-Id: <d24b49911b8bc15f734111a8a5ce108b92dd14fe.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 14/27] target/riscv: Generate illegal
 instruction on WFI when V=1
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 644d0fb35f..e08bb8dd5a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -130,9 +130,10 @@ void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = CPU(riscv_env_get_cpu(env));
 
-    if (env->priv == PRV_S &&
+    if ((env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TW)) {
+        get_field(env->mstatus, MSTATUS_TW)) ||
+        riscv_cpu_virt_enabled(env)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted = 1;
-- 
2.21.0


