Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A52C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5142075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="IZ+VxiOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5142075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEv9I-0005AD-3G
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv54-0002Ni-4h
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv51-00028b-U3
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:09 -0400
Received: from shirlock.uni-paderborn.de ([131.234.189.15]:41526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1iEv4v-00021y-Df
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KQWUji2M5weCzVHupeD+6YWKhFbW4KPX+mZiTxzh3QU=; b=IZ+VxiOkgvcw846kdnwYZPp6gB
 D9NKVb/w/f6zSwTaIuji/kLS1WmK+Uwq82V+3OvOBehEoLcqVqDdaRQfMX2ABDQJXBuMz+wx9jE52
 LphQHp0UUh6pPYc1CTRvSshUodhHfV+4eYk1QtVeV9QtDWIhExebJoJVNqVxe5iACpro=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] TriCore fixes and gdbstub
Date: Mon, 30 Sep 2019 14:46:38 +0200
Message-Id: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.9.30.123917, AntiVirus-Engine: 5.65.0,
 AntiVirus-Data: 2019.9.27.5650000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 131.234.189.15
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
Cc: david.brenken@efs-auto.de
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

Bastian Koppelmann (5):
  target/tricore: Don't save pc in generate_qemu_excp
  target/tricore: Move translate feature check to ctx
  target/tricore: Raise EXCP_DEBUG in gen_goto_tb() for singlestep
  target/tricore: Implement tricore_cpu_get_phys_page_debug
  target/tricore: Implement gdbstub

 target/tricore/Makefile.objs |   2 +-
 target/tricore/cpu.c         |  18 +++--
 target/tricore/cpu.h         |   2 +
 target/tricore/gdbstub.c     | 138 +++++++++++++++++++++++++++++++++++
 target/tricore/helper.c      |  13 ++++
 target/tricore/translate.c   |  79 ++++++++++----------
 6 files changed, 206 insertions(+), 46 deletions(-)
 create mode 100644 target/tricore/gdbstub.c

-- 
2.23.0


