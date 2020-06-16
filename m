Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E617C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87D92080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QWDSK3n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87D92080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlHGE-0007EY-S6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4293a8cce=atish.patra@wdc.com>)
 id 1jlHF4-0005lq-Ir; Tue, 16 Jun 2020 15:27:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4293a8cce=atish.patra@wdc.com>)
 id 1jlHF0-000622-UH; Tue, 16 Jun 2020 15:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592335646; x=1623871646;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BCQEud8nctdxeuTBbV3AD6CHbiAsnsmb6Wl6wmGrviQ=;
 b=QWDSK3n2mmAFw9Pl3rPwxDOIqcJPQoUoT93ekk9iMB/mz7AWpHK5PIG2
 JysX3IYnAtJjyGU+ZDblPA8qbKqP5OA9IB7gpPIHM9XVKRrdpVbXc6/zq
 uPndMiphE1oam04VOtGQ84qF19n1ly+6TS5Lh0/ojtbU3VLXHoB0pFiDk
 ZTLmFEMv2AbU2rF7wxnSK3lhfBPPgwJZMsTzHfISO483yFK7G+g+OQhRt
 yMVqaGdu1iT8DswDHBWpdnDBFrWwRvz6n5SFM2/QeOTXWYQqApI5tj0PM
 RXV3SNSGDhHI0L2RXZVYYhq1WWUzjRyndJohLAtKR0pPH+75pzVe/9g/W g==;
IronPort-SDR: Kkufesrz5hdaRigcggbzQdcpwYOQJFWIUS/lsTSN6/FvQcsViDt19CLDAXoMIczei0l3JUU0U0
 7WPFsRExUIpKf6abt9c1N0PsRC45okODlN6ib0CZSYLeKRMc3uJ9kpLiPFh/tp5xQynsdAMpo7
 xNSoA5gxm4sCji3FNdrGGWzSjcZfmUUA9aEsxUQjkDt8eXAm2I7wUz7g05UyEbZFt9t37ekAng
 Vx6fuXcspUoGjTrE2Ttf92bg2xfh/L8FY7rrNWucOdWfwKgYuRQT8HZSt5WxdVhUycoVLMMhP2
 LMY=
X-IronPort-AV: E=Sophos;i="5.73,519,1583164800"; d="scan'208";a="140158600"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 03:27:22 +0800
IronPort-SDR: C1yjWYAnq9g+5pY+6tfLYqbSVfWEoQJO7pRD9GP4vaD7ji0o3bKNIe4x8g78raxn8xYRKJSjEp
 jIqkD6MdCfJhaIZzNzVxX4UI0O9Q9ktGc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 12:16:38 -0700
IronPort-SDR: tbE+N/BUPZQWYP6ygLzr5WdP+uYhfyS6oSN6u511ezmHm2FZX/UvUbNdcG0sMweGPHClwRZxVo
 5R09ZSpLZ4MQ==
WDCIronportException: Internal
Received: from usa001615.ad.shared (HELO yoda.hgst.com) ([10.86.58.120])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Jun 2020 12:27:21 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH  0/3] Add OpenSBI dynamic firmware support
Date: Tue, 16 Jun 2020 12:26:57 -0700
Message-Id: <20200616192700.1900260-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4293a8cce=atish.patra@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 15:27:22
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
 Palmer Dabbelt <palmer@dabbelt.com>
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

Atish Patra (3):
riscv: Unify Qemu's reset vector code path
RISC-V: Copy the fdt in dram instead of ROM
riscv: Add opensbi firmware dynamic support

hw/riscv/boot.c                 | 95 +++++++++++++++++++++++++++++++++
hw/riscv/sifive_u.c             | 59 ++++++++------------
hw/riscv/spike.c                | 55 ++++++++-----------
hw/riscv/virt.c                 | 55 ++++++++-----------
include/hw/riscv/boot.h         |  5 ++
include/hw/riscv/boot_opensbi.h | 58 ++++++++++++++++++++
6 files changed, 223 insertions(+), 104 deletions(-)
create mode 100644 include/hw/riscv/boot_opensbi.h

--
2.26.2


