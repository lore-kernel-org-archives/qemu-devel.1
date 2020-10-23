Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB7FC5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2621121D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CoFzHsld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2621121D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzrB-0005aQ-3o
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzF8-0001zk-Rn; Fri, 23 Oct 2020 11:44:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzF5-0003gF-Uy; Fri, 23 Oct 2020 11:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467876; x=1635003876;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=u23rg6vBDGmDEewsmSCU+NOvC8v3UBs+iesU7HWgke0=;
 b=CoFzHsldvQ/FTUJkQ37RruFq1e7ZhrSXi8TfdDuKkf5lbzrGVmPa6+X7
 pYyI+5msqP7LXKqtenqKizeUR8+eIPR+yYiBFoo9FdmusG/C1d6qxzziy
 077wada/3uZqwCmMCQrI1uRUX0AVTtvhZIOFGIQmePEsRTgOsaewM6Zv/
 CoQO4BLkyAzixtaax5LeIq6FqCcRZEDipg4r+gJPg3Wsn/xm69qTAoywp
 V+yw8gPSXkqT2S1vmVKs7MGQIXmsstU2YkiaV9pYIpFWJ97WvOXUuDWjN
 ScIX4Ly/tcfGyR8Cqra8t6X8hFGriylzur7ykstYRg98Pb2OZijRBiW5v Q==;
IronPort-SDR: rwXXBF3ruf3KyE0T+PFqKF1WimZy49vyTrQQP2ctC99G1JjQLx7luCDvA1DVHuqfLqpd48TQDN
 qMzlYTW3aikmfBWnnJCi15nofxBkCrR1ql5Yw+P1HPkVB8XTwOspB1mY/ZfD1RBnuXJsbmOFU2
 blGzOa0yJRx7gOtLJTg7qbo+kIsLYiNy2z37imEolqX+0iO/nDjU2d/pemL515rCoU/3tLqvTW
 xvYDBtuVaJGf+dhVo0nEp8RbqmFSyAlYWGopQC2Rosa9SpJZjOAi45p4TAQw4sxtZjKHja9xNx
 xB4=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="151960140"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:44:34 +0800
IronPort-SDR: ixlmnr7PScScj/u/Fm6iWHgwTPDSg50zk6V4W8Myguf7CgqndkUgNfApTKkI388Ochxdii71SI
 h+NObqC1dGqsBGaP3bpHffsxfnPcHHiaUOp2ojgdaggFHGM2gBJu2QhA7h/xyzQSIKux1PPqzy
 mwAFr33L7AD3Hfo1aRdKE20XxX9qvsygCT2lQNyaK9uT+Kk0bNrpYBjKCtoje5WhxQXTsGxBoT
 kK0WKbbQz9G9PN6WLbdrxnL9YAy1RGFVCTdqjETday3dV5y48PAxI6ibhnmAtpS8P+V+t/WVKq
 dbGq8wHMaGhOXRhlNFhZNwWd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:30:56 -0700
IronPort-SDR: LTJCRavRIiELbkhAUHysGlgtljIbz+0KZC8Q8TxKQRJk6PLvGdeaeYyt1IqJBl3IaWYSJxCNWQ
 4qlqDtIe5+rr6nH90LFa2W4LbCO5NFyyzP57b9wWi1VAdIXEjRJgIrJTh2wrw2FFTVOz6u9QUo
 t/6/weKnbtEqRPtdeZqILFw0T2pK+3o1zHvC8ayiY10RoBtuiZGQdCUB1YPeVJGLyjaUwjEnkG
 x4e1hI5+KN+tdi+25hl67AyoKh1EW2PGiMbopw6wJff5InvZqIVykT2W3i62974JD2JXrDwnQT
 dj4=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:44:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 00/16]  RISC-V: Start to remove xlen preprocess
Date: Fri, 23 Oct 2020 08:33:13 -0700
Message-Id: <cover.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:34
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The RISC-V QEMU port currently has lot of preprocessor directives that
check if we are targetting a 32-bit or 64-bit CPU. This means that the
64-bit RISC-V target can not run 32-bit CPUs. This is different to most
other QEMU architectures and doesn't allow us to mix xlens (such as when
running Hypervisors with different xlen guests).

This series is a step toward removing some of those to allow us to use
32-bit CPUs on 64-bit RISC-V targets.

Alistair Francis (16):
  target/riscv: Add a TYPE_RISCV_CPU_BASE CPU
  riscv: spike: Remove target macro conditionals
  riscv: virt: Remove target macro conditionals
  hw/riscv: boot: Remove compile time XLEN checks
  hw/riscv: virt: Remove compile time XLEN checks
  hw/riscv: spike: Remove compile time XLEN checks
  hw/riscv: sifive_u: Remove compile time XLEN checks
  target/riscv: fpu_helper: Match function defs in HELPER macros
  target/riscv: Add a riscv_cpu_is_32bit() helper function
  target/riscv: Specify the XLEN for CPUs
  target/riscv: cpu: Remove compile time XLEN checks
  target/riscv: cpu_helper: Remove compile time XLEN checks
  target/riscv: csr: Remove compile time XLEN checks
  target/riscv: cpu: Set XLEN independently from target
  target/riscv: Convert the get/set_field() to support 64-bit values
  target/riscv: Consolidate *statush registers

 include/hw/riscv/boot.h   |   8 +-
 include/hw/riscv/spike.h  |   6 --
 include/hw/riscv/virt.h   |   6 --
 target/riscv/cpu.h        |  36 ++++---
 target/riscv/cpu_bits.h   |  24 ++---
 hw/riscv/boot.c           |  55 ++++++-----
 hw/riscv/sifive_u.c       |  59 ++++++------
 hw/riscv/spike.c          |  50 +++++-----
 hw/riscv/virt.c           |  36 +++----
 target/riscv/cpu.c        |  83 ++++++++++------
 target/riscv/cpu_helper.c |  47 +++------
 target/riscv/csr.c        | 197 ++++++++++++++++++++------------------
 target/riscv/fpu_helper.c |  16 ++--
 target/riscv/op_helper.c  |  11 +--
 14 files changed, 328 insertions(+), 306 deletions(-)

-- 
2.28.0


