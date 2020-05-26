Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CADC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 22:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D5F2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 22:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Krpo27vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D5F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdiV5-0001h0-HK
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 18:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=408db4441=alistair.francis@wdc.com>)
 id 1jdiU8-00006f-Vk; Tue, 26 May 2020 18:55:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=408db4441=alistair.francis@wdc.com>)
 id 1jdiU7-0007RW-B4; Tue, 26 May 2020 18:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590533747; x=1622069747;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2j26BpoD1mP+wPxAb99Es5pKIc3CVRP4s/c2OWfpyps=;
 b=Krpo27viBeTCB2ebBje6w2wvdp936iqOycFW6kDrGDfrIN5ZK0qzCeZR
 bcbHl4N8T10TxOPPKiAe0qW1dhQXQknxgb5W5b3voffiAznjEbdVttQ0m
 Ptj0kvehFJdPGcQNNigK4bmrxnyZyyRbd4+Y5YJaOE/S2BQ4K+79kvqWV
 pxoymGjI43lEaWQy91WqQfaBnksgS49/dksll7tl5l7fZ+492kAUScUod
 7NPcG52nU2yN/PimUrvXzwJ17ovBDTAd1hzyGrXDpKvpRo5MlwmqW25l8
 kUFEToKvE7r8HHpaASHpZi4PSriJzDdr9WflEnpV6rvxvFHg4+egHE29p A==;
IronPort-SDR: W+6fmjVlMJk7skxQCDH1gq5HWDHMcBTODNVnC5dteKPG9YoIxke8xjbonlriDUFmCGMc5GdSvB
 5pkJrzUU2ZQBCnFbRpnXP8nMVm4yqViaCTl6Qtl9VXWB8yOIOtAk6ciZ6BsXrx0GwFT2/iHAJ2
 gIgbSXT9ltd4D112+yEjzI7GqfDhNg4t5fTHT0Htx4glGykxXbSdIFYIjl7eY07RJQj+LleNzk
 OFBohFjjc2mkDl7UfxNMtB41QR4uvlqZCNLdjxIF3lDqmUOWmNVuDLmMgTYnKDoW1nx3285lbt
 oDo=
X-IronPort-AV: E=Sophos;i="5.73,439,1583164800"; d="scan'208";a="139996078"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 06:55:40 +0800
IronPort-SDR: Rljc46/PDRUKmMNr6muK1J3X+bSkWVkvm299u+GEukzVE8AxTij2wrMzQU4msIY7bCRiZTsL76
 lAc8XIwUJL7Z80180hlntauMy0vjpgHgc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 15:45:32 -0700
IronPort-SDR: r/K7J1h4VL7XrrDTdJRQB1V9VssuxCgE8N0eqpaUxdJLIxVCOVPJghxQ93wQGdG+TEtcNl3w6r
 cW5psr7hqdNQ==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 May 2020 15:55:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 0/3]  RTISC-V: Remove deprecated ISA, CPUs and machines
Date: Tue, 26 May 2020 15:47:07 -0700
Message-Id: <cover.1590533156.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=408db4441=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 18:55:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, palmer@dabbelt.com,
 bmeng.cn@gmail.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


v3:
 - Don't use SiFive CPUs for Spike machine
v2:
 - Remove the CPUs and ISA seperatley


Alistair Francis (3):
  hw/riscv: spike: Remove deprecated ISA specific machines
  target/riscv: Remove the deprecated CPUs
  target/riscv: Drop support for ISA spec version 1.09.1

 include/hw/riscv/spike.h                      |   6 +-
 target/riscv/cpu.h                            |   8 -
 hw/riscv/spike.c                              | 217 ------------------
 target/riscv/cpu.c                            |  30 ---
 target/riscv/cpu_helper.c                     |  82 +++----
 target/riscv/csr.c                            | 118 ++--------
 .../riscv/insn_trans/trans_privileged.inc.c   |  18 +-
 target/riscv/monitor.c                        |   5 -
 target/riscv/op_helper.c                      |  17 +-
 tests/qtest/machine-none-test.c               |   4 +-
 10 files changed, 60 insertions(+), 445 deletions(-)

-- 
2.26.2


