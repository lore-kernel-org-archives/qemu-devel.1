Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914CDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2A32089E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IhJxyUfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2A32089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JME-0002X8-0Z
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC4-0000v0-BN
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC3-0000CN-CZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC1-0000Bc-Du; Fri, 23 Aug 2019 19:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603726; x=1598139726;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eGLfoxYeXxEr9rW2HOxWpZPD5WgDqu12jcHTR/npqao=;
 b=IhJxyUfbjkjFf5yDsYpg8WeszIyBTcSLzt/pK2oSLa4UkeoyB2oyv0BU
 2qgGLOSyjXpX7Ie3Ko8ItNMHKHj86jgzBy29vElcdEaPzIb0TKReh72pK
 nE7uFetoANX6oyu15RNaUmDvLL/z9c3uufxqutmQigm5hQyy0ehcyK5dD
 cFaHxM4CZOAluiQ5lcQffzYOWGqjQTTYM4iLD3jVM8oHx72r4SkwLXBl5
 NWU4v2vY80t4KwdRcYPzA5cS4xSthQWhdS1W30VqWPYolFn4RS+S3FDR0
 p0vftKlATOsY/wVBwbjp8IxIe8nxa9rtaA+eS8oStKJ8yCycsQyP7NTuV w==;
IronPort-SDR: ucR1o8Y4FNCY1Jxxu10QCo4zaW9MoDX5P1Jre3m4uOHDLtzmqiWAeKKkDvGpQ0P2uUV9NfS97y
 0E6Jz0thwFvaXxl4I/savi+TabWVMZAestEPV4+2LLUJkHtW8O93IKpNINxEpGps4ZzG1g3DEG
 k/3OPKiSZ7m4GUoC07HNRBp5GFaxXACHlXuI4cKVTNwisLQhDEwl0LyrM6rLi3YAxRmkr8XaXR
 2EtjVeTCAWpy72HLv6VjjT6FKBz1DjTqxmfmXbXZOyxJ1K2UMR6Co8un1zqgSP6dWSgekrhQz9
 9tI=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="118154431"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:04 +0800
IronPort-SDR: XSVsFhyY1TL4sNlSa0R94QfsQEWljcXZnfaa3qrNfM0QPFgUY34HswN2SdQwlk8UAvz1JmALdS
 6HUSbhPbSNm5q9jx6S0oT1ucMQRa8eA3JoJl466c+bGj8csfeC41s160QCLmuwsI4S3dKL+ijH
 jePvu7QcK6wFznr4A/QzHLBr3+g9jmJ8INxwDrpl5uvs5+Jy/ZDXY060xT8rnfkHz9CWnisQQF
 obdG7bDeDNKtMZBxRrD16ti+G6KEWn04/jWnvPnpeXbASLEtpRzpOJJSOQSoh7gp4lik9SljDI
 9OkJeeyO1HPUWcg1Z+R0GCuf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:21 -0700
IronPort-SDR: 68rApY4qEDjVbM6lGVccmHAeMS2CsjSXyQSYI77E63HmK2DMtJM5SXSbgERfbMIIK0qp17X+SI
 yMjbzn+hy918mIt/cyJ2mJfuAn1RmEkZloIpp2L8z+SV0rJ5ngKzdLggMbnLYvQcX1sFhWnZef
 EMJ0bwvB4+Nwu+O/afGDPehrp+cjv0wFELFmbad2LHNVTngU7PdcLNscgm5YInLhGc7wYZ7FMo
 SotQmqY3ZhWv5msJ0vSEEEZAJ+ewXM2ltOVMvwoopZLjs7OXDC9vKnx+oW/BAUBVB7jx7dCZDv
 O/I=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:42:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:23 -0700
Message-Id: <964f729f0c7010cac733b88545f0356a668c9bed.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 13/28] target/ricsv: Flush the TLB on
 virtulisation mode changes
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To ensure our TLB isn't out-of-date we flush it on all virt mode
changes. Unlike priv mode this isn't saved in the mmu_idx as all
guests share V=1. The easiest option is just to flush on all changes.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index afb3e8579e..8e8b156fc0 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -203,6 +203,11 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
         return;
     }
 
+    /* Flush the TLB on all virt mode changes. */
+    if (((env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT) != enable) {
+        tlb_flush(env_cpu(env));
+    }
+
     env->virt &= ~VIRT_MODE_MASK;
     env->virt |= enable << VIRT_MODE_SHIFT;
 }
-- 
2.22.0


