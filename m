Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE24CC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86036206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BjyoCmc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86036206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAMtY-00053z-H6
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 19:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsL-0004D3-2z
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsI-0002eh-Vb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:27:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsH-0002d5-E7; Tue, 17 Sep 2019 19:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568762829; x=1600298829;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EJzlPIrMnetBda5kVTTZ4+h2B0wCUrzekp1I/yGMSQc=;
 b=BjyoCmc0wZBoaJ26q2biXstRDGgppz76jCIwi9uvhx8IViD3+9QloQdw
 4SvHXHnCDW2N8z89PA0ihJm49LKoKEtBZ0abialQpGLNKQxdid86HYq6g
 Be7WZocVAxSsPHDUrOev0pmDpBkChS1B8F62umJkJ271n4Njb6tpyZ+Fy
 V9gN25LobOMgwTus6f3wt10jKSrFmeslxTr6jwswpwVh5yhYbaE6sJUui
 EfUTQLTV7DgOnrgrqRJaHlb+sk+k2wezBjnCCHGBGcATRi3I9Q/Di70Ud
 fbAinJ1uNLBjmhMKKJzfc/rHxwQdLuf7LQjMD260ZFITJLvMC1kvqG66z w==;
IronPort-SDR: Nl9p3A3z6DUVmsTB1iwsjxavLxf9SHehZObqRnd7hWRLYNMWGYyHdoA4fR1Xj5mNucujTIIE83
 1YUuwOK7bHrHl+j0unqo0680SDxw+/Yr+Bx014fYvKWMTDvu0fU6S16sAKG6Xcaps5cReczHp4
 GQ5S5nHLdhcJRVyUqa4LF8yRL5f9Y9AF7o7TtrO69P1gjgCusxSDBg6A4VhWEF3Uy8f5Qas5Wz
 qLSL8w0r4OQw+CdldLjCDm5AoDa/DCxjZjnE2GjASh1kuv1yr9BleHbJiJxe8px71Nt0oeTVmy
 JqM=
X-IronPort-AV: E=Sophos;i="5.64,518,1559491200"; d="scan'208";a="225302167"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2019 07:27:03 +0800
IronPort-SDR: i9TkJDhNylHuZjwUxl6TPTJOIJI5STCUV5dBFcfMPgOz9+3SMhLr0EUXS+4Zla8+K8V+oWgj0p
 vYzfh+J5hvLgFp72lHGFBj+S3rYLxvVaf7hDXQLDAwAdMRlcLsefv7ObR40fZrZbcljrgo3BYs
 8HzwMv/f+78o/b5PUeD8LFOWD69hr/M7FGFTjHnidGj1e6Jxs7XuLvtUFkmFPVFQKpAgCEY5T4
 fpjdYO4cjoOGr/3w43/sHRqoCVtIYht9HFrlVFVG7urzNwAdQnQlnS6JT8tk5BxIQyKF1z/M37
 FVGEZUZiA+gsM/oWFIJTTnaO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 16:23:38 -0700
IronPort-SDR: DhtJbzrQudJ3knv/x92LVH/H3piMlmB3Y9UBgb6LJ+XJLjzJC+hkkpRysjkjlO9BAyncuAAStJ
 v8idpIUIrAqHfKQ6rVkAe/WlzaeoHsWkEfDgD67iSmwqWghwL/ht0gqdK4k4Kpdeya50M2me64
 5glD6qgNlgh3J4YhQAbtT2qW+Qbkl7VhrCeAeiNN97/nIhLtFf9ZOh7FOpLo0TVY4J/WVBGAHP
 zDUNjcRYQTWvWP+oYjrHgz23T9qk8Q4p9POHEygd0T8QmihDEIo3oSvM9yIHWY39PRX2q9TSn2
 /K4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Sep 2019 16:27:03 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 17 Sep 2019 16:22:56 -0700
Message-Id: <cover.1568762497.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v1 0/2] RISC-V: Convert to
 do_transaction_failed hook
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, alistair.francis@wdc.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The do_unassigned_access hook has been deprecated and RISC-V is the last
user of it. Let's instead update the RISC-V implementation to use
do_transaction_failed instead.

After this series I used the 'git grep' regexes in
docs/devel/loads-stores.rst and these are the memory accesses inside
target/riscv:

monitor.c:102:        cpu_physical_memory_read(pte_addr, &pte, ptesize);

cpu_helper.c:262:        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
cpu_helper.c:264:        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);

translate.c:782:    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);

gdbstub.c:328:        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */

All of these look safe to me.

Palmer Dabbelt (2):
  RISC-V: Handle bus errors in the page table walker
  RISC-V: Implement cpu_do_transaction_failed

 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu.h        |  7 +++++--
 target/riscv/cpu_helper.c | 23 ++++++++++++++++-------
 3 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.23.0


