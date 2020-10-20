Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA43322253
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Pt7mWluc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA43322253
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoWk-0003Es-LV
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTs-0007yu-BW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:00 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:33142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTo-0007Dl-FO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1603188177;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HqzHjbcE4v6gSsnNFoVkG9PPDyuNaXckQc+zXP+c8vc=;
 b=Pt7mWluctBam1gaeR0OaWKOXquo5WwUTI9hJCaRDPyBxHyTuMS1a1Do6
 LKXoeWDIIVTL6zJQh8XP0BI2lQEssvP+AgY9qE4cX6dMPsWUqG9+ZILu6
 5iuQqM3KgujrrINLG3a/czxvk94w+nzJLhN0lDXEmLf5mDkmKnW3x1NsP A=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 3eNC/2qhjT9EB4My9jm/kQVaEgKDyVRt5WxkVhMtGBoG3bd/Gvg7HwtG3dk2p2LLpRXniAf4zq
 /Wm0+/KuyRI2sYNcgTaOez9UnciuCTVLF0S0IS2xBIN4x9eMk23L/2sMWkNhCvEGCU7hr+QFu/
 d+rdYCQcVpRWstq/8h1CZiZS62/4GbNS1t16g8bDN5x5jnVbRZSLCqzm/xWHrlYRfhEM9GO77t
 GPrRCzuK/hoqoNUfJsqzSf4BCQ6CWlNJNi0l8BZ1O98kHwj29uXHTn4uviNA7maF70yGYzv607
 ImE=
X-SBRS: None
X-MesageID: 29346550
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,396,1596513600"; d="scan'208";a="29346550"
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 0/4] xen queue 2020-10-20
Date: Tue, 20 Oct 2020 11:02:35 +0100
Message-ID: <20201020100239.272748-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=anthony.perard@citrix.com; helo=esa3.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:02:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

The following changes since commit d76f4f97eb2772bf85fe286097183d0c7db19ae8:

  Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20201019' into staging (2020-10-19 14:39:27 +0100)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20201020

for you to fetch changes up to 8959e0a63a3a681a31ff8397d9345a88e6d905bf:

  hw/xen: Set suppress-vmdesc for Xen machines (2020-10-19 16:33:28 +0100)

----------------------------------------------------------------
Xen queue

* cleanup patches.
* improve xen backend setup performance when other xen guests are
  running/booting.
* improve xen guest migration when running in a stubdomain.

----------------------------------------------------------------
Eduardo Habkost (1):
      xen: Rename XENBACKEND_DEVICE to XENBACKEND

Jason Andryuk (1):
      hw/xen: Set suppress-vmdesc for Xen machines

Michael Tokarev (1):
      xen: xenguest is not used so is not needed

Paul Durrant (1):
      xen-bus: reduce scope of backend watch

 configure                           |  4 ++--
 hw/i386/pc_piix.c                   |  4 ++--
 hw/i386/xen/xen_platform.c          |  2 --
 hw/xen/xen-backend.c                | 11 ++++++++++
 hw/xen/xen-bus.c                    | 40 +++++++++++++++++++++++++++++--------
 include/hw/xen/xen-backend.h        |  1 +
 include/hw/xen/xen-bus.h            |  3 ++-
 include/hw/xen/xen-legacy-backend.h |  2 +-
 8 files changed, 51 insertions(+), 16 deletions(-)

