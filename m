Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75689C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422F320661
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aya0Z+os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422F320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrnJ-0003MN-Bi
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTrb5-0001Zt-5d
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTrb2-0004Rw-OT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:38:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTran-0003PZ-Nc; Wed, 29 Apr 2020 14:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185478; x=1619721478;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rEa05vt184m1FjxLiRpnoXbu3gIO1YzdoXIlsoD8Ghw=;
 b=aya0Z+osyOiBetpKqCRqpsuFT8M+Oq9TIS/IgqLN8ILDjAjsoajjf0Wg
 whUMxrwUJVNq+tv0ZS8XRmumMRWEtPXhcQ4D7kJYkgQW3JmVpTZ8f910/
 Jolv3UhaSJdW6yilCUI6WVThuOJM3sKEN3VdtlBoN1rjvz/BK9OYlCZqt
 8wNMzK0mm+yNyxndfjU9PuDd+SkFvoZ0jO3rsV7ukcK0nFo0A0ltQA/22
 7gadQ9YKD2w/xR3X8ZuCdXFjuS2N5Tpwx2yV5FMfhm9wMcQkHjfl38n0L
 i3lTMtthyQJ/f1YaKEAvbCoFe+rxFMXeKUXcquYxg+Ag4stSGp8xNdwBc g==;
IronPort-SDR: mUuX3HczUtlzAjpeCXBlhd4s3Js+IQqeMHSrspC7vA1X8VU6kXio8jCRMRFScpRphkY75wl4H8
 IaFPFXJZE6rSoEF93S1baZBuGh0OLAPegUImSgGkqO5j6Dk0nuPXhR3PWAddsNUHM/NSjjMGaN
 /Yo/yEBBg9/eCmKr6BHUOWsYS32nb2LFJ3oun4UuavjWhOjcCpLA+tp/vmrQPkBYTyL+tutGAv
 tTdtO8h96H1L2/QTyTwFosMvclpTUh5QI8woT/wyIzR/A73IK36l85l6jx3QC2zDjaa3DI1FDm
 WRU=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935160"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:09 +0800
IronPort-SDR: 7RUyg5upHtGhhbjXCYURvMFf0GwnjV+9gAxKPr7BOWi/MptV23W/sqxlEJSPVHJTiZo2YGESM3
 tbyG0bt90ml3sOUFJ1ZGJz840pGV60IBw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:13 -0700
IronPort-SDR: abJWyOyJ6BNYSBvUsSxLDDwR8YpQLfbv2ZfqzL2qa4UIsuCBqbF34ApmgizKlJmz6LPGK6Gqj6
 aKn4ChKuLK4g==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:07 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 14/14] hw/riscv/spike: Allow more than one CPUs
Date: Wed, 29 Apr 2020 11:28:56 -0700
Message-Id: <20200429182856.2588202-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429182856.2588202-1-alistair.francis@wdc.com>
References: <20200429182856.2588202-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:37:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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


