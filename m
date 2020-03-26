Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB9C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398E120714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q3yOTTJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398E120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbNh-0002yl-EC
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 18:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3472fa30f=alistair.francis@wdc.com>)
 id 1jHbLk-000194-V9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3472fa30f=alistair.francis@wdc.com>)
 id 1jHbLj-0001Hk-Ot
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:51:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23231)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3472fa30f=alistair.francis@wdc.com>)
 id 1jHbLj-0001Fk-Gh; Thu, 26 Mar 2020 18:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585263118; x=1616799118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RsqcTNcToJ/y6Hxiu4n41D32DgYFNh/mBQdoR/mbUYY=;
 b=q3yOTTJoRcOTBxECfd0kTr/ip2u03/HaexG8iaACy646Rc5cEb4KfIMs
 wFyujyjsDH6kbmD718pwzxfyyjZ8AAb0a4S3iNeS4sLDk9FFjjNSBp4Ml
 k+B7PReiiavsDnSwtLlNjDgXgjV6uAzje1UaJb5VArs8iIno2LKAWAtpK
 SmG+A8RPi5GelorW76IWXMUlRQket0AYiPaI47qmJUmdWu5aZPMtzOQ8Y
 lf/zyLlSH33q8Iv8eUg47KJfimFZSpAO8K2Go9eW6QAzhvJf6wjB8RyTG
 Tt3lyT+9d34yCdj5wtCW/FHmHX76YQlrOLkb2a5G+8BNaQ75jKCAlT+TH A==;
IronPort-SDR: f34d++HvcLIRmUHqsFT9Ghy0aRFJYLzlNmahrxlLbfBDbwKORnwbsAgJ9SQ3Y4gCRXpHQLwXBs
 ApTkN0eO8vVnqgunmm6TZDusioZ5IaLAuZDj7I/okz32401fksuPaXHv1WTAm1nkuFype3ZmSF
 CdUEy5gjdQvD+ewPUQfy9mTwM7+auL3+y1bTLxrl+tH4Ygah+4vlQJkRGLz4QTx10zCMeuR6DI
 iAyBVS4Z5lq7uhWKxzXaK/gVo395uSEBHIMQ6jp0Z4MCEaWaZoOoS/Fr9WNZc8kHaOl75LnRBn
 b8E=
X-IronPort-AV: E=Sophos;i="5.72,310,1580745600"; d="scan'208";a="235858178"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2020 06:51:56 +0800
IronPort-SDR: KtkiX+beHzw1Zp+2mwcl61ptewZ614TTaHIE7oJl/ikyRi+Elh8pMkp5qyMjld1yas3DyZjeDi
 gXKOdhAehFxzzZzS+PXqap0TfuCfuvNh8GwaCudzDZi8dPeG9NYjSQe6saUQzzNl1dZzLt7kV0
 JYFdrS0jxq/yHuxXEHl8a3BGuNnQmBAoOaXoZNG8puPuMsGNxRC6GjQf9zkwXDPPwVyu6QChhz
 r5fa5IRpIjDWHviIpMxs/BaNbd7wUUFd3h0hLKHcjqcGbxGF/T+rQTjXK8gIJuR8oLI7pmGuIT
 gGGWdljj2AzZHiqxGxGQuoSt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 15:42:44 -0700
IronPort-SDR: huc3OBaOUGQKMU+9+nZAPWpeqkuCpsETEST1duowVDM00LD1pSDeGRyZpm/7y6Znv3Qzqy/Azs
 +j5IC1zdHERdsWkgo3IzL5uTrKNQszgnpIxNWJ+OjIA+q+Tr1dwoYzYbNfhY7nX9DqNHYJMspI
 wNjSdUZvFPMfasP1skANb3UMoJu1a8L7LXrrt8y3uR313w5L1DZ31ilVDpFnKeFeM5Jarj2Nri
 WYdQBH6tWu0I4qEGEwaqXkM4MXYcniVi5QwNzBW1FAbSbDVl66bBgrn9U9FqJHGCT5igHZaHfJ
 PqQ=
WDCIronportException: Internal
Received: from 2j0d3g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.54.250])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Mar 2020 15:51:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH for 5.0 v1 1/2] riscv: Don't use stage-2 PTE lookup protection
 flags
Date: Thu, 26 Mar 2020 15:44:07 -0700
Message-Id: <931db85d6890ed4bc2b527fd1011197cd28299aa.1585262586.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585262586.git.alistair.francis@wdc.com>
References: <cover.1585262586.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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

When doing the fist of a two stage lookup (Hypervisor extensions) don't
set the current protection flags from the second stage lookup of the
base address PTE.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d3ba9efb02..f36d184b7b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -452,10 +452,11 @@ restart:
         hwaddr pte_addr;
 
         if (two_stage && first_stage) {
+            int vbase_prot;
             hwaddr vbase;
 
             /* Do the second stage translation on the base PTE address. */
-            get_physical_address(env, &vbase, prot, base, access_type,
+            get_physical_address(env, &vbase, &vbase_prot, base, access_type,
                                  mmu_idx, false, true);
 
             pte_addr = vbase + idx * ptesize;
-- 
2.26.0


