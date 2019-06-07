Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FD4C468BE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BF520840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N0Ao6soL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BF520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNCG-0007yJ-Qj
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsb-0004q7-38
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsX-0002EM-4X
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsV-00029d-41; Fri, 07 Jun 2019 17:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944718; x=1591480718;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cjB62V2KEtHPar+ofR4sfzgKIk6//oGfIg0TBm9dQl8=;
 b=N0Ao6soLfV0bVFAT1UdNG4zkYxVC5ykYUc+3vxgvuMxes/p7EdWKaOyP
 2AUXwJU3Fu6tmovOzMy5QtRGRlo9dVKhrREmZeEA7gwWjC9hu24PAPW+k
 6mQbp/egJd8uwYfiZJkpeoN/CTbBOGrUlUpACr8cs53ZyNPgZ3MPYVNwD
 E2bClYlOLEYzzGQP5UCZ2tEOcWSE7VIBqzNzxQtbN/1hwOUbnMd2glsiJ
 8+0rflzpKa4cCN0sZYduWXuTG0VAzWSyqt/wJjDp0Gx8lgbeXzwJsvi/h
 /f9Rcl6qWZjotjbn1AIh+8sOz9SW5LzFvOhUn4Z2lGhgGm4meEbBeut/z w==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="209711283"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:28 +0800
IronPort-SDR: BB1Lz1yeTeMvczFBQgDVQncd1sSfANQ8ZuKAz+CquhytEcA6QKx5d2k8MqfuOW0pRxhZUEF+Oa
 WLE1NKpyswUGBlAt1r2GPA2Ewdn/C9In3Kzi/sLlOvD5LwguB/nvHPylle1MLD4YzlQqnhPxEQ
 wTwFKhQZ3iCKV1cu8x5zIqJKpwEagybLXnxh7DKTsRSoDOyuh/OzD3qY7RqtOFQ3KbTb20hNp+
 E210+XbZjfLt9AMlp452ur1YtvQ1kBMWBWzbdm507yadQo15WFl63yiKxxOxclbitPDXfsFfkT
 80DcA4Ss1O6/GrlzV2g02Guh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:33:13 -0700
IronPort-SDR: E3wNfM9kX3NjOLycpiEebLI1WHyTiCNBqiHZmaRAk2oJ6XMkUq5Y3syR5ja7ympjEhFgO9ownY
 yBL0w2DemMZrZ15/9ravpx5mcYpIE5d6m1gomYWcCPyoiX2k6PcfBflbPuM4B6cYmQAGPYB0KQ
 IgvmL3Nc7ZK56aGR6iECBrqtHqxCaR48r5ksfU6AAO7ZeFE6oWR/6mvgYDfL+Ws0ogieTPJ3dF
 cuLCDcvtjI6dqyYxyEIaClD2JJ0YFiGqIvH9seRYVg75s+HTHaneBOcuS0JB57jV9FFYJR9a0y
 mmg=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:11 -0700
Message-Id: <7b1a129161caffc16d473acea53861596d0c3d1e.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 16/27] riscv: plic: Always set sip.SEIP bit
 for HS
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

When the PLIC generates an interrupt ensure we always set it for the SIP
CSR that corresponds to the HS (V=0) register.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 1e7e4c8d51..25da29fa3d 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -147,7 +147,17 @@ static void sifive_plic_update(SiFivePLICState *plic)
             riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, BOOL_TO_MASK(level));
             break;
         case PLICMode_S:
-            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, BOOL_TO_MASK(level));
+            if (riscv_cpu_virt_enabled(env)) {
+                if (level) {
+                    atomic_or(&env->bsip, MIP_SEIP);
+                    g_assert(riscv_cpu_virt_enabled(env));
+                } else {
+                    atomic_and(&env->bsip, ~MIP_SEIP);
+                    g_assert(riscv_cpu_virt_enabled(env));
+                }
+            } else {
+                riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, BOOL_TO_MASK(level));
+            }
             break;
         default:
             break;
-- 
2.21.0


