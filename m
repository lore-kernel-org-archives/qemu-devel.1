Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F735C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377872133D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L0Ge630C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377872133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54325 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRl7w-0000fF-7h
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:14:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl62-0007uo-9o
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl60-0007LI-Hs
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:12:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5z-0007HB-QD; Fri, 17 May 2019 18:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558131176; x=1589667176;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=UraNYZa/rGlNA4WNmmKuAimGi9hHpUL2xBtVQ8qUMgY=;
	b=L0Ge630CQW22PLtD6YTpYzbW3bLaDahpxkEQ2Art+3CLjptvl8HW9xzz
	PpiJVRKr91bHjLUBcHx6f+AO3mMZB6ZHZNw42yf2+YoJovpziqiFqkvVC
	8ghdwvRhfTrq/2GFqq/+tpyrncMb0FoHdUGEwWUZENWpAe3AcswKIdXfv
	YdVfQPoSUyY9NWLWG7qjj2qp4MgFTVR5AE1VzG4KdV5EHMZjHKV8vME94
	HK4JaG7fF52tNzyTAIjqEz6MeYIkGQH6mZBmVQ1kvFnO8bPiMR8LavhHO
	/c3l02tqV6JIe4OdsFeJUhJLqzdZLSG4ioWcovSCY0l1yfJ2lgPaBUwAQ w==;
X-IronPort-AV: E=Sophos;i="5.60,481,1549900800"; d="scan'208";a="110242478"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 06:12:51 +0800
IronPort-SDR: JW4A5iRfgafFbu+nAOoRyFuHUlCPXociE9hZsveRIHUsC+SPYezvk0K04MwRI6V9JJXCKlIwIM
	OubU5KKpZQHd2rJyEybxxceCo24Es/ZSE4UX80it9qF39IyWN0LRVGa9BEXh0MTKCdIqj2fp/1
	Qr6PM7HpwidAfzUaFulIgrEfgIrNAK8e0NNYvPUj6KDOSFSJpYlVAcwKr8Mu075BhF96Ia7dio
	jQ4rFouSu0Z5qA5LbnM2iMBwDz7kEMo54dOcGsaznP17sfogAKIkLChnDN1047KFpytjAcRvkf
	Xl1MaizZUX5DJzZ0aGflHn2P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep01.wdc.com with ESMTP; 17 May 2019 14:48:20 -0700
IronPort-SDR: /V5Cj3wc7Oi2NbQNGTtqzdEot64q+ffX4//OW12VKXv0U6bGDgZefsMqn/KQztlFOGuwHQC8CS
	+4dEaaeof/TidoRtFSmLmfFta5rHQWZDfiKxbl+8teNxfEPTec+s4LxYNS2Ngs2965Zp4rh71C
	YtgQKJE27zKgUBcaZTtfF6yapeQB4L19NIGqEsnE1TO9TeOEwWj5WvcqgPXpFNWYPBGpPYdwIF
	EReYfgp0gxq14V1HVG8NBEyC5dpQqv5fIao6S/u0z3UB/gE/Y69jytBUtLyD4fj3IMEZy07sXy
	iEM=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2019 15:12:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 17 May 2019 15:11:04 -0700
Message-Id: <d4664adffe008df43f2a0760dd4e2b9cb834b652.1558131003.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558131003.git.alistair.francis@wdc.com>
References: <cover.1558131003.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 3/4] disas/riscv: Fix `rdinstreth` constraint
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

From: Michael Clark <mjc@sifive.com>

The constraint for `rdinstreth` was comparing the csr number to 0xc80,
which is `cycleh` instead. Fix this.

Author: Wladimir J. van der Laan <laanwj@gmail.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 3ab4586f0a..c2578a3c4b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -614,7 +614,7 @@ static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc01, r
 static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc02, rvc_end };
 static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
 static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc81, rvc_end };
-static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
+static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc82, rvc_end };
 static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x003, rvc_end };
 static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001, rvc_end };
-- 
2.21.0


