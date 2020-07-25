Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 05:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8A12065F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 05:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MiC/XI7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8A12065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzD0G-000591-D4
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 01:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=46842bc30=alistair.francis@wdc.com>)
 id 1jzCz0-0003qL-Ds; Sat, 25 Jul 2020 01:44:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=46842bc30=alistair.francis@wdc.com>)
 id 1jzCyy-00054Y-B6; Sat, 25 Jul 2020 01:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595655869; x=1627191869;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R6ZRT6wwYaLQhVVdX9vY8+1Sj9WCDCaCpExLFgi/9BE=;
 b=MiC/XI7eq1AiHb1Bk6t59muk9cuRO4GVpFgHXgnOqA0EGYbwYY5jVoMG
 lfjsxTSDcdalOXjW//B+nECCUOeDDvfq9PLcsrR2HK8YwWSwMbk8Fv+cO
 eOi+u4wdFOvW+7fkGtETgFE0oDRGD6u6uKpm8PTu2dZbBeiJYqEq6yqPc
 8B7rgKjBTnTphb+j6SdlxqSuQMZR+ApV7ahGfGtF7jPjOLtZ4dLoFNgkb
 PP2QiX6vwGylCgp3PFlXcob7tn9ICHvn1QKJXU/KHiYpQPULZsizwJa/y
 5ECGQdO+O9Dk1sjr8m+MyQpx2J+Agrd4TXcHnPzRZKuJBSdTMi+97s4hY Q==;
IronPort-SDR: HkpjcQZVYBJgSd+sMf1sILQj6P+Ml2DRPGNQDAcymNutICxHaVrkp80YR1lFdIbOTMmeH4WNID
 dCH6U8AsxUc3LLgQYMbyQujLKTFViicMrq1Vtgc50kHV+eHQTFU6NX6dG+Bb6Xn6faAYTEAM2n
 e+1ZZH4GyUvgoGGiIv9oPZLUZfVqegAbjHd+F0fvGIUJ5b0t8IsN0smmn4Yn/zwsTnelso3Nid
 AFtTfO1mIO3s1HbNGBGBBE6yES1s/4PJksVb3MzkSmvWoUJIBMl6Jugs9tsNDJjSJSl+eu+RrH
 A14=
X-IronPort-AV: E=Sophos;i="5.75,392,1589212800"; d="scan'208";a="144611246"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2020 13:44:24 +0800
IronPort-SDR: aHqMaSAmay7ojzcYU23i4yfr0nO8FNQbepbw0By4c0fbUP3x/iUnVHr1z+izZgQwG7WwEGoOks
 9lGZ1ke/rUWDFFkhZ9ueZ21dvmt1RJHIE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2020 22:32:36 -0700
IronPort-SDR: DlqQRt7cvXuLBknL8QhfX1Wgp4qzOXdtoW6kFHfg1BGQ2pIgI4uyo3+AC6tMESQjTYnW8bXUJD
 GO8iFvKJIgCg==
WDCIronportException: Internal
Received: from cnf007830.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.124])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jul 2020 22:44:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 0/3] hw/intc: A few fixes for the Ibex PLIC
Date: Fri, 24 Jul 2020 22:34:37 -0700
Message-Id: <cover.1595655188.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=46842bc30=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 01:44:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recently some SiFive PLIC fixes have been merged into QEMU, this applies
those fixes to the Ibex PLIC as well as an update on how claiming
interrupts works.

Alistair Francis (3):
  hw/intc: ibex_plic: Update the pending irqs
  hw/intc: ibex_plic: Don't allow repeat interrupts on claimed lines
  hw/intc: ibex_plic: Honour source priorities

 include/hw/intc/ibex_plic.h |  1 +
 hw/intc/ibex_plic.c         | 36 +++++++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.27.0


