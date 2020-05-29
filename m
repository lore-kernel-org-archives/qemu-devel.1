Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF69C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E032072D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E032072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZM9-0003sO-Nw
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jeZLH-0002d6-PC
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:12 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17]:54664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jeZLE-0000cS-DM
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:11 -0400
Received: from tyson.uni-paderborn.de ([131.234.189.26]
 helo=localhost.localdomain)
 by mail.uni-paderborn.de with esmtp (Exim 4.93 zuban)
 id 1jeZL8-0000Ru-M9
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:22:03 +0200
Received: from mail.uni-paderborn.de by tyson with queue id 705590-2
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:22:01 GMT
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] TriCore fixes and gdbstub
Date: Fri, 29 May 2020 09:21:43 +0200
Message-Id: <20200529072148.284037-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.5.29.71219, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.5.29.5740000
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6374305, da=78345986,
 mc=146, sc=3, hc=143, sp=2, fso=6374305, re=0, sd=0, hd=0
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: 
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
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
Cc: kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

this series fixes a few TriCore problems:

- Segfault due to non initialized ctx->env ptr (see
  https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03527.html)
  I fixed this by properly detangling any reference of the env pointer in the
  translate functions. (as suggested by Peter Maydell)

- Unimplemented tricore_cpu_get_phys_page_debug() which lead to a temporary fix
  (see b190f477e29c7cd03a8fee49c96d27f160e3f5b0)

The last patch implements a gdbstub for TriCore.

Cheers,
Bastian

v1 -> v2:
  - Fixed codingstyle problems
  - tricore_cpu_gdb_read_registers uses a GByteArray pointer for the mem_buf
    argument

Bastian Koppelmann (5):
  target/tricore: Don't save pc in generate_qemu_excp
  target/tricore: Move translate feature check to ctx
  target/tricore: Raise EXCP_DEBUG in gen_goto_tb() for singlestep
  target/tricore: Implement tricore_cpu_get_phys_page_debug
  target/tricore: Implement gdbstub

 target/tricore/Makefile.objs |   2 +-
 target/tricore/cpu.c         |  18 +++--
 target/tricore/cpu.h         |   2 +
 target/tricore/gdbstub.c     | 139 +++++++++++++++++++++++++++++++++++
 target/tricore/helper.c      |  13 ++++
 target/tricore/translate.c   |  79 ++++++++++----------
 6 files changed, 207 insertions(+), 46 deletions(-)
 create mode 100644 target/tricore/gdbstub.c

--
2.26.2


