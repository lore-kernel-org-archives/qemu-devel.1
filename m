Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0551BC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A6D206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kKpAzn8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A6D206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNcB-0008Uq-HJ
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaB-0006Wn-OJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaA-00075r-NX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaA-00073h-Fb; Mon, 09 Dec 2019 13:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915390; x=1607451390;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eZ4GmpjmK0ndi25FbF/XUvsZz/5T+5wl/pA8my/wzRw=;
 b=kKpAzn8MM2jWaJhHs+fbAMB9dKuaGJCq3mxjC2TnMx3M+BSaRY3+3Uad
 jYJF0IZ6Pw/DZAzo6uuvsCi4otkvdJb+R16Wave7N7H4mKBG1ynO7LBxD
 PkUMan+JijfH74flmhVUvgCRsXv6liAmtNST/8m9IyPzN6ldP5dWfqJIy
 lJR8hPUxKw6BWvLS9oWeldxBamWm9iHsXan+/39HsPt2XRe/3yb/LzCqM
 lBLwjXQJgge7mPe0iRhAn2RVsy04qeoOmgWrTdJ9BrDW5GDkONv9rUGAH
 EhqWtqvIASbjt/AF4DWeTDZIfKCvzQW2QLH1VuOhYc8Sb5l/gaQVRaohG Q==;
IronPort-SDR: OBs0RUQfunrWkWIXrzKERZk/fjr7at1ewSK54plXENsmGzcW5PW5p42Gx4x3K3UoeOeTLrCOF7
 JktsMy+dQrRo+m+fKjaWMxmRu1JMjIiaFS5ntmNrl0KLDYNwxGHvb3ty+4FeMYSSB3P6d157St
 udRTRGc7O/Di/QlILfYZUxvN32Z97PPd4dRCFGmo7L3l9Jam6CuiOr1V587RPqQuNEEylddcFU
 cYzx9JJJsyIK7K2Kmi2M6bkpci508on8DBgKEvnGtHfvUKCbAL4VYTaXAhn5yzt1KGN+Qp2koN
 Paw=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="129370408"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:30 +0800
IronPort-SDR: OE+ts604FoKWxfFugpaJUAEo6RC7Z2ZJBsxqE8wRmtNL9XMBWFdOoJP3eBSZcXrfx3H1v3sPO8
 2hutSIhAUIj0AceDIhhHMhke1MXMoOv3eCxmBKXOkkEgfROa9tBjdbTFtnP1Z1OiUuSFvnTPpq
 OkuLfols19kyWjXAwfdX1PNnWNJWI5Pg+oTJySn5VAi1kpbBTwxRGs+J+QlLicXXZZm4oviLfY
 1yHJhOG2Y78UPW2ZeCHxpJZai0weLU+rspasLlOPJJys2BvVCgZJ3wm1s5Tc1/Ae/StOVSh6h5
 4AcDEuuCuw8leCqVaSMO/vsb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:10:46 -0800
IronPort-SDR: sDtIlTbk+iY7m3S/zqRBW2DRxC0hKC2VcJeIK/W+Qq9mk9A8P3WLcohlgDdioWxkDha1vOVh1u
 z9xP7LQ0XigHMdCLUITBhGQG2Tg9ICY3iNt5G1pmyndFC9GOk6ITIuo+8o8A+r4ybgHm4by52r
 WPyOHxqb9lgzPQzsz1IU0mT1k9MyjvkHLFk6uJD0gw6Os5PFATCMtUsY2T2c+BAnKhCTStLJDp
 IC3SqKtQlQTd8OSrVUelfsoOGgJ+ZIIZOt0KgCHIqY75KIKhzVLLYiz4LG6ZaKLwzdG3vHruxo
 NFM=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:30 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 03/36] target/riscv: Add the Hypervisor extension
Date: Mon,  9 Dec 2019 10:10:48 -0800
Message-Id: <a61a1739c01c587a5e65a93398317ae644426aff.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f889427869..91e1c56fc4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -67,6 +67,7 @@
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
+#define RVH RV('H')
 
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
-- 
2.24.0


