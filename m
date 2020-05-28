Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01FEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F19206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KjDMdB3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F19206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeR90-0007Qg-KI
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQxM-0005OU-6s; Thu, 28 May 2020 18:24:56 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:1081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQxB-00089M-QP; Thu, 28 May 2020 18:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704686; x=1622240686;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oBPhfC9MtrkLK6H1y1uSTMYIxTHmfIqTtIvTPa+eUNw=;
 b=KjDMdB3jS96n69Yx3UmkaGhWCkHO88ysPHXk4aEFohkuNLtDUh1JPaeU
 5Ii04CU/4mT61qIHw3AaZlPrYg0phghBH2uRssWliy2Mx7V7faT6atlpg
 e4SJMJvUX6QTq/WC8D8kAKnFO+KjG7lFVtB2FpWGwU+56BolGWIMBn1QS
 6j9zPiaqBQFXqSVWiLQKah7tXPDGWC7wpZXqDGR8WczMxskTR08rMvRos
 H76vPC0NXZfgVD4C/yFz3N1IM3Gxo0teylV/Ke6EopOm4/lWVch6mioxR
 uQqC2MvRYqnyn9M0Hz929SKPPo6yxMnvCx7L8wr5aXnBQ6hWo5xSCgDS9 Q==;
IronPort-SDR: 64trdmP1/h9vIvwArYhT8KC8aST6AWRYgSj++8KBIXQFoI53VdGn4yNfoK4HcOlJy3YnCWVlPV
 aZ1tedscFkXDhSngz5H6a9C5QU69/HFke9+WcEPN4cMWO8ibFYd4CisRHEHmCPswFh8EarPnKO
 z6gY2LdWs4cTUPNQ2GruoKEC6HaPEnT5sIYUKf1I8zoLfnPJxbRaEa9wNOLz8gapuAD4Ym+OVz
 FXSnVSPbKRuB+9tJhK7w6gcdOIga0XG9oG1vxTYtmC91oGRdcKSzd7uinF1u1ZVzrGOMaDHQsk
 P+w=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="140170637"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:24:42 +0800
IronPort-SDR: hL6UwUxfJJSKEPwxKQS8N382Zjh86lz3yoeubZ/Iia0J8c4PUqZgJPWWQsdMKv7xuZxlqAo7ms
 4BsrUjIGseFqrfShn3XvIykGpjn9Top4Q=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:14:29 -0700
IronPort-SDR: v9LDpslyedAU213j+t/1TyvLLAMSojDSxySdr5vJ6P8JJBjgH72m2G0kdRU3ae/0vqOk9M4w4E
 gFCtDW+pe98A==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 May 2020 15:24:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 0/4]  RISC-V: Remove deprecated ISA, CPUs and machines
Date: Thu, 28 May 2020 15:16:05 -0700
Message-Id: <cover.1590704110.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:24:41
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


v4:
 - Remove all of the < PRIV_VERSION_1_10_0 checks
 - Move the documentation to the "Recently removed features" section
 - Document the OpenSBI deprecation
v3:
 - Don't use SiFive CPUs for Spike machine
v2:
 - Remove the CPUs and ISA seperatley


Alistair Francis (4):
  hw/riscv: spike: Remove deprecated ISA specific machines
  target/riscv: Remove the deprecated CPUs
  target/riscv: Drop support for ISA spec version 1.09.1
  docs: deprecated: Update the -bios documentation

 docs/system/deprecated.rst                    |  98 ++++----
 include/hw/riscv/spike.h                      |   6 +-
 target/riscv/cpu.h                            |   8 -
 hw/riscv/spike.c                              | 217 ------------------
 target/riscv/cpu.c                            |  30 ---
 target/riscv/cpu_helper.c                     |  82 +++----
 target/riscv/csr.c                            | 138 ++---------
 .../riscv/insn_trans/trans_privileged.inc.c   |  18 +-
 target/riscv/monitor.c                        |   5 -
 target/riscv/op_helper.c                      |  17 +-
 tests/qtest/machine-none-test.c               |   4 +-
 11 files changed, 118 insertions(+), 505 deletions(-)

-- 
2.26.2


