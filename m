Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFA0C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623FB221EC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aMi7XaaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623FB221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMXBc-0007ms-Fj
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 09:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5325bd5c7=alistair.francis@wdc.com>)
 id 1kMXAv-0006wx-4O
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:57:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5325bd5c7=alistair.francis@wdc.com>)
 id 1kMXAr-0000LX-RS
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601215029; x=1632751029;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RMhh2wJUczyB2VXuO39/PLCLiK0DgPuBNqJdks6KSbQ=;
 b=aMi7XaaGPWuYoCO/qt39/b5bVZvc71xIj00bNNKbyr10qN2r71jckGnM
 JqObOWHpLQHkgj9i6+BfPcOImMpIU8C5ie/HDFpAxCZPxcTMdkga834CS
 A8wziTRCl//HFstHuclJfYdWBtC3E6hiFI3B8K4Fhdt5bVNHRPQzSNBsW
 lWVpkn/GguAZR5TXOGjIL2UcP8CIZgkUyuTHgShHb/psOGPiAQxUb0wE2
 ZGtsZeW8ErSSmVZqEMOMOc3qmJNjBpJq7qCBa6CN/WWH+AnhhWeFMqrZ0
 vGVWaSjzKH2ixwk6yyfRpbytPK7Sus47dYNdlTPWNtPWWQGGsUAZdPyZX A==;
IronPort-SDR: 8tzYBw8x8g8ghI/2LLQ47Kga33u5A7+5eml87syeoRoGKuhBXkSp40FleKXzPKSMLXFkfrf5xW
 oMRRCjQHyGfGHmnpfRSenqnCqxW4bO8mjhy4m4DmWl6WNNpekzEoWBlNr6oishgwgrbRwTFkLd
 R3swiQH5Hb5HzdCI8RrM/4tak9y1QjP+QJQ5yB3J37Z3PNgOY7ON7BPzuMqqfMeC9BZGnKbufO
 RHje56y0WJ5imeqYLEUiEtey3E9vz0WXF3y4r0xgkRVIKEK5j6o2G0P82RKb2kHUlBoo7pLzDx
 ylc=
X-IronPort-AV: E=Sophos;i="5.77,310,1596470400"; d="scan'208";a="148291507"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2020 21:57:06 +0800
IronPort-SDR: sDIVimRVOMNqPvOHiRIBe6I8VnPssBgHod3G8b68UbJppajTxr2WQTxg9uE0oolKalpVeCiXYE
 MHiEeC+imJbg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 06:44:03 -0700
IronPort-SDR: LLHziA/IVyPvUm0wLfNyN8aKf+qsOQBNS/B486yDy76ci8EZU/bYyyRcbKA1hAaCgAJn9v3jw7
 rbkBWGCmRt0A==
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.38])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Sep 2020 06:57:06 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] register queue
Date: Sun, 27 Sep 2020 06:46:07 -0700
Message-Id: <20200927134609.2358960-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5325bd5c7=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 09:57:06
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8d16e72f2d4df2c9e631393adf1669a1da7efe8a:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200925a' into staging (2020-09-25 14:46:18 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-register-20200927

for you to fetch changes up to e8a612b7e3cdbdface1e34a27300ca2f8521dee0:

  core/register: Specify instance_size in the TypeInfo (2020-09-25 16:52:24 -0700)

----------------------------------------------------------------
Two small patches. One with a fix for the register API instance_size
and one for removing unused address variables from load_elf.

----------------------------------------------------------------
Alistair Francis (1):
      core/register: Specify instance_size in the TypeInfo

BALATON Zoltan (1):
      load_elf: Remove unused address variables from callers

 hw/alpha/dp264.c       |  8 ++++----
 hw/arm/armv7m.c        |  4 +---
 hw/core/register.c     | 31 +++++++++++++------------------
 hw/cris/boot.c         |  4 ++--
 hw/microblaze/boot.c   |  4 ++--
 hw/mips/fuloong2e.c    |  8 ++++----
 hw/moxie/moxiesim.c    |  4 ++--
 hw/nios2/boot.c        |  4 ++--
 hw/ppc/mac_newworld.c  |  6 ++----
 hw/ppc/mac_oldworld.c  |  6 ++----
 hw/ppc/ppc440_bamboo.c |  9 +++------
 hw/ppc/sam460ex.c      | 12 +++++-------
 hw/ppc/spapr.c         | 11 ++++-------
 hw/ppc/virtex_ml507.c  |  4 ++--
 hw/riscv/boot.c        |  8 ++++----
 hw/xtensa/sim.c        |  3 +--
 hw/xtensa/xtfpga.c     |  3 +--
 17 files changed, 54 insertions(+), 75 deletions(-)

