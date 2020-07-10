Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605E7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3D0207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="aBnQcn8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3D0207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt5X-0004FB-Co
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jtsoq-0004Ep-DU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:12:00 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:34033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jtsoo-0001j2-29
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1594386718;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jaVFTTx2HNGKf3JgEbZLbjj1J2bUpC47ifE5uMvXHoA=;
 b=aBnQcn8RRFfPbzFx1XBHnLv2Irhu/2UdeEKoPEy98PrAFW4ezsrGtPEd
 r2mxLkFuT0Vy6Ks7fnFqvtf+yLqGJK+f1pXG5bu/KSPLyTu+TXBRh5Q2E
 fbWSAXoRHvoHhcUfXhT9B+OquSHhdqMXjKTXOZ3vSrw8bcNN5zVVeELZ/ Q=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: Kx/E3xb/iLQiWYXFukk0rCEoznEszOCzONcTv7LJ5UGbxDQ+Ev4/7IbcDUTP+bIzi7/wEt+zLk
 dxNZe0/FZZMJqWHfJBn+u7McrVUA3G3lDufYiy22nGJ7LrSm6/ChmcmxNClRQtbSNxcMP870az
 +XKD9wrO5VhaEA1X4Op/NROAEiLFVPt06dzZ6tJ4YYmd1Wnd0aRTR8uhD0SvaBSh1mMZUTJ0l1
 4Bm0uwOJeAiaz9QmecWPrkqZSrgTsSRzfvd/bw5iK90WFjLXYsL6ujMzOow4yxa95SRVbDC6pd
 YDc=
X-SBRS: 2.7
X-MesageID: 22265261
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,335,1589256000"; d="scan'208";a="22265261"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 0/2] xen queue 2020-07-10
Date: Fri, 10 Jul 2020 14:11:43 +0100
Message-ID: <20200710131145.589476-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.155.168;
 envelope-from=anthony.perard@citrix.com; helo=esa5.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 09:11:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b6d7e9b66f59ca6ebc6e9b830cd5e7bf849d31cf:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-07-10 09:01:28 +0100)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20200710

for you to fetch changes up to dd29b5c30cd2a13f8c12376a8de84cb090c338bf:

  xen: cleanup unrealized flash devices (2020-07-10 13:49:16 +0100)

----------------------------------------------------------------
xen patches

Fixes following harden checks in qdev.

----------------------------------------------------------------
Jason Andryuk (1):
      xen: Fix xen-legacy-backend qdev types

Paul Durrant (1):
      xen: cleanup unrealized flash devices

 hw/i386/pc_piix.c           | 9 ++++++---
 hw/i386/pc_sysfw.c          | 2 +-
 hw/xen/xen-legacy-backend.c | 4 ++--
 include/hw/i386/pc.h        | 1 +
 4 files changed, 10 insertions(+), 6 deletions(-)

