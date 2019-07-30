Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B42C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C872067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YiaQ+8lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C872067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsbik-0006T6-5k
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhQ-0005JG-DK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhP-0001tj-7f
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhO-0001jk-VU; Tue, 30 Jul 2019 19:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564529911; x=1596065911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4KhMKveagWI7BDqokS3HdF3E2uSk0r+2CqujjD2dHoA=;
 b=YiaQ+8lG+0NNdwFnELEEmlDWQF417TPjfuYUAIOF5KTroSwi7vAotOL7
 8gQdyA+793A/r2hp3ADBQgx/vpcRaoS9Z2dNhkKIuxcLD26ETH6eLLuDC
 BYwYOpS4XOFzdlFV7r2rJENyHk6sPPUh51Q2g8LVn+r2ytt4qo1+t51Yt
 j3MahhcefOk25fgnDHgc1TUyBXg7eN7o3yhSrY9WZ+tBcaFznHEDSQXG/
 U80+cI02hSCPd3tmmgKReJAEKH4FEPGzHC7uBUhxBAIpgUab1gT393kPD
 gnCcHCduWT5NdkGL+WpxoZNZMHjIBeshXg6u9ABt2R+hAAFWW8zi0l2iy Q==;
IronPort-SDR: 59Y+vUayyPAR8JYMqgOcJvn241vNOqF0nuteAexNY114JWhlVWMdawIgPmh1PVnu3/hgsLDiqH
 dC+181O3MyczNEifaoGCsyfuP0H75KSyVpui+RzDHr2Olmv9j4I4WOgta2cd4u5V+hd+txTW5b
 +GD6dxuaVr/+2HYjQP1VnPiOrvG6KGyeM1f6B4CNnQKJdNrK4/4Uwkba4T4gbLgVbxNNPhlxaZ
 hSFFwCZB401mA/JZtVhPbubsRbf1CX3BVNcemTptrlwOCYQFyV143InddSYjozyrajcjX1hiqm
 RLA=
X-IronPort-AV: E=Sophos;i="5.64,327,1559491200"; d="scan'208";a="116132623"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 07:38:29 +0800
IronPort-SDR: cphpGqK1gYEHrkWEMgasX8v8hjI84nEcUkgbPDzX9RJ3xr2/Zw2v3I1/QQxC5ICjCxQdXS0M0q
 X59LoPY62V6PEmfshXqeHno0uO/0BwRDwyC9vhiuLWAx8qinvCOxNzODvhD4w4xvPtEu/rZ4t0
 klxINmLoeBRJhnCBJHecdNvct+YMqZSLqlhJ8LQOJlIizFB7RefBkqpJrL9ALfZVsaYSbdDeky
 pAwTtmvSFnQ/B8UOeibqc+SP21ZCSkzqVSPfmKJYIRleXyWwcMYiEYbm2qDLfEfQmgpe3K/Npd
 SSFd5qQb/F3mNUxM7cdQEC5Y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 30 Jul 2019 16:36:31 -0700
IronPort-SDR: HshvwjrlLf0Ta+3I8QVhMqGse20O1Zn8NoHyY0kQWWuxbVtoqZanLyW95beEmeDNqqo6TLP/X+
 /qvOH8xhID32+5n0PRfSOtepXnF0qlMqw/2XpwpC4ZRHOyMfV69Cm0SRvu9NbYD6VgzNcvtwbW
 xxR4oK/yaW47/te/XixzzxEWt7N0Kwh/cavAnCPbfZGH+nriNM0G80kg4hWAYZNo+jkbGXDEj0
 WISKNY9DsCVcOuZ3aEmFGQHGVXTzb5bELoUS1t4Mx5BP6tc4raFMMvM9R4zz3U+bHx6zsIL+Q7
 rRg=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2019 16:38:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 30 Jul 2019 16:35:21 -0700
Message-Id: <61ae4a524013f0408a9431f1fe856d99bb3f9041.1564529681.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564529681.git.alistair.francis@wdc.com>
References: <cover.1564529681.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH-4.2 v2 2/5] riscv: plic: Remove unused
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
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
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


