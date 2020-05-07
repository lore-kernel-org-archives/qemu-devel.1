Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FD9C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F45208D6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J2LcaTwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F45208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWm4q-0006jc-Gw
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm3a-0005Ie-5E; Thu, 07 May 2020 15:19:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm3X-0000wE-Ue; Thu, 07 May 2020 15:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588879179; x=1620415179;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3BOmN0aQbwbhYxPlqkEJ4JbNo9mlO/a+Hi4tks8MiDg=;
 b=J2LcaTwrFjsTa5qV1gBFZEjqwpipg6GzqrFeSjPCkDF/KOSK1hj3Uz5F
 r74rCxdkszk+BpdlP87niWuapu86ZzQMpoYZk7aJj92SoNh/p99lW3kL4
 xa8XPdJtLFIbSzJeuMCWWMjDv5HIFqNbTQ4oA2BN4DFGk7Yu+C82/A3va
 vGL9fQcNH3fXi7NgOOVWPkunOKTmrj5PTmyWX6haKJSOan55P8nfBJfXu
 XOkOVnmBOf13DT2JSgEY3UU6fex8+V7ElNuJJcSGX/g51VjkpKOrKx2ST
 LaOxnw2jRbl++PDuSFVVykYRTqZ7Jp/V6fRTbnDKYHOC8wG+PVK7xEA4+ g==;
IronPort-SDR: F6fZ14GnX3kjWmTxb1oK2tl1D656VRK+CSQlemkFBcVDmOQeNo2XVi/9msuUOBRXiwsY/fEE8j
 MIIutXUfqJsmC4FEpX/pgsBK84QP4yQaLhY5MGEWoAfwVXc1Z/3QrEJxav6JjRTLUjKH4wnNef
 vCmew4IF6dqbzfeYl0Y6Qtge3vNdypJUkuKCGlKV+jnuGrsxv6mUU52/Mp5u1rOnPdCHps9FR7
 erN+d/WCSYhkueANGMXydRPCWyom/U4g83WRiemmWhCapYytprSm1Y8/4/HecANgWEBaHsn8Av
 7Ag=
X-IronPort-AV: E=Sophos;i="5.73,364,1583164800"; d="scan'208";a="137166253"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 03:19:34 +0800
IronPort-SDR: IhYVfTT9A2n0sWA/xtr8/0aKkLKvLkGm8pEtHm2aWLIjbPgJ4zJCuAoztbO4ZL1M5Nde7bpPth
 KDHLWMLTK/WMAUqn0y3aGwbHlZW45Ae+E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 12:09:25 -0700
IronPort-SDR: xalXGVvmeC0idt3cSeOPrEBYwAkBHWxvQw6VKuGqKCkycQ8AJuIecXvD648UyyU/orO69kPyt7
 hsLYUX8enrXQ==
WDCIronportException: Internal
Received: from uscxm6l72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.6])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 May 2020 12:19:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 0/3]  RTISC-V: Remove deprecated ISA, CPUs and machines
Date: Thu,  7 May 2020 12:11:15 -0700
Message-Id: <cover.1588878640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=38990af3b=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:19:34
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
 - Remove the CPUs and ISA seperatley

Alistair Francis (3):
  hw/riscv: spike: Remove deprecated ISA specific machines
  target/riscv: Remove the deprecated CPUs
  target/riscv: Drop support for ISA spec version 1.09.1

 hw/riscv/spike.c                              | 217 ------------------
 include/hw/riscv/spike.h                      |   6 +-
 target/riscv/cpu.c                            |  30 ---
 target/riscv/cpu.h                            |   8 -
 target/riscv/csr.c                            |  82 ++-----
 .../riscv/insn_trans/trans_privileged.inc.c   |   6 -
 tests/qtest/machine-none-test.c               |   4 +-
 7 files changed, 21 insertions(+), 332 deletions(-)

-- 
2.26.2


