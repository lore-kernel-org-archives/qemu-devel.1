Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED71C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478422192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dQDTbPOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478422192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzhv-0008DZ-3J
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8D-0000CF-3b; Fri, 23 Oct 2020 11:37:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz88-0002pW-33; Fri, 23 Oct 2020 11:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467443; x=1635003443;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+kH0HRDVSR6+Oeh5CZ+4ncx3E9IpH2mTPisXyYIn8rA=;
 b=dQDTbPOJpz7awwhFk6N9hKekTmOcG/HJIoM5/AR9g4RAbfx1yY05VNTP
 M2vzMo9K7pA6PBwy+Q2+5jNLTB5lxXxfPlhIw1PO+ErGxFLufNFbs64ne
 vdQFtqc0aupuzMK8tRnNQFz+a86sUwKZWmECcxP2qOI4272YIPfQPIYj6
 r8XZP2nUrEod/IbN9/0KPhn1GO2pBrV+vYjWITzdMFFFtR8fD74efxL2I
 0AKC4fm6tzn/KAU/S8vIiUSAsYzB2qK70oFJIPidhcAIg6F1PzU2dLyxp
 ZU7vHtu0DL+gl+aQujhdCHhA45PUTSWjrcXgq54vv3wBOT7+bG80o79+N A==;
IronPort-SDR: UNLYX+M3OWNpxvLOlrAf2hY/UA/9+aW/tcuKs3Kf3JaJx/ggRHa4ukskEfi4I90UGRRj+Vsu8u
 Y9zXvGsBLLIEHUMjsppkBoQqpGd7hK0KFSlmPYRXWW1Q5UWyPnXdKV6Z1lG5EMDiPYn0XTShBj
 Dv4WWfZbZOtytyChqvYpv0J23l25z4cJJxBXcHgiM1GtTNFS5TIbtHtuAN9jM4n5Ji6uqc6jxW
 gc5IvOXd3oLWo2Dh5x4ie32ehu+iz8hz5jsPU93WuDwd1qnZmLuAMDkS7Fyk1ANHCvReSzffS4
 +jc=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="260636257"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:37:19 +0800
IronPort-SDR: fpkBGz/Qi7tu3UGtxG1ZpIpcCeQ1nzA4sJDhgvrdoq/GmC/nubpn81n73meMCS068UdEgN7c+H
 F5Mi32tR199nkEA4KPa50F0I/audKMgHGm36wO/HPizec3JFkB641Xy5FUmoA05eHczy7uUa/H
 STt1NAM7E2ERQjt/ydosLej08vPzIjd1YPMzjcDFbDMm42dSR32781gzcKUza3fAvkN7jc8Oyg
 /rEvmlTa4rWq0dF0UI91HLiGS0K3isRAboS0ErpETz8FsySLLpq5vVbiLt+vDWvjmeV7O77rCN
 dmc6bSQ4uxcKNXJaFUcT8jHF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:23:42 -0700
IronPort-SDR: CTzIUKX5P/dQ2il1GVAxigr2o2aiqXEc/GGubgLci8OKpnRduyMmfFxxRGLayRCuqeB07OUarQ
 JSn4PqL0D/cAqCFaLFtjnnkaFkEDe2r4wCmM/lmRZIHKZ9gR+ezzitPPgR1aM/EvvuZOzYbvaS
 DN8Tl4HdeiaPJ3MbLLpVCHD0JVl6YVB5DP9lMRrNqc9W/BJAg0ovyUSjC/IMrj6H0Fc2XtPYHj
 wHq9ldhG0aYTj1m/kj5HSisqDCbJbT0LjjQF5UQi7gCgx+3jVPE9ljbg7DsrOwh2ARJzfh4JPK
 fms=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:37:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 0/5]  Fix the Hypervisor access functions
Date: Fri, 23 Oct 2020 08:25:59 -0700
Message-Id: <cover.1603466725.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:37:20
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
Cc: alistair.francis@wdc.com, richard.henderson@linaro.org, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard pointed out that the Hypervisor access functions don't work
correctly, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg751540.html.
This seris fixes them up by adding a new MMU index for the virtualised
state.

Alistair Francis (5):
  target/riscv: Add a virtualised MMU Mode
  target/riscv: Set the virtualised MMU mode when doing hyp accesses
  target/riscv: Remove the HS_TWO_STAGE flag
  target/riscv: Remove the hyp load and store functions
  target/riscv: Split the Hypervisor execute load helpers

 target/riscv/cpu-param.h                |   2 +-
 target/riscv/cpu.h                      |   7 +-
 target/riscv/cpu_bits.h                 |   1 -
 target/riscv/helper.h                   |   6 +-
 target/riscv/cpu_helper.c               |  67 ++++++-------
 target/riscv/op_helper.c                |  90 ++---------------
 target/riscv/insn_trans/trans_rvh.c.inc | 127 +++++++-----------------
 7 files changed, 82 insertions(+), 218 deletions(-)

-- 
2.28.0


