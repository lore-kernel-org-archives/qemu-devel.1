Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB874C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6C920674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="edfb0A/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6C920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Wu-0006DN-9L
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vf-0004i5-1r; Tue, 03 Nov 2020 15:02:27 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vd-0002m9-8y; Tue, 03 Nov 2020 15:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604433745; x=1635969745;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RU0peJADuSKlwfu/fkiIaEPW2xtO3uOhQ5+mYiqj2No=;
 b=edfb0A/C93bcUUNL3G6Sck/emAEChY2eOW9yF5ypiTo0m3AJoPepntDW
 YTmHuV+72MAKbJgMtnksG/CGv2j5DjupRSP9h5VVSW6lWxOo1/PXi9BvP
 0vmz7D9TuuVCqi9DNAbj2gt/dbAk4VMu309FXGWBrHIejs8DEaKnXJGx7
 CfODQYocY0FVWGBpzACTH6Ilke513bqRRCelf3222Yn8+ECH9G461boVA
 gE1hESXNTOzTqgOFYhC2ZHdk+Y3atRdTS8k26X0b+qvw8dGF3/Mi1+nnd
 F9GdcybhueaWWOFE8fT7Ilgk+WzyZyGlnVShIZ7upviwLZOTsao9XctrZ Q==;
IronPort-SDR: Zm11ghZ3svHx6dbF05WJImw+ieaMykem2eo0zHXmJhBQGVGHrXJkxogewpspJ18zkLrm33dK26
 BWe0jFpuK2Yz1zaIoZCTa31MWnqez1jT1Oj97pshnv7B3f4AIkw0ulCmE2josNLQCfmiHIbz6C
 TdsFGbUzTCsB2TuvHUUDHUM+PEv6RfflWtluqLagFaHGKgXUollwIcwAzgXFdw7xjKgN8wrR68
 yukqPscCK7ay6Hg++JMpnJnJ6TbMZWSzHHCE/5T8IkK0NehieKfeFl6H7eOvACIqB4A3LQ8N2Y
 e2g=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="151608869"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 04:02:22 +0800
IronPort-SDR: DVmYG+Eu+h/O5On2JU/P05pv5xSvearpZ2Y2T2WXAWIfaLSB/M97RN1S7cthISlJJS9aauySVz
 o0eXmVEcKOHIMA242NPvEx/NrnkCOY91SzaD9DzMXbUjuHjGfkm+nJi24Vmd2/HR0Lf0n0yucT
 e8fFfCifJXc7AElQu7qzgczX+qM5t2RhdFp5nQgR57TRoGwVNoqO/tvYmFiRnzmLU/RRSJ7zHk
 mDvFc53UDlpfaqvIX7G1mURfbVD4/D9GOFpz2sC4Up9oh4NtCrLUKDhe4OdoGS22K+KKc7IAWn
 fp+P5bxg9LFhgDsKHwQ3Dhbc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 11:47:21 -0800
IronPort-SDR: Z0dhLlOlPdsSIGSJPbzcehjGgP8lyku8OBfj1x0LY/Os5cuxiUjkslmSz0/f6M28716EaSxa+a
 hDw9EO3loC3Qh/k4ZhYj+PN0p5jFJGUbuZvzuKyVD77jAqRDuGBdiUj4b8wKjB/sPCuHA3Xtzs
 5ToMNOgaFMjXdQBK7fxISRURcDQt32om4IhihPTymDhUI1UWxhBtTwrZMSQOBDkUbIOWPWjBe7
 tS00sMo98fsi9d8kDU8Gtw2liBaNoP3NSUmi1RhppHjpE9O0T/txyvNpdc2acL0HneI9p00wL6
 j7w=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 12:02:23 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 0/7]  Fix the Hypervisor access functions
Date: Tue,  3 Nov 2020 11:50:52 -0800
Message-Id: <cover.1604432950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 15:02:23
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
Cc: richard.henderson@linaro.org, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard pointed out that the Hypervisor access functions don't work
correctly, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg751540.html.
This seris fixes them up by adding a new MMU index for the virtualised
state.

v3:
 - Only set the virtualised MMU mode for HLX ops
v2:
 - Use only 6 MMU modes instead of 8

Alistair Francis (6):
  target/riscv: Add a virtualised MMU Mode
  target/riscv: Set the virtualised MMU mode when doing hyp accesses
  target/riscv: Remove the HS_TWO_STAGE flag
  target/riscv: Remove the hyp load and store functions
  target/riscv: Remove the Hypervisor access check function
  target/riscv: Split the Hypervisor execute load helpers

Yifei Jiang (1):
  target/riscv: Merge m/vsstatus and m/vsstatush into one uint64_t unit

 target/riscv/cpu-param.h                |  10 +-
 target/riscv/cpu.h                      |  43 ++--
 target/riscv/cpu_bits.h                 |  20 +-
 target/riscv/helper.h                   |   5 +-
 target/riscv/cpu.c                      |   8 +-
 target/riscv/cpu_helper.c               |  99 ++++------
 target/riscv/csr.c                      |  18 +-
 target/riscv/op_helper.c                | 135 +------------
 target/riscv/translate.c                |   2 +
 target/riscv/insn_trans/trans_rvh.c.inc | 248 +++++++++++++++---------
 10 files changed, 260 insertions(+), 328 deletions(-)

-- 
2.28.0


