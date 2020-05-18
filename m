Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F543207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhgwGa7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F543207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahX3-00070C-Az
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS6-0008Cx-Rn
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS2-0005xR-Jp
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589814789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=246y12I/y/V9fq4L+8F5aEP2hcwAYyxONoIADS74hnA=;
 b=UhgwGa7hyNKrHvOR0uLLaOkIJ99vzjJLDameD6O7QJQ/QimuU0RXT/mJyFkjUdP5Yx0qPC
 oFvyRUIHkUmEJoiWZmHUuGQUNyAxGvbb4S5JbBXjP0asExCwlKBfOzrvKlKZPXrvsEEqXW
 c+sYsJS8NxwmE6AW3COE0jgXgZevuLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-0QID5U24NJSQCZ-qtLR45Q-1; Mon, 18 May 2020 11:13:06 -0400
X-MC-Unique: 0QID5U24NJSQCZ-qtLR45Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00C951853B06;
 Mon, 18 May 2020 15:13:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A850C649A9;
 Mon, 18 May 2020 15:12:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7B44E17444; Mon, 18 May 2020 17:12:55 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Vga 20200518 patches
Date: Mon, 18 May 2020 17:12:47 +0200
Message-Id: <20200518151255.10785-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9=
:

  Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into st=
aging (2020-05-15 19:51:16 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20200518-pull-request

for you to fetch changes up to 3fcf15df0073a76d37e2816597771d4c9763e413:

  ramfb: fix size calculation (2020-05-18 15:43:51 +0200)

----------------------------------------------------------------
vga: ati-vga bugfix, ramfb cleanups and fixes.

----------------------------------------------------------------

BALATON Zoltan (1):
  ati-vga: Do not allow unaligned access via index register

Gerd Hoffmann (6):
  Revert "hw/display/ramfb: initialize fw-config space with xres/ yres"
  Revert "hw/display/ramfb: lock guest resolution after it's set"
  ramfb: drop leftover debug message
  ramfb: don't update RAMFBState on errors
  ramfb: add sanity checks to ramfb_create_display_surface
  ramfb: fix size calculation

Philippe Mathieu-Daud=C3=A9 (1):
  hw/display: Include local 'framebuffer.h'

 include/hw/display/ramfb.h    |  2 +-
 hw/display/artist.c           |  2 +-
 hw/display/ati.c              |  2 +-
 hw/display/next-fb.c          |  2 +-
 hw/display/ramfb-standalone.c | 12 +-----
 hw/display/ramfb.c            | 77 +++++++++++++----------------------
 hw/vfio/display.c             |  4 +-
 stubs/ramfb.c                 |  2 +-
 8 files changed, 37 insertions(+), 66 deletions(-)

--=20
2.18.4


