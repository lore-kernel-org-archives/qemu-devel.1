Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBBFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DE42133F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T6xf1bTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DE42133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BSe-0003nC-Gg
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQr-0001bi-Cl
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQp-0008WU-VQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQp-0008UJ-8p; Fri, 23 Aug 2019 11:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566573891; x=1598109891;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KyjKoVgbWjhyAWWaXNNmm6XdA3xsCMe/mYWaSmUNglc=;
 b=T6xf1bTJEEwE3Un/lQx9EgjulVvu21027OdRi/tVLB7M4aQytW5tkt2U
 fIqkmdLUy74q++8tltbRfbB391YuhonJOo7Li0KE6YDnhAi6IGyBhmiTY
 xn1fMFAX1x1fXuPzIBCD0UCfIfEbP4Pm4tOK6n9kNLjKKE+jBIDRSE7B8
 4IjuqZoCdlJoKI6eLzj3JlvpO3c3NGvJWkgvYm4EHA2fiWxbb5puI9al/
 8Ht3DDUuxAZ677MW7LHbcE67iI82JX0k6AAe86xquYR14NPEsW14DsxgE
 0AT1astSwuyJoi3PJaarvil8bVQoRtSrFtnPmRKZ6k1bOA0xXo7+3Xrq5 A==;
IronPort-SDR: 9n4P8hYC0npJ366ZGU9zQOdrxdct5YJbyk7wYlZCPztHH0hzboRR926VZYD/r/0qd3//cpfnzQ
 hukMjR9jvKh8C+RnyYRD2Ll85KrvIsdgAaGsQTKyshaqHPRJxEvQsHpaTRUWNKatdBmbfRrVd/
 JdTcAT0y+gYudIDOD0KPnFpErXrGG3YSxPj6S0buZwPbKPejWBy68h45jAd3kKP4ZgkH8pw2QG
 x6jjibnf1gDZ1oQ34kPFVzhUGucVcDxE7UWlHVoWfC9wpqOb4G8I2dNIUYZh2EK1GBeoTnPIdo
 EO8=
X-IronPort-AV: E=Sophos;i="5.64,421,1559491200"; d="scan'208";a="121112408"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 23:24:47 +0800
IronPort-SDR: m7F8lq3QBG0YSspES/EuyHIvQr682LuuHpNwga9651x9ORCZpMslCOYQEmHUwmmE1xpfKQBJIP
 lpb8cG2/gaW0YOrKBOEdAboXN1LfvwlBgoAm7eXpjzIgu7K5GuxbiAwULrlw9BpcbN5dno63F7
 w1wCvI59prYATAhyHlI/t/bpqDHAv/KmQwNL1GS8Cofu8gl10P0X83XG1JeuDKml881eZ3PxLQ
 CjmwV4x5RX62cXgw61d9+1X8ClYWxk4vp+0R1IeM9wf4/+D03bk5tdOXWX2RTq+PGUqaCTIvbs
 Ir9lbprqV7QhG2em4jgf3bX4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 08:22:04 -0700
IronPort-SDR: ArdcPMrAyMyFGftskyl36yRMFFw57SG3j5QQbf5GSPVTa2kHscmc5Gm8zu2Qfx3kFm7vZMxYzB
 QpM+918FsJzf5+8kVbgE1sfYOn8O3Q4NR99OGA59oMqRVCsY2D6PRJgm+199OBTpvoN33H1niU
 ATi5HlyDDTd5iO4v4okliMMSuahO5WBtdy2iOtyMnwYyx6R8KB51usJwDzX7CvTgs4m3BPDEhZ
 8w1QiT1/mfcYp9Bq4V/OEsoFuAmHrmoPrLF2rmu/I7+wdJCDDxfgPAg0g+jnMzvMnXeal0on9i
 Wpo=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 08:24:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 08:21:06 -0700
Message-Id: <cover.1566573576.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v4 0/7]  RISC-V: Hypervisor prep work part 2
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


The first three patches are ones that I have pulled out of my original
Hypervisor series at an attempt to reduce the number of patches in the
series.

These three patches all make sense without the Hypervisor series so can
be merged seperatley and will reduce the review burden of the next
version of the patches.

The fource patch is a prep patch for the new v0.4 Hypervisor spec.

The fifth patch is unreleated to Hypervisor that I'm just slipping in
here because it seems easier then sending it by itself.

The final two patches are issues I discovered while adding the v0.4
Hypervisor extension.

v4:
 - Drop MIP change patch
 - Add a Floating Point fixup patch
v3:
 - Change names of all GP registers
 - Add two more patches
v2:
 - Small corrections based on feedback
 - Remove the CSR permission check patch



Alistair Francis (6):
  target/riscv: Don't set write permissions on dirty PTEs
  riscv: plic: Remove unused interrupt functions
  target/riscv: Create function to test if FP is enabled
  target/riscv: Update the Hypervisor CSRs to v0.4
  target/riscv: Fix mstatus dirty mask
  target/riscv: Use TB_FLAGS_MSTATUS_FS for floating point

Atish Patra (1):
  target/riscv: Use both register name and ABI name

 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 target/riscv/cpu.c             | 19 ++++++++++--------
 target/riscv/cpu.h             |  6 +++++-
 target/riscv/cpu_bits.h        | 35 +++++++++++++++++-----------------
 target/riscv/cpu_helper.c      | 16 ++++++++++++----
 target/riscv/csr.c             | 22 +++++++++++----------
 7 files changed, 58 insertions(+), 55 deletions(-)

-- 
2.22.0


