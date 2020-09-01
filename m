Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73BEC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F17E2087D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="cttSK9z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F17E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD35X-0006vR-Iw
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1kD34j-0005Tb-Dw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:59:37 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17]:43850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1kD34g-0004TH-UL
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5gnwpQDv6M2wc8zxmn5D4c3hZj38M6L+N46bUURJgUc=; b=cttSK9z5k7IUo8zKR68HrVotlB
 G2iRaaU8Unw3XBGI3KqXjORLHR6NllSIQnOOZdrR5a2dFwOuvJOtIq3SW1jz2sC9MMRGDutjvmMO4
 IamaDCXqAek4i1PGFvTbFz9C5n5BzVbtvonmxaxgryRBytm1xYlvvZMcuRoqShVfF1V0=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] tricore queue
Date: Tue,  1 Sep 2020 11:59:23 +0200
Message-Id: <20200901095924.21738-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.9.1.95118, AntiVirus-Engine: 5.77.0,
 AntiVirus-Data: 2020.9.1.5770001
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=14591752, da=86563433,
 mc=291, sc=3, hc=288, sp=1, fso=14591752, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)

are available in the Git repository at:

  https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20200901

for you to fetch changes up to 2c15af48abb71b3cddadd63c5bb416b250f53fef:

  tricore: added triboard with tc27x_soc (2020-09-01 11:54:11 +0200)

----------------------------------------------------------------
Add the Infineon Aurix D-Step board

----------------------------------------------------------------
Andreas Konopik (1):
      tricore: added triboard with tc27x_soc

 hw/tricore/Kconfig             |   8 ++
 hw/tricore/meson.build         |   2 +
 hw/tricore/tc27x_soc.c         | 246 +++++++++++++++++++++++++++++++++++++++++
 hw/tricore/triboard.c          | 102 +++++++++++++++++
 include/hw/tricore/tc27x_soc.h | 139 +++++++++++++++++++++++
 include/hw/tricore/triboard.h  |  53 +++++++++
 6 files changed, 550 insertions(+)
 create mode 100644 hw/tricore/tc27x_soc.c
 create mode 100644 hw/tricore/triboard.c
 create mode 100644 include/hw/tricore/tc27x_soc.h
 create mode 100644 include/hw/tricore/triboard.h

