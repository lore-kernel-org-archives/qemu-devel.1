Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE789C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C5320870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C5320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0i86-0000JD-Et
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0i5l-0007LH-AR
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0i5k-0005oK-1Z
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0i5j-0005nY-Mh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFFEC10C6968
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 08:05:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D56005D9E5;
 Thu, 22 Aug 2019 08:05:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0609211AAF; Thu, 22 Aug 2019 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:04:54 +0200
Message-Id: <20190822080503.12063-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 22 Aug 2019 08:05:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] Vga 20190822 patches
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 17dc57990320edaad52ac9ea808be9719c91ce=
a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-08-20' into staging (2019-08-20 14:14:20 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20190822-pull-request

for you to fetch changes up to b7105d280cab053465de79ff1766d2f7e1ea7554:

  ati-vga: Implement dummy VBlank IRQ (2019-08-22 10:04:20 +0200)

----------------------------------------------------------------
vga: a collection of ati fixes/improvements.

----------------------------------------------------------------

BALATON Zoltan (8):
  ati-vga: Add registers for getting apertures
  ati-vga: Add some register definitions for debugging
  ati-vga: Fix GPIO_MONID register write
  ati-vga: Fix cursor color with guest_hwcursor=3Dtrue
  ati-vga: Fix hardware cursor image offset
  ati-vga: Attempt to handle CRTC offset not exact multiple of stride
  ati-vga: Add limited support for big endian frame buffer aperture
  ati-vga: Implement dummy VBlank IRQ

 hw/display/ati_int.h  |   5 ++
 hw/display/ati_regs.h |  17 +++++++
 hw/display/ati.c      | 112 +++++++++++++++++++++++++++++++++++-------
 hw/display/ati_dbg.c  |  10 ++++
 4 files changed, 126 insertions(+), 18 deletions(-)

--=20
2.18.1


