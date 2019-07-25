Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C3CC76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67CA22BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LJDzFCNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67CA22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqito-0006b4-Mi
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitS-0005WP-7I
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitR-0007TB-5e
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitQ-0007Jq-G6; Thu, 25 Jul 2019 14:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564080909; x=1595616909;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LLbywoFxWc8iuvtbYkLctRgebTuTt4zygICmKZJse7k=;
 b=LJDzFCNndH0hclNUZtN6FgiET9c+3AJ+un7/Fx9bp4jWWpKIQGrvEmEA
 34vpvDMwBE/iqzUtdemoCOMJo34Pfks+sinE6VOdDP3GmkN083GSreom+
 eOXvl/My1S86rqspPX0KsBPtvs0y5N37dOqjoXfLGKWILrSloI6ZVqVv2
 +Eyfj5B0EeQJtchg+RwpdaikQM/j+cqGF3sAcXo0hm4gdr3MlMSSxzTyB
 iTjzZW49R7hB1k46NzxrLAJ1gX1FT/j39OM/uLKDZmT+n7z85Cku1GJ9W
 ABfQBFQeokpfPVh/E9XAo5wyZ4otc4IFluQn2tTG8ZAS4KJtokVFWRXLI g==;
IronPort-SDR: 3dovIa5r3V7YZkNQyo60absgnA4d+HZt7b7EOvPdFhw1u1nbOTq1AnjKq3JX61ciYIw+oigUVg
 V6AFCsa1qasw967kzOppZA46zQc/QGR2QYR7O+sNFW5wftrI2At2i+GAFpzOtmWKKhlF43k4MF
 DxnrBqHTGWSbTdoaEnryXjwPbn5OgrnO8q6hafW8tNF3knsuLcf5XiZeg73IWPieKqwj2yJZMd
 d9G5C1bEXgJ9nauLROioR5toXyTBvuR+5h8HPUBezp6CiuDLO69650d2OK6yrLSLnXAn2jLs2H
 /Us=
X-IronPort-AV: E=Sophos;i="5.64,307,1559491200"; d="scan'208";a="115684822"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 02:55:04 +0800
IronPort-SDR: s5FJwygyhrsM6DDUFWeFkCnPWu4J8WUt6lS1HLhp8FNq2+O0kH3mx7e6OQx+BQLTi/q1z4JfFj
 TXGKLAuLyXd6kpgqEsB7VQKGkL98kvNQqv0ZVBLfF9ISZolbTYztK2PDp8CjSMSeqR+D1kfy00
 sbHKBq2V5pp6+dPGXZtT/BNuPrOvmAtkQM8snkAcOyRlQkzX/xx9WHG9DA51dNc1idc7RBwXma
 6/cfJmtaowfNVqwczngbfSib1WfH/0wdq5czSLxZapNOHdn/wV/wMutn6eReP0oOuO2g8iDIbk
 +E/V5YXr69h0HzaKV67sJhQf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 25 Jul 2019 11:53:14 -0700
IronPort-SDR: 3QKObQufGOY7T2CyWkHUH/mud/mOLaT//1cKbulfwdlJCdF1tHE74PCgIFaOaK5IkoMfELQJ2m
 /saAyrCOubQbuyiRnuQAwFhk2IOEqYFHI8VUaGEEjo2vXZrvujJ9kqpUAfaHwBW9IxUk96ooVQ
 KwIoZ9KmM4pjWr0IESmT+vJ1hLlf5Mfi4Fdw+0JHgXiY+iICXH6P7IUbmS9yzmd3h3raKVfZ2S
 EPJ1lOnQRCIUo0cI0eEeAltNTWr6GHDIYWaC4yOMuVDEx4IjYMh/ZF4tSSOTjHC40ye9fwQAD1
 2dE=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Jul 2019 11:55:03 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 25 Jul 2019 11:51:58 -0700
Message-Id: <cover.1564080680.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH-4.2 v1 0/6] RISC-V: Hypervisor prep work part 2
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first four patches are ones that I have pulled out of my original
Hypervisor series at an attempt to reduce the number of patches in the
series.

These four patches all make sense without the Hypervisor series so can
be merged seperatley and will reduce the review burden of the next
version of the patches.

The fifth patch is a prep patch for the new v0.4 Hypervisor spec.

The final patch is unreleated to Hypervisor that I'm just slipping in
here because it seems easier then sending it by itself.

Alistair Francis (5):
  target/riscv: Don't set write permissions on dirty PTEs
  target/riscv: Remove strict perm checking for CSR R/W
  riscv: plic: Remove unused interrupt functions
  target/riscv: Create function to test if FP is enabled
  target/riscv: Update the Hypervisor CSRs to v0.4

Atish Patra (1):
  target/riscv: Fix Floating Point register names

 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 target/riscv/cpu.c             |  8 ++++----
 target/riscv/cpu.h             |  6 +++++-
 target/riscv/cpu_bits.h        | 35 +++++++++++++++++-----------------
 target/riscv/cpu_helper.c      | 16 ++++++++++++----
 target/riscv/csr.c             | 22 ++++++++++-----------
 7 files changed, 50 insertions(+), 52 deletions(-)

-- 
2.22.0


