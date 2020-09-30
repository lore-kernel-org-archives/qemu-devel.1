Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2249FC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF1A2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF1A2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYqw-0001Z0-Rx
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYo5-0006ZB-Iw; Wed, 30 Sep 2020 05:53:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5158 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYo3-0004LP-1C; Wed, 30 Sep 2020 05:53:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9368EF14EF356E603DFF;
 Wed, 30 Sep 2020 17:53:41 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:53:34 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 00/14] fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:07 +0800
Message-ID: <20200930095321.2006-1-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.174.185.186]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target/=
.=0D
I used spellcheck to check the spelling errors and found some errors in the=
 folder.=0D
=0D
The checkpatch.pl file in the Linux kernel can check spelling errors in pat=
ches.=0D
I'm trying to add this function to the checkpatch.pl in qemu,=0D
so that no similar spelling errors will occur in the feture.=0D
It's not done yet and I will commit the patch when it's done.=0D
=0D
Signed-off-by: zhaolichang <zhaolichang@huawei.com>

zhaolichang (14):
  cris/: fix some comment spelling errors
  ppc/: fix some comment spelling errors
  riscv/: fix some comment spelling errors
  rx/: fix some comment spelling errors
  tricore/: fix some comment spelling errors
  mips/: fix some comment spelling errors
  s390x/: fix some comment spelling errors
  m68k/: fix some comment spelling errors
  sh4/: fix some comment spelling errors
  i386/: fix some comment spelling errors
  avr/: fix some comment spelling errors
  arm/: fix some comment spelling errors
  alpha/: fix some comment spelling errors
  target/: fix some comment spelling errors

 target/alpha/cpu.h               |  4 ++--
 target/alpha/translate.c         |  2 +-
 target/arm/cpu.h                 |  2 +-
 target/arm/helper.c              |  4 ++--
 target/arm/m_helper.c            |  2 +-
 target/arm/translate-a64.c       |  4 ++--
 target/arm/translate-sve.c       |  2 +-
 target/avr/helper.c              |  6 +++---
 target/cris/helper.c             |  6 +++---
 target/cris/op_helper.c          |  2 +-
 target/cris/translate.c          | 14 +++++++-------
 target/i386/cpu.c                |  4 ++--
 target/i386/hax-interface.h      |  4 ++--
 target/i386/hax-windows.c        |  2 +-
 target/i386/kvm.c                |  2 +-
 target/i386/machine.c            |  6 +++---
 target/i386/translate.c          |  8 ++++----
 target/i386/whpx-all.c           |  2 +-
 target/m68k/translate.c          | 16 ++++++++--------
 target/mips/internal.h           |  2 +-
 target/mips/translate.c          | 10 +++++-----
 target/mips/translate_init.c.inc |  2 +-
 target/openrisc/cpu.h            |  2 +-
 target/ppc/cpu.h                 |  6 +++---
 target/ppc/excp_helper.c         |  6 +++---
 target/ppc/fpu_helper.c          |  2 +-
 target/ppc/internal.h            |  2 +-
 target/ppc/kvm.c                 |  2 +-
 target/ppc/machine.c             |  2 +-
 target/ppc/mmu-hash64.c          |  2 +-
 target/ppc/mmu_helper.c          |  4 ++--
 target/ppc/translate_init.c.inc  |  2 +-
 target/riscv/cpu.c               |  2 +-
 target/riscv/cpu_bits.h          |  2 +-
 target/riscv/csr.c               |  6 +++---
 target/riscv/vector_helper.c     |  2 +-
 target/rx/op_helper.c            |  2 +-
 target/rx/translate.c            |  2 +-
 target/s390x/cpu_models.h        |  4 ++--
 target/s390x/excp_helper.c       |  2 +-
 target/s390x/fpu_helper.c        |  2 +-
 target/s390x/insn-data.def       |  2 +-
 target/s390x/ioinst.c            |  2 +-
 target/s390x/misc_helper.c       |  2 +-
 target/s390x/translate.c         |  4 ++--
 target/s390x/translate_vx.c.inc  |  2 +-
 target/sh4/cpu.h                 |  2 +-
 target/sh4/op_helper.c           |  2 +-
 target/sh4/translate.c           |  2 +-
 target/sparc/asi.h               |  2 +-
 target/tricore/csfr.def          |  2 +-
 target/tricore/translate.c       |  2 +-
 target/unicore32/translate.c     |  2 +-
 53 files changed, 93 insertions(+), 93 deletions(-)

--=20
2.26.2.windows.1


