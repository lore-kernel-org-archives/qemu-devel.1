Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB373C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F372085B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d7p/c0KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F372085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhfS-0002jo-TT
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4447ca4a2=atish.patra@wdc.com>)
 id 1jqheM-0000zn-UH; Wed, 01 Jul 2020 14:40:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4447ca4a2=atish.patra@wdc.com>)
 id 1jqheI-0006Qb-I3; Wed, 01 Jul 2020 14:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593628798; x=1625164798;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rvYoakPjR2udn9RDA+xsWrowfyjn771vNirFQBDjUkM=;
 b=d7p/c0KX1nbtc2YRo5RJfAs3dRnuxN7D5D4UPAhzJrDQPYA2kit5MAf+
 E5cNtJiOEZkb6lB2c3gs5EWnwU2HiYmEcFnDgkFpUgYKo9dY5TAMLbeZu
 5Uo2kGNaiTcWr0Tj8mqfyZQfViKnNAARRUjcfIhuCX9bFzge5RSdOQk2S
 ticja4gOj9Ss2iugUUriF0oDsdQRrQns/NOirEo3YFnbAoZSQqi2OPlnZ
 C4r9lFpbBOiHxqqKpNvpRjqp9/fryLoQpHgWQu9HVouyKBICJxDCflKDH
 2V6goka7LBsA/Fl6V8hQNLGmX6oa1WloosHO7jH20YZRCcC97HHiE28JE g==;
IronPort-SDR: LnHHHXn5sNeMEMy3pqIEbdnDIVnT+SFeQ+k0wNmWK5MQJLdoi4afk8SYvREYyPnYL0Lo1TFipa
 tgtzxPbVl2RFUyRW0Ucqi5YZTJwT+vhC2WFVEhlvZE4WMVRQy6lJcwxg5TdddW1acMFNtxJs8k
 NW9GVt5mBYl3gJR8+9la+ezD7SGXGKlUvVVGMmJbIeAOTWYS4IgThvpRLaeHMGI2RboiFowMWh
 cmLuSZhukEbQkEB+Ab4zAN4bMWKladvBYhpoFyRxL4L5fDuPthn7mmZj8Zi1FpAIKpR5Ybl0Gi
 H9o=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="250642367"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:39:53 +0800
IronPort-SDR: DGDtwerUNT25FfX8uk2gf/xlQnDggkxaTyDLWucufyMhEhA2Wrk4ZaUC6xWzsgHARYEInuyosT
 IeMnNPOBbhgayKtxLlHAC9trq+Ajp8p3Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:28:10 -0700
IronPort-SDR: 0R6/RIaTQH5wAnQxhuTv4fRmo9g2AgbABhPMO6odd/Pj7KAY18sQmDTb8ihDAF0ljfYETZ3f/s
 QIOtVESoG3hw==
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO yoda.hgst.com) ([10.86.58.95])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2020 11:39:53 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] Add OpenSBI dynamic firmware support
Date: Wed,  1 Jul 2020 11:39:45 -0700
Message-Id: <20200701183949.398134-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4447ca4a2=atish.patra@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 14:39:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds support OpenSBI dynamic firmware support to Qemu.
Qemu loader passes the information about the DT and next stage (i.e. kernel
or U-boot) via "a2" register. It allows the user to build bigger OS images
without worrying about overwriting DT. It also unifies the reset vector code
in rom and dt placement. Now, the DT is copied directly in DRAM instead of ROM.

The changes have been verified on following qemu machines.

64bit:
 - spike, sifive_u, virt
32bit:
 - virt

I have also verified fw_jump on all the above platforms to ensure that this
series doesn't break the existing setup.

Changes from v3->v4:
1. Addressed all review comments.
2. Added another patch that allows to boot a qemu machine from 64bit
   start address for RV64.

Changes from v2->v3:
1. Removed redundant header includes.

Changes from v1->v2:
1. Rebased on top of latest upstream Qemu (with MSEL changes for sifive_u).
2. Improved the code organization

Atish Patra (4):
riscv: Unify Qemu's reset vector code path
RISC-V: Copy the fdt in dram instead of ROM
riscv: Add opensbi firmware dynamic support
RISC-V: Support 64 bit start address

hw/riscv/boot.c                 | 107 ++++++++++++++++++++++++++++++++
hw/riscv/sifive_u.c             |  51 +++++++++------
hw/riscv/spike.c                |  57 +++++------------
hw/riscv/virt.c                 |  55 +++++-----------
include/hw/riscv/boot.h         |   7 +++
include/hw/riscv/boot_opensbi.h |  58 +++++++++++++++++
6 files changed, 236 insertions(+), 99 deletions(-)
create mode 100644 include/hw/riscv/boot_opensbi.h

--
2.26.2


