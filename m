Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74272C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222F8206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l9vnh3JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222F8206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONLc-00048t-47
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCD-0004At-6N; Fri, 02 Oct 2020 11:42:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONC9-000453-M6; Fri, 02 Oct 2020 11:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601653326; x=1633189326;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0HTateo18iUxCP/o7SnyVlB7WB9LUVcNYksYzOjQ5cg=;
 b=l9vnh3JCtg8Io0Y783u8Zg6SxTkDr7srjdg1s6pRAmxtpcXvXsgGRaub
 A+mqQi1LUjsE+9kJSSyUOy/62CPCIUSrUbFDdDEMgckLjJkIBchjyzhWj
 vXig4y8wKHakTj1clFl0jzoFjw3r9184kcnBgcTDuNxuqh5rA6BWhCRz8
 O46dJTrFw5E3fjMtXf0+OsBb225sp33+9hctEQKVpveM3Ukq2XmDyxaYo
 WbQ2mKWr4cUkZ/2sFamcoFunZIEUFCorw9r/Efnd7pUg6l042w9qXjlP8
 XEtJW4j6julxmU2nuxNTxEcPrXdWRkqs+gnc2kqZ52VbDQz0nyqm9pT/u w==;
IronPort-SDR: wIiYb1EdMaWOzKuTGSVRyv3jEIx1IYYL6/aat7dUBy//ZC8CXT/1kyNznp1JKajz0ii7Yu2rAY
 DozBR7TQWdVGhERI2eTIvMzUZFVi1jJ/wYmSFzkzeS1XW/alaS7E5ZEmd5bCidsfC3/cxWkjDU
 aQgaH2L5bFfwrop0qUVhGxoLi0BvplJSx/4OUKNam9bOaJrdWsUHpHwbpSuxM2bG8pOdhdOfCw
 TIXCoGjrNf3OPNUTKjwV+cnYhQF7ehF2JR+Guzz88k4PTjB2xsuhKKAST1zVW2tMzdJ0Ouw+WE
 sfo=
X-IronPort-AV: E=Sophos;i="5.77,328,1596470400"; d="scan'208";a="148978269"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 23:42:03 +0800
IronPort-SDR: eqEUKi7pxiYoc9OwYRgvbLUaqhyoqtGj2v4mqSUwTX5edXt9pLXoZULLGBuq7LKdqWFlSgSTqy
 laYLjZUZgl7Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 08:28:52 -0700
IronPort-SDR: /1b0orLLVyWGDT5kvADUc29Xg3gz0IVOnq7/y7uDjslv6l7UelpmUujTrtLrPqGKS+MGWiH4yb
 xynpdB3s9ZsA==
WDCIronportException: Internal
Received: from dbzljc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.174])
 by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2020 08:42:02 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 0/4]  Allow loading a no MMU kernel
Date: Fri,  2 Oct 2020 08:31:02 -0700
Message-Id: <cover.1601652616.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=537b2d3de=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:42:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series allows loading a noMMU kernel using the -kernel option.
Currently if using -kernel QEMU assumes you also have firmware and loads
the kernel at a hardcoded offset. This series changes that so we only
load the kernel at an offset if a firmware (-bios) was loaded.

This series also adds a function to check if the CPU is 32-bit. This is
a step towards running 32-bit and 64-bit CPUs on the 64-bit RISC-V build
by using run time checks instead of compile time checks. We also allow
the user to sepcify a CPU for the sifive_u machine.

Alistair Francis (4):
  hw/riscv: sifive_u: Allow specifying the CPU
  hw/riscv: Return the end address of the loaded firmware
  hw/riscv: Add a riscv_is_32_bit() function
  hw/riscv: Load the kernel after the firmware

 include/hw/riscv/boot.h     | 11 +++++----
 include/hw/riscv/sifive_u.h |  1 +
 hw/riscv/boot.c             | 47 ++++++++++++++++++++++++-------------
 hw/riscv/opentitan.c        |  3 ++-
 hw/riscv/sifive_e.c         |  3 ++-
 hw/riscv/sifive_u.c         | 31 ++++++++++++++++++------
 hw/riscv/spike.c            | 14 ++++++++---
 hw/riscv/virt.c             | 14 ++++++++---
 8 files changed, 89 insertions(+), 35 deletions(-)

-- 
2.28.0


