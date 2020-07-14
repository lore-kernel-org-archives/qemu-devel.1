Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA71C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4AE21835
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xraz5Vef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4AE21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv930-0007Pg-1T
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91m-0005nl-R9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91k-0008OU-6V
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687352; x=1626223352;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1xXuQ4TniOj1hkkB9+p7RfrA8EtARMPpg+dYXAzRK1g=;
 b=Xraz5VefSbt7KaYkP+3+9Env6/cVvGpuF1nx8ZxWHnn52LzQBNfHRf2y
 sIJpt0hB6p3iAv+0Cx5Zy0en7hcARVAjGwlM8nJZ9do7wz5EjWuZ4p7FF
 LT3u4e5I25qfGTHDVfaMaScBtYIb9uRZ0AjxnsU5HqsZDq+ev77d/937Y
 qFyfCcLbg4nMpkFGF9mso6jigaASUNvUYt2F/7YHLY5zO8qcpWyis2GWS
 /v6Yh5ZAjHPClu18l+ZVkyzcdWz8F0bqaaLKLs3LSLTUgSfhtkB6/8gYD
 qan5WW6ZkthJgb1QDZmn+jOE/Jj/If3jvX3i+hudmQrJcD2L2/iaWN1Cd A==;
IronPort-SDR: vbI1rtL/IO7dQASJWUZVCH32jwJwYcSya0SLcewq8K5/WkWHhG5tuKgXiypu0ZDex95LEJzw4h
 nXfw1E78466XvxqDaapQ/jcQdE+G1PubXuaa3a+pVCnaOwT3H7MaKnVnzEIyTFzvf/C/qmmhlH
 Z+fcmOUNxRRjvIjQBgYMSorULawGhiQpMlglvxSkREWyI4eFhRWArBQk8TrCHjC6ZVOe0ujrmU
 /+t84cxsfrK91/xxQIPtETogCTEBNlQI2i6Y0VxuiJcBgufDS6HYs0W3LUhZbXFQz5KRcl80E0
 Ru8=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511916"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:27 +0800
IronPort-SDR: waUOr4o0YLpeF5rYTWbCSnHLrdeEy/8hcQqo+PfZCgOx6U6Bdk4uT6iYZfFYHZA+lb3OTK8/am
 tucr7ZG3Y9wt/YP0YNy9eGYNO9+xGWj4U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:56 -0700
IronPort-SDR: LCXzX4vxD1OCz+I3EWdjWIkmTLctD6OX2BaPnn1Om5h31cD4SHWaljOLjJRIB3ug107ouhOhbW
 dxvdO7uEQ4rw==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] riscv-to-apply queue
Date: Mon, 13 Jul 2020 17:32:39 -0700
Message-Id: <20200714003254.4044149-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=457b4eeb6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 20:42:28
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c46:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-request' into staging (2020-07-13 16:58:44 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200713

for you to fetch changes up to cfad709bceb629a4ebeb5d8a3acd1871b9a6436b:

  target/riscv: Fix pmp NA4 implementation (2020-07-13 17:25:37 -0700)

----------------------------------------------------------------
This is a colection of bug fixes and small imrprovements for RISC-V.

This includes some vector extensions fixes, a PMP bug fix, OpenTitan
UART bug fix and support for OpenSBI dynamic firmware.

----------------------------------------------------------------
Alexandre Mergnat (1):
      target/riscv: Fix pmp NA4 implementation

Alistair Francis (2):
      hw/char: Convert the Ibex UART to use the qdev Clock model
      hw/char: Convert the Ibex UART to use the registerfields API

Atish Patra (4):
      riscv: Unify Qemu's reset vector code path
      RISC-V: Copy the fdt in dram instead of ROM
      riscv: Add opensbi firmware dynamic support
      RISC-V: Support 64 bit start address

Bin Meng (3):
      MAINTAINERS: Add an entry for OpenSBI firmware
      hw/riscv: virt: Sort the SoC memmap table entries
      hw/riscv: Modify MROM size to end at 0x10000

Frank Chang (4):
      target/riscv: fix rsub gvec tcg_assert_listed_vecop assertion
      target/riscv: correct the gvec IR called in gen_vec_rsub16_i64()
      target/riscv: fix return value of do_opivx_widen()
      target/riscv: fix vill bit index in vtype register

Liao Pingfang (1):
      tcg/riscv: Remove superfluous breaks

 include/hw/char/ibex_uart.h             |  79 ++++++++--------
 include/hw/riscv/boot.h                 |   7 ++
 include/hw/riscv/boot_opensbi.h         |  58 ++++++++++++
 target/riscv/cpu.h                      |   2 +-
 hw/char/ibex_uart.c                     | 158 ++++++++++++++++++--------------
 hw/riscv/boot.c                         | 107 +++++++++++++++++++++
 hw/riscv/sifive_u.c                     |  53 ++++++-----
 hw/riscv/spike.c                        |  59 ++++--------
 hw/riscv/virt.c                         |  63 ++++---------
 target/riscv/insn_trans/trans_rvv.inc.c |   9 +-
 target/riscv/pmp.c                      |   2 +-
 tcg/riscv/tcg-target.inc.c              |   2 -
 MAINTAINERS                             |   7 ++
 13 files changed, 387 insertions(+), 219 deletions(-)
 create mode 100644 include/hw/riscv/boot_opensbi.h

