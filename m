Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A228C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75B120789
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b0DPVlON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75B120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWmY-0000zC-2x
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=43885dcdb=atish.patra@wdc.com>)
 id 1joWkx-0007p4-RK; Thu, 25 Jun 2020 14:37:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=43885dcdb=atish.patra@wdc.com>)
 id 1joWkv-0006Ic-Df; Thu, 25 Jun 2020 14:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593110270; x=1624646270;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2hEFUZNYBsyMLQVVqKQAfERoTiEprE6feuGCOJcaCmA=;
 b=b0DPVlONRX9jpjBdQfYtpec0t/MfspVz3gC+aoVkUK4M6R8ahJjEMYto
 Ned8ht1cwSfbSpWKUp+OJxmyvjO48hxx3dNSDRvSHH0qcB48vwFw5yaKc
 PYiNekcJIYCV4lTSAJ5m6F4j8pIs6ag+jPHf7Ja6UsqV3UpAODO9YleZY
 xAyWaNa9nAhtuIPqpbG43S8lYfeGHm+d2Vyovx2CcrrvatAnE5CXnyDtv
 Sbpg47torLKEeFa+qzoKsxpdtZWUPsuD7NHFndXKsKCUE/gjTL8fZ2CAS
 IoZzyDId+btNPNPT3E0wIZ/SWNlFlGhzVGLX+zlU+y02uyi+sJLUVq5FU g==;
IronPort-SDR: fqS1yStgZcmCxSj8DdENB/LK5CKZ2KbIsTzevIRlkhqNzjwYGpKOn+YhqohnJEbEGqv1EneE6b
 zTG1+DKr+j/1fuZuiomY6tf6AUoWdMTgFkjCDmUg35ez9kTo4IylmUR2ewlQigLwkrxoTwZ6Ub
 MtB4pv5/vlQ+Hc4/DJge/pauYFsQoai5zeUGc30+t+iummzIi5JH2bYtseLlZBbwG/yu1oIF1X
 zLp2uE/96S8yKUo30E3JYU+ORmfOcCMzch68uvTsy3LGIYZP1TraT9nrxh4+rNg6OPdMBtGbc7
 eJE=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; d="scan'208";a="145259205"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 02:37:45 +0800
IronPort-SDR: dtLfQ+492PLb3Kby9vRkXKOgLGduoF7wk3o8au/eHrz0TXVEAo6M5eCVsgLGjjpsoy/kKeTihn
 qTQgWjr4dU+7eLZLK9Cqo9OB+9pF/wrFU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 11:26:44 -0700
IronPort-SDR: 5RQZ1Ug9JG3R4x3uzGq0Ntw3wKuxivEWpVg51Uh4sYDZFBDeKMK4ryqFtU7kSOsQYr9/4yR03E
 ibAtu+NOrvLw==
WDCIronportException: Internal
Received: from usa003490.ad.shared (HELO yoda.hgst.com) ([10.86.58.205])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2020 11:37:44 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Add OpenSBI dynamic firmware support
Date: Thu, 25 Jun 2020 11:37:38 -0700
Message-Id: <20200625183741.642407-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=43885dcdb=atish.patra@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 14:37:44
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

Changes from v1->v2:
1. Rebased on top of latest upstream Qemu (with MSEL changes for sifive_u).
2. Improved the code organization

Atish Patra (3):
riscv: Unify Qemu's reset vector code path
RISC-V: Copy the fdt in dram instead of ROM
riscv: Add opensbi firmware dynamic support

hw/riscv/boot.c                 | 104 ++++++++++++++++++++++++++++++++
hw/riscv/sifive_u.c             |  45 ++++++++------
hw/riscv/spike.c                |  52 +++++-----------
hw/riscv/virt.c                 |  51 +++++-----------
include/hw/riscv/boot.h         |   8 +++
include/hw/riscv/boot_opensbi.h |  58 ++++++++++++++++++
6 files changed, 229 insertions(+), 89 deletions(-)
create mode 100644 include/hw/riscv/boot_opensbi.h

--
2.26.2


