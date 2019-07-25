Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C70C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7815121901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AkEix6PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7815121901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqiu3-0007b8-49
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitV-0005ew-Gq
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitU-0007dh-96
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitT-0007UQ-SM; Thu, 25 Jul 2019 14:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564080911; x=1595616911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EJ3uFZZabIT3D1zyawbbKwPEg2qaJISOTAapF4gpgfU=;
 b=AkEix6PDBtLgYl1JqRdcN4W+0vgNcpBPhN5JCKoD5JOq5Vbk70aP0+Fy
 yHE4gA8zu1SiWIPSmI7EjNEIWTHzgPNrJyHqG8mwWAWXm27MJBQx7c/2P
 msqD+O0Lom43ea2qm3R5e78WbodOz9zlDvMVecsnQIu8HcmcgeGWABk+m
 DiIGD2ebpI+Shdlzcc7R0qt5HwEwAKEx3Bu1hE80jQfXinnIUR7UnQ/fW
 mvO3JtB+705vPDgYqt8RIGxNTOKZmpFD7cS5BASWiNO3wro+xpZATwnCA
 O6WdXn+DLlPhgQR5CMkrUkVSq6dj/IINSiI2CH0HL6HCB+XTzScmznciH Q==;
IronPort-SDR: sx1mJopsky+qJZlGx+Y6zFilryfY8gaXmu8Vb2YDmtCsI+Lmgpax8x2eQpEYm5bw3OU9bZq2n1
 HB1/dbUokGoO4y3SZeFmi+QXOGk6YgNdeFPbAxB7jjuyT/AogQ+WjoI0OoMAkTjx3N8quPjIGq
 BW7PaFahtSmLWNx6UZidW01+sIDxOqLtD68Hj7cdhsWQL5lIaaNIDOiRHbx0I2mFdylhDi2yPl
 sja6QKjalHkcrxdY6wvZFKgavOaEyEDgA0DbQcSDJLGWMe44mdLVJ8Cf9mAtJppLhwRmQH/qkq
 kBQ=
X-IronPort-AV: E=Sophos;i="5.64,307,1559491200"; d="scan'208";a="220533146"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 02:55:11 +0800
IronPort-SDR: 99HHwb4xkZtL5/ni0EKtolBE9EMSV/IVhAcgybQaFUxXAKFs/GM+rqj0US19d/ROQzdpxwWYCO
 SBJoRpyitQKEZNPv7qqvfrsc+lKH6hrvoeHON7IL7xJGQxDXN1KICajkePwuupJnPcb0PVTbFf
 OmSZcxKeHd/XqAazqBGu7pcdYyFKMv0Sb48O4uxGfX4QXH6zP6sIZyksal7z5SwvB9MDBJBhHs
 AskGjYehkQMloMuYQ/uieNyGVongNqTVByWZo5NvwjGb9TLmSysGRXaeGMOKDvsscw38NKvm0w
 tBg0IuzeClDv+Lh0dWnZOrri
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 25 Jul 2019 11:53:21 -0700
IronPort-SDR: s8+XNtcn5cE//zb7iXmq1VV3grqsx0CFxxwZmbXymO89CoKnSBRljAW0CDlTbJtal3xZ8l7Bek
 RNK7B2JYr2L8kjc9WGwpoixRQ36+WSHLPd/3fgPPlLZ+ua3oAbfDNVdR7uU0Kz7aft1ZV/ivhJ
 i90tCx/J5KWV9xDBokSdJ+4RhDd08Kq5e9gjzckiZRL4VRQcz10TRCYx854A4BOlSMGWL8UcOe
 JOYTIftezUdh1AeTu+o6XE4DTtI8Q41vNE9Jc9zb7TrE62CfJoIvXoAtJhc0aa4zkwRFORzbeb
 MGQ=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Jul 2019 11:55:11 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 25 Jul 2019 11:52:06 -0700
Message-Id: <50c1c6a3ace8b40f7b9d5395a2c3457cf1852721.1564080680.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564080680.git.alistair.francis@wdc.com>
References: <cover.1564080680.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH-4.2 v1 3/6] riscv: plic: Remove unused
 interrupt functions
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
 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 0950e89e15..864a1bed42 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -161,18 +161,6 @@ static void sifive_plic_update(SiFivePLICState *plic)
     }
 }
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, true);
-    sifive_plic_update(plic);
-}
-
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, false);
-    sifive_plic_update(plic);
-}
-
 static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
 {
     int i, j;
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index ce8907f6aa..3b8a623919 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -69,9 +69,6 @@ typedef struct SiFivePLICState {
     uint32_t aperture_size;
 } SiFivePLICState;
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq);
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq);
-
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t num_sources, uint32_t num_priorities,
     uint32_t priority_base, uint32_t pending_base,
-- 
2.22.0


