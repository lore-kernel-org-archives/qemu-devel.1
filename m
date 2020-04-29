Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EC6C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A34D20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aZIjhmy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A34D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtXb-00020K-LX
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtS8-00017Y-J4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOC-0006zv-2n
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtKi-00065w-87; Wed, 29 Apr 2020 16:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588192168; x=1619728168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rEa05vt184m1FjxLiRpnoXbu3gIO1YzdoXIlsoD8Ghw=;
 b=aZIjhmy759iRTgl2b8Ro1cUkZtVN4yyOS38d0gOjGkz/0qQVsrgcu/yQ
 uYWTTuQgB6JfrE4+tdBZb3a74Nzxu3ABbZUuXLCIj3x8keIEtEAyRoHmV
 7aVmi98tvCwudu/p8DZTx818UjTOf8J2NfkhAQWUdAlAiYlkNiPighmst
 K+9oRblLE262BQzri6uASM58UMTGD3xgaUKE+VDGOBOvnPBLkSSFsoKcx
 kHkOMfn/AwuJGAgsuUiKfqU0VHuM1fbJlF1rfu6RzQep2IPY7MD5dj00K
 XvkA4966xTHAMkcjidDHWrxg6lM6HGhATmvW8bij4oLT8i8taE1/Bk5Ac A==;
IronPort-SDR: +XK4cntqeWP80eLlgaG0sKflg9RcGJ0orBtJBcrMXvlQnCCAj5mdt7R6AkaKA5eoYnABrc09If
 Kel2JOc+CFBsV7j7i8iW7vqrZFN6U8xkCI8MZ3iwGWspWgHJWt81y6z2BciVRRCcidR/uETgZj
 JIp+OB4hSLeiC1IegyBmfj4bI7yqEDvIa2yyGfbYR/kh8IsS1RZYyCCAJIxHiifWDkqoUDYm3S
 rfQ576380faKi7aZ8iER4Bzr2w8ymL+cDjgxgQSeG35WIDLtIs0FLd/29EisveTJ5QeZKaF+Qf
 m1U=
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; d="scan'208";a="136507044"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 04:28:41 +0800
IronPort-SDR: m2MDumlm9MQZc1JUC67mgeGikx6E5c5/ee83bGf6TtDCddpJ/NER3WCU8DyRFuHnXob/Erur5u
 Uzc0e93oLITWxheJ50vPBMEr1e29L6Ask=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 13:18:46 -0700
IronPort-SDR: pzY7k3hTMltQf7Kas/I5dpNyHuJPIJ3IyG7KJukIiQwS4cLLYPoAEGp5l/txjoLGxBnRNRLLC6
 OXX55MqiCQyA==
WDCIronportException: Internal
Received: from usa004631.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.145])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 13:28:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL v2 14/14] hw/riscv/spike: Allow more than one CPUs
Date: Wed, 29 Apr 2020 13:20:06 -0700
Message-Id: <20200429202006.775322-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429202006.775322-1-alistair.francis@wdc.com>
References: <20200429202006.775322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 16:28:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, palmerdabbelt@google.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

Currently, the upstream Spike ISA simulator allows more than
one CPUs so we update QEMU Spike machine on similar lines to
allow more than one CPUs.

The maximum number of CPUs for QEMU Spike machine is kept
same as QEMU Virt machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200427080644.168461-4-anup.patel@wdc.com
Message-Id: <20200427080644.168461-4-anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/spike.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index e7908b88fe..d0c4843712 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -476,7 +476,7 @@ static void spike_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Spike Board";
     mc->init = spike_board_init;
-    mc->max_cpus = 1;
+    mc->max_cpus = 8;
     mc->is_default = true;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
 }
-- 
2.26.2


