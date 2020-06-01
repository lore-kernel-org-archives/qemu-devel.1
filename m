Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254EBC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E858A2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="gn5NpdNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E858A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfm7l-0000qP-6G
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jfm6Z-0007vj-0n
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 11:11:59 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18]:42074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jfm6X-0004e1-Io
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 11:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gY+o9cHB0gvGgjGcHAjZ952VtjKigAwDnma5OxIhsdc=; b=gn5NpdNPIcy4t1YExoCpeScPC6
 w6wvOPolDpciDkZtLdEMr2QiSm5r/IbcrniJJWEMA4ycvBvLiyKABV97o65vnwntFi4F+6XVXIcsa
 uYleMBm3QSvW3uAcZ+jR96q4VSBloMTD61NXDpzGkJTApjz2pjGOjugWKZsgSYM+Nbrg=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] tricore queue
Date: Mon,  1 Jun 2020 17:11:14 +0200
Message-Id: <20200601151119.33196-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.1.150616, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.1.5740002
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6661694, da=78633375,
 mc=163, sc=3, hc=160, sp=1, fso=6661694, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7ea32024c6b3ad9c88d6200e73dbf76c8e160024:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-june-01-2020' into staging (2020-06-01 13:43:59 +0100)

are available in the Git repository at:

  https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20200601

for you to fetch changes up to d127de3baa64d1cabc8e1994e658688abb577ba9:

  target/tricore: Implement gdbstub (2020-06-01 16:55:13 +0200)

----------------------------------------------------------------
Remove ctx->env ptr, add TriCore gdb stub

----------------------------------------------------------------
Bastian Koppelmann (5):
      target/tricore: Don't save pc in generate_qemu_excp
      target/tricore: Move translate feature check to ctx
      target/tricore: Raise EXCP_DEBUG in gen_goto_tb() for singlestep
      target/tricore: Implement tricore_cpu_get_phys_page_debug
      target/tricore: Implement gdbstub

 target/tricore/Makefile.objs |   2 +-
 target/tricore/cpu.c         |  18 +++---
 target/tricore/cpu.h         |   2 +
 target/tricore/gdbstub.c     | 139 +++++++++++++++++++++++++++++++++++++++++++
 target/tricore/helper.c      |  13 ++++
 target/tricore/translate.c   |  79 ++++++++++++------------
 6 files changed, 207 insertions(+), 46 deletions(-)
 create mode 100644 target/tricore/gdbstub.c

