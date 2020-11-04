Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A5CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C77D208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SsnStMy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C77D208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAvu-0005rr-C5
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaAp2-00041L-Ob; Tue, 03 Nov 2020 23:55:00 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaAow-0005i4-RZ; Tue, 03 Nov 2020 23:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604465694; x=1636001694;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ep2GJLYUBqDTkqBDYjaRnUPXdh+Um5MrS3McpIDE6P8=;
 b=SsnStMy50pX0zVR/PaCL6md/42CkdOTy+Ek5aCAnSXG7qMrYDAEXYLP3
 Xc+taQ90zV4D4v8wIJ2FWs6SSvGjP4cZGtqoT0DHJQ9axq1vO/fq3OFgf
 B1VLSu4M5YcwIDi3Ey2odW2CJrDOujFUdfOt9hmG4ywaTTFNR+EoyL2tu
 fXlePTVYDG8s8iCAgxwTEa838SV2lR9S7DUKkTbut9XpXM+zKVEjonGsS
 luIEL+4u9tqdxnnmizw+gbGuDOHfkXs1AZOLHKZlNUrfcXJZeaPHRuYDT
 LtD5vYugWLf2XXGVedggX48RWq1tTDNi3dis3n+JkAP9o3M7yK0gfMd2i g==;
IronPort-SDR: iC4b7TbDvPKDhqo1hIZ1k6d7PII74mVorujJJC8VhQLcQul4sa7hyt/smBB0tbFUB5gdV+wLQ/
 4l8gSz9ZSm++NiR/EybNlrYri7XNpAcaGQRQ2naXq8cel01e/aTd6C4296MAMdt1t2ZLexBFQs
 5dYgamDtcQXab29UWecIlcCwTmZpw4BXV1RBRPnreEiUCDMwO//G69m9vJfjKLY3zARZePRHnd
 4ghFaMJXYjTK0hs91/8m9NSbBEK/ou8PO0mjR2aHjJlGAhiPU1TdTzqiOvrbqHLjdYlY/i5bOB
 Xgg=
X-IronPort-AV: E=Sophos;i="5.77,449,1596470400"; d="scan'208";a="151656924"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 12:54:51 +0800
IronPort-SDR: fYK+FbiMtAc1FhOMX52PEVY/N7duKarnitX7Ds1mrwWEJoZRocjFko98fweQL1E+szDgNfKFfD
 cnYADYB+asHYJTI7+VezuigwhnYZV3u5JByTIErz/thIC5pRqbhtNVjkNdCtbjbJVviojgm3lb
 tiG6wnn+bAcLEOy8vkLqxjYy7vBGgSgjOKbVPKNYH+IiHSeIgDjDfm9HUGDEdn4JFn/f5uNRos
 nyGLFN2gpcgRlba3YgFz+09LKJfb7raVY02YvOM9TWVmft/Lc8OdEYPvU1MoiS5Ywbmg5qg20c
 3PxrI1l1Xiu/3zt+onTIt7FJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 20:41:00 -0800
IronPort-SDR: Xgtj4n4cUNI+uiEcag2hlBaiju2sHiMCx10/2Hpu2aFN/jeTtcOspuOjK0LeL+3vz/kgMEISqz
 81gITj+jncZm37zz5vGq2BQt6hyImdk3BQV6JyflrOzsMLQAx4meKQ4Rs8o3xjb0iy8LMpP8Ps
 pVdyNxSTENcdmwWeHi5iTWvvMHJs9WyjjEeDsEkSHIgpXI4aeXyCFeOc6ug5iXTGEEJCnRbwBb
 wtIYWW/ybJHD1fb5g93MnzrmBAuDiF31bsq/brGZeI5HBDwhgDWJcp35SOhsNmTCEM8ferv1uX
 At8=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 20:54:51 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 0/5]  Fix the Hypervisor access functions
Date: Tue,  3 Nov 2020 20:43:20 -0800
Message-Id: <cover.1604464950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=57073d1dd=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 23:54:51
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
v4:
 - Consolidate the inline helper to a helper function
 - Actually don't have a virtualised MMU index
v3:
 - Don't use an external helper
v2:
 - Use only 6 MMU modes instead of 8

Alistair Francis (5):
  target/riscv: Add a virtualised MMU Mode
  target/riscv: Set the virtualised MMU mode when doing hyp accesses
  target/riscv: Remove the HS_TWO_STAGE flag
  target/riscv: Remove the hyp load and store functions
  target/riscv: Split the Hypervisor execute load helpers

 target/riscv/cpu-param.h                |  11 +-
 target/riscv/cpu.h                      |  19 +++-
 target/riscv/cpu_bits.h                 |   1 -
 target/riscv/helper.h                   |   5 +-
 target/riscv/cpu_helper.c               |  62 +++++-----
 target/riscv/op_helper.c                | 124 +-------------------
 target/riscv/translate.c                |   2 +
 target/riscv/insn_trans/trans_rvh.c.inc | 143 +++++++++---------------
 8 files changed, 112 insertions(+), 255 deletions(-)

-- 
2.28.0


