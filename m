Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72E6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 22:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D09820672
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 22:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yk7Nz5jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D09820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtepB-0000WH-Rg
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 18:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45291e402=alistair.francis@wdc.com>)
 id 1jteo7-0007Uy-Ab; Thu, 09 Jul 2020 18:14:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45291e402=alistair.francis@wdc.com>)
 id 1jteo4-0003wC-1o; Thu, 09 Jul 2020 18:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594332856; x=1625868856;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bna7bmE33T/p5LBVAqkYsFbWUVy5FO2obUUpf0nGopY=;
 b=Yk7Nz5jMKL4NxKZYSqkysusLaHkgdUrgTOUATcnVNWHHxkmM6iToauh4
 Jx/LG26uyeyvHHkUG8HSf1zSr+L9RZAnHf5fuRU1a/1wxIaGhv6W8WGsM
 eybiTUQjZ1Q/RvBbeEoAhIx9Fq78t/N7X8zdJDTMB+hJGG1OH8XMfKk6e
 PuWujbG7AzLDX/qypvkD5Q73DROYZu+w9C2eVZ6ZGX+bafTp/TI0rwpix
 CEiQXUHBFwQ//J2j0EydEBMrQihtJ2fYdxdc9z2NDCB1ozh7vScBH15zw
 0JHc6OBCgHTYaEQTmPUTRk4fxdLouZqahkEm9rcv7UNMyhq+frERQaTAC w==;
IronPort-SDR: cF8l1fQ6IoaZwjkXAV070CW4T5+F1x+0hUXm1G0qssm044dAN3TFHkPHSDgS9RFXWh3RIFY/Nf
 8MOElxZ/8S6XlMBwBiMHfovVVRThGtSU7m2w2Oko8oz0UgGPaJJmpYVqFsOqtzDBQNiXv8lLQA
 Y0yNgnb9YBX49mte8M+d7ttjP2CFgjBpFA9KF0mKCFNKlvlbnMJLRAet8JLi3x/YM7wGJMY7Bp
 gGSgASKuWT2+M3D64Cd2jPX1hwufaR3N+kfH/4NkktX2p8kiO/K22CoW4sVH1S+Otql4CaKgvV
 zSM=
X-IronPort-AV: E=Sophos;i="5.75,332,1589212800"; d="scan'208";a="146394137"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 06:14:11 +0800
IronPort-SDR: hwg1EvKylje0nS6w7Es9n2W5hiTsyRKEmrCqzEzSgvXQfkpAK9vtkGrVOFeS4CYu8mWZwTZUQ3
 iia+9fNgE7n8bwXLjimN9mdyjU7vfbqLw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 15:02:46 -0700
IronPort-SDR: Sb0N/yHQONwEBSDqfDttpT39uToqz+N0WkjXXdkkwGEYQAXbW389SlmXvfDPxWb+U2Fv/Uq4HJ
 AXh4G7/YSfvg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.245])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2020 15:14:11 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 v2 0/2]  A few RISC-V fixes
Date: Thu,  9 Jul 2020 15:04:45 -0700
Message-Id: <cover.1594332223.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=45291e402=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 18:14:11
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This series has a few fixes for RISC-V OpenTitan

v2:
 - Convert Ibex UART to the register field API

Alistair Francis (2):
  hw/char: Convert the Ibex UART to use the qdev Clock model
  hw/char: Convert the Ibex UART to use the registerfields API

 include/hw/char/ibex_uart.h |  79 +++++++++---------
 hw/char/ibex_uart.c         | 158 +++++++++++++++++++++---------------
 2 files changed, 129 insertions(+), 108 deletions(-)

-- 
2.27.0


