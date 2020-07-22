Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8C8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2013207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eiYq8Ugf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2013207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI5d-0007ND-T6
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4f-0005pb-E3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4a-0002fu-7V
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595437108; x=1626973108;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oEaFn4RHdtpjxjDlM/jVm2p+mJnY0NHM0/IFLrhx1Us=;
 b=eiYq8UgfoGhhag/UD+11y5kKiOPwqv4qOtcbrj174iir1HZyid3ONHg7
 vP2GOf47yNupaR4AVHUe89wjkwXjFMQnWQsolL+yR4AJduwlpY7LFZyQE
 ydXXJskVmMG5z5utkVqcjhAV1jyqqBGZEYdsRYf2RH2P0czNJveVt/En4
 mneU+oGxJOssY/0apK3l0AewSxO0cBFMW+zajKJltqtVVaPr+ks+uSP6h
 xuRoN5Wnma8duAr261cveZYaabPtvyZ9ehXGeZwKE+IIpgbwVdBftUa1Y
 C1dh9ztzKLwJAtW18YlotBPrFIdWct6WYWTgXqYiCv1Q17kv+QzBbK64C g==;
IronPort-SDR: wmG3vS5cTRcARL2RIzkFzWEks9Pv94d6tMNJushQk26tF0hBEWQYLrE4lRP2awQthzAHfVNgLj
 L9ShTl+ZyuerY2tp94jxQR0jx1UpTjq/0LTVmaE9Oq30xYK8sc+PvRmjfiL4w9nSAkgrOIb0wi
 p4glhls/LsigBSd4Fs0DlcKBM2XRryRR8/rEV51CtADsgips4iif63bNWg+ZJRXA+tHYl6eXiL
 fyPxwsW54amRKrbXPmh7rbY/y6Wkj7JRPfwaiNIacgIPnS6e4qpiBDF7Sk/aHLztBUoK+qMpop
 oqg=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; d="scan'208";a="252418632"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2020 00:58:21 +0800
IronPort-SDR: J3cmYUinu41HUHdxhTYaQdCmP4PnG9ZCsrxtMejzX1jDkyk+BoAdi+BUeN0oeL8K0dN/n4Xu5G
 PskQXmOyUNzSgExBX3beBj9CJCxX7PXuU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 09:46:37 -0700
IronPort-SDR: ezqWPJXveeijhGJKbzj0uITu5v0bvLD4yxDaIAw2rLitFvCY9ppEkWkEcEpEAFQLWb1w9JrRvi
 PftX7a5hJDng==
WDCIronportException: Internal
Received: from usa001575.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.115])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Jul 2020 09:58:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] riscv-to-apply queue
Date: Wed, 22 Jul 2020 09:48:33 -0700
Message-Id: <20200722164838.1591305-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=465c3c755=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 12:58:21
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3cbc8970f55c87cb58699b6dc8fe42998bc79dc0:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-07-21' into staging (2020-07-22 09:13:46 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200722-1

for you to fetch changes up to 8ba26b0b2b00dd5849a6c0981e358dc7a7cc315d:

  target/riscv: Fix the range of pmpcfg of CSR funcion table (2020-07-22 09:41:36 -0700)

----------------------------------------------------------------
This PR contains a few RISC-V fixes.

The main fix is the correction of the goldfish RTC time. On top of that
some small fixes to the recently added vector extensions have been added
(including an assert that fixed a coverity report). There is a change in
the SiFive E debug memory size to match hardware. Finally there is a fix
for PMP accesses.

----------------------------------------------------------------
Bin Meng (1):
      hw/riscv: sifive_e: Correct debug block size

Jessica Clarke (1):
      goldfish_rtc: Fix non-atomic read behaviour of TIME_LOW/TIME_HIGH

LIU Zhiwei (2):
      target/riscv: Quiet Coverity complains about vamo*
      target/riscv: fix vector index load/store constraints

Zong Li (1):
      target/riscv: Fix the range of pmpcfg of CSR funcion table

 include/hw/rtc/goldfish_rtc.h           |  1 +
 hw/riscv/sifive_e.c                     |  2 +-
 hw/rtc/goldfish_rtc.c                   | 17 ++++++++++++++---
 target/riscv/csr.c                      |  2 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 11 ++++++++++-
 5 files changed, 27 insertions(+), 6 deletions(-)

