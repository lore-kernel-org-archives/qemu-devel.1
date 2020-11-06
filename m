Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074C5C388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 02:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E84F20782
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 02:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WYnXvypJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E84F20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1karkQ-0004bP-11
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 21:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572527b1f=alistair.francis@wdc.com>)
 id 1karjM-0003t7-FT; Thu, 05 Nov 2020 21:44:00 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572527b1f=alistair.francis@wdc.com>)
 id 1karjJ-0001S0-Gl; Thu, 05 Nov 2020 21:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604630638; x=1636166638;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V/azoJlLGZBsGNKA4AI4WArNLAIRl8QjUUIn6ni3XtA=;
 b=WYnXvypJZKMT6oU2TJHyToA9N2skdRE/rUxBkzGwucYS2Vr43TytBX9V
 ufdrNLATa5j+uVyuQIDSFlN/PwuhG2M19beF4FtdYpXmfIPHWuQnnGitB
 qLtnNPPCHb9nli/cNqLbZ8zAucXTewX3N6jFujDVMpRW4XYqwzc9IW9yy
 /Zx/ajKjOX7nW/4gGAwcVwBGyRJBORR85Wx9ZE0J0buI2+3vUGOeTeK0L
 JVfzxP0WHEpSvbRPKlcu9bwUIHjP+afISMZEYyZk5qmn6uVdR398kPCR6
 rSIEhEO/s47Ueze+LO+HLhiTqsHnzfWkk1TmflXS65UNqFPlw1GYrqYQ7 A==;
IronPort-SDR: 7GiAKJv7IT+dFwU3kqc6wAXndz4gsYNuZHVhE1QQzTbb6AskcD+icCqoqbjznfVWqcMuDbr4Fw
 zCY33KX8i0shbIAAIXSMk3Vl/6kOVPQkpVWZFqGIOAFqJ7ePo66CbeiaxYFjDCwoQGQI/8nvki
 ZTGAswfiQuheru/vOEaXXgmRD+aigydTMl32HEIFVvlK/FBNFfASl5FGn5vl62VJUqOZz9QfNb
 4VSng1l38iQeXXFLeAanyDjeQb2mdm5KGELxOM+pIx82oDEWghHVjb5y28gMq66vti+gTIZX8W
 onw=
X-IronPort-AV: E=Sophos;i="5.77,454,1596470400"; d="scan'208";a="153194121"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 10:43:54 +0800
IronPort-SDR: 0PvTtIVgKkyVKgFEFuQ8fwFwDzH9aYKjMzhw26IKfNmN4N+iSzjRgx/DH/52cSrL9M50TyIgMR
 dSPMWVdQJbskUOIAz/D1iAI36NRIM16/dnDhsybfwUW91dgrHf2YfuXpcBXMbkOuJVVOtQcMvc
 sTbokd1mlFLpQaH8gyoxIdUIVQiUIyxzv1+sG4Apa5VN18yuuby0fgjNf9zzIzN7oI6Rpi+G3j
 d2DV1l56LYRqJ32dI5lr7rtQVV5UgelgFZrrzqvH3qYv7Q84/jcNoOmv/dASFs49w5n4qg8tVY
 Rk8XCgCsmDmC+U5aRewPPdqR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 18:29:59 -0800
IronPort-SDR: nEMA/lIZehXcdhG9ZPqzj7WyMKrH0U2qP/VkSi528rtpNsepJtnq6pFKkQLRX8PewIyc2kjklD
 KWMFuYlaz8Xl6IsRybcrRWk6pVu4ces7pHn/BeKHA9G6LuApYV+33E17W8ta6o/i9BeNexIqpF
 Jki7wa5ekwJaHWN9Cia8OW2yLxbsGtzijfGyar3ZexQYldo3HyG0aMv7+fIsc2EggTGQFTJRey
 VWHlzJ6gyC6Ik+FoxrL8Jv0QEERaypM4kmcen+94lcUl13CRl5pq+G8ISV3yQKc1LOyQngIr+P
 7VM=
WDCIronportException: Internal
Received: from ind003315.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.122])
 by uls-op-cesaip01.wdc.com with ESMTP; 05 Nov 2020 18:43:53 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/1] hw/intc/ibex_plic: Clear the claim register when read
Date: Thu,  5 Nov 2020 18:32:19 -0800
Message-Id: <68d4575deef2559b7a747f3bda193fcf43af4558.1604629928.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=572527b1f=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 21:43:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After claiming the interrupt by reading the claim register we want to
clear the register to make sure the interrupt doesn't appear at the next
read.

This matches the documentation for the claim register as it clears the
pending bit (which we already do): https://docs.opentitan.org/hw/ip/rv_plic/doc/index.html

This also matches the current hardware.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/ibex_plic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
index f49fa67c91..235e6b88ff 100644
--- a/hw/intc/ibex_plic.c
+++ b/hw/intc/ibex_plic.c
@@ -139,6 +139,9 @@ static uint64_t ibex_plic_read(void *opaque, hwaddr addr,
         /* Return the current claimed interrupt */
         ret = s->claim;
 
+        /* Clear the claimed interrupt */
+        s->claim = 0x00000000;
+
         /* Update the interrupt status after the claim */
         ibex_plic_update(s);
     }
-- 
2.28.0


