Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BD1C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEF520828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DtdPoa5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEF520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtg2-0007Ip-2C
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38309)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=075cc3f16=alistair.francis@wdc.com>)
 id 1hgtZV-0003oc-I0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=075cc3f16=alistair.francis@wdc.com>)
 id 1hgtZU-0004N8-67
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:17:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=075cc3f16=alistair.francis@wdc.com>)
 id 1hgtZT-0004It-IR; Fri, 28 Jun 2019 12:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561738741; x=1593274741;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s9wRAO6C8hWPO5VAyLqjZCKMAchxKjpN7eIm/4AxpTY=;
 b=DtdPoa5DdI/O+eGsQGKhosVm51C1jYQptsT8LXeej4gOmcfEX/XO6Yak
 GU19d1NOmdLQ2by9V3EVY3KhvYaqBrt+cvi6DTpTkFZygxooYpnYwHmMz
 iidtUURMfF07h0YPnKMGdMk9PJezktvv3q0ES7rzesvTrj3ANCD2Goccy
 u1bDmm+evVuSXJqzC5xYJRvzLLg172GHOMBpso00E4TXNvmhW0x+Eabwq
 djw2ty8jq6jY0s5DxB2g9W5iQy4khZOjUNs5C4n/hiUs49X0UlwA1y80/
 aKXt5SuBTMMmyTpGUbTqmmZxzXDT6nTwdXMxDpH3Ght0FPd1esGzGR2WO g==;
X-IronPort-AV: E=Sophos;i="5.63,428,1557158400"; d="scan'208";a="211619633"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 00:18:42 +0800
IronPort-SDR: 4poUFJKLkehlElB4ml2LBEsOC+1k5e1lnyK1cMRiTqVXZE3WFQbBAPrxMqKynM+RiV8LDA015S
 UwPuzWyESeeyOxXZSiQoFZqWDlMEe1vK+Y3LxkM1mOZX7YrjK4zxUxgIynnpMQ9v1Vm3yaRNOJ
 fQP7TjzXO2oLmw3ve21MGvAhZkVXOY3o0L+jwgBTKbc5b9L/VphcNNRh8CRYOusoOVOkosmlwU
 EX00yxw3ws5ful0MYoEiuGYy/kgKXPcwuGieGtkmqAoGw+3sVZl5SXPNKvX/y4fMQ/84fEqBJ0
 8IkfHPRm7gz1j/+N+DpRGRk/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 28 Jun 2019 09:16:48 -0700
IronPort-SDR: XUtBhMnO7xi1KTZ892JExVz2LtgjRVBTbT4TE3f03+PXE712QBWQXQMSmZWv/PxBTFidHMSwH/
 golFUsmnPLf1GlY0MEnp7n0apX+oHzZCxRl7fAs4pP++OrzAxzAP/UjwMrZv6MQ69M/swXwIdJ
 2w6CiQs6Qknszgj43HE8DE6llQCGixIzJlNOFGyTcPETOHl1FDYV1srUtfs/nmfd5obC9CZ9LZ
 XFzVQ9WcfLI9+lfuUOwOM4hQkrBIKzunzMS+p/EBmdp6KgUXs/bvf+zrkdW6sUa+ilCtVnyxzB
 1TI=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Jun 2019 09:17:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	palmer@sifive.com
Date: Fri, 28 Jun 2019 09:15:03 -0700
Message-Id: <20190628161503.16760-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH] fixup! roms: Add OpenSBI version 0.3
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 roms/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index 562ed726fd..dc70fb5aea 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -179,7 +179,7 @@ opensbi64-virt:
 		PLATFORM="qemu/virt"
 	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
 
-opensbi64-virt:
+opensbi64-sifive_u:
 	$(MAKE) -C opensbi \
 		CROSS_COMPILE=$(riscv64_cross_prefix) \
 		PLATFORM="qemu/sifive_u"
-- 
2.22.0


