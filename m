Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F7C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2024247AF
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Svg8a8d2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2024247AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmrM-0003Y4-Uj
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpi-0001mM-CX; Wed, 28 Oct 2020 10:53:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpe-00035L-T3; Wed, 28 Oct 2020 10:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603896826; x=1635432826;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gqN1q0ztY/K8RVas54tv6M76H9c7ztlUkarYiaGvMjo=;
 b=Svg8a8d2L6Sa/2qjFgTa+1COmhYpbcan/W2Ptc/w0Em/fdnNtC3ucAwy
 76seA/t7ABL9yIYb5NEqt29+YnpWZ27Ll/LGar+tS3qKVzNk/a0KDRWPe
 nBX3vim7IR0+bhI+bnG1TqoZk0oL1M7S96SLYDRDtVRkvVeSDrgWtaBSD
 PeVJBKQKEGQC44Sal9fv/Ae9xur8Gpq+fAz/a/WL4Seerf33Icna3NhHP
 I0IzY0i/aOQa7W9A96sRBt2FWp4jvNgh+MDNWVqxqyTqlEK+RqM+0i5Xt
 Xfl8zoKj/8U7yEJiu1XYHR3kNzvS4eGB90lt/dqTIbuixKDod8luUIPRT g==;
IronPort-SDR: dpCxKSoAqB4F7oDtlCRpBPiMB5TWrwn7Us0W9O2QRsVacfj6kD0Ldmn00gLUqltbLAPO6AGZXo
 JfFsjVsSmCoJqP55MoLAWE9Y+nvBKjPpM0lH6eghhCOdxYrbaRkfakSC1JBnG0MQgsShTQ9VfK
 TRPwPCsao9GBaxgr5Fq4duQWt3vpKtZpsq/bYdIyqJvP8lqCxTUSdny02gY/fKzprikepSpWyR
 iyp5gk0DJXixUMRlZblyykuuDXiVJIbZT4Q7poxoz1yG2qGfGJxIms0+xOhVofQSfbNu/q+dat
 1Rg=
X-IronPort-AV: E=Sophos;i="5.77,426,1596470400"; d="scan'208";a="151200349"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2020 22:53:42 +0800
IronPort-SDR: 0GDFh3BZkpsvrNTc3Pbvz4uvaQ4yP0PFCJIccg8/BqpBmsSwAllAKWc7iGA/9VNjqaXVwIBGqe
 A/Zt5E9TvwKefy0MToKYhX3zGQ3AGaaV7RfVUdVM7dH2akl3xzBXbBedRQpWGNRn7xMUdgXg6T
 iCG7AeRCkjLKqwDRv7l/7+mweWm0+9ut4piU3IAtO3o3mkdXWoX2mwjV1IatoLzHNpGf4blhoa
 dB0TTuIZSy2C3mU5rWcgc+lxCZZDAhGIs0zZfX1qyqJv0xNoiilz0zo3lvmUb+Y+pkjYBgNVl6
 roeQjp80sHjjWsHk8j47ELeK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 07:38:52 -0700
IronPort-SDR: HVQq0fEz9xzhRh072atpqA3GVNB+QagwK7sUVP2+iD16oHMd4lrk5Z0NYT3VB0lSBehuTViCd6
 jDC8hDi/wQ9eEqeanrR8kbwl2pbHJxy+3uHm+RwrLB7IUh2ewK5o80tDB4b2DhwzB9OfmURQfD
 euJsiV8F2GlPXIodJEtLsARhvqea9P2Vxim/mmOkBFMRIz6s8A8bEFtMI3ANFEZzx0b3dvgUP2
 0V/YAocMHctfD1J0YjM0Ta+EQckLnzy96DzeZ3NMC1NV37/GCh7TRz8Xzvv/A6qRuXz7R+HtHe
 oZ4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Oct 2020 07:53:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 0/5]  Fix the Hypervisor access functions
Date: Wed, 28 Oct 2020 07:42:17 -0700
Message-Id: <cover.1603896075.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=563b96974=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 10:53:43
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

v2:
 - Use only 6 MMU modes instead of 8

Alistair Francis (5):
  target/riscv: Add a virtualised MMU Mode
  target/riscv: Set the virtualised MMU mode when doing hyp accesses
  target/riscv: Remove the HS_TWO_STAGE flag
  target/riscv: Remove the hyp load and store functions
  target/riscv: Split the Hypervisor execute load helpers

 target/riscv/cpu-param.h                |  10 +-
 target/riscv/cpu.h                      |   7 +-
 target/riscv/cpu_bits.h                 |   1 -
 target/riscv/helper.h                   |   6 +-
 target/riscv/cpu_helper.c               |  67 ++++++-------
 target/riscv/op_helper.c                |  90 ++---------------
 target/riscv/insn_trans/trans_rvh.c.inc | 127 +++++++-----------------
 7 files changed, 90 insertions(+), 218 deletions(-)

-- 
2.28.0


