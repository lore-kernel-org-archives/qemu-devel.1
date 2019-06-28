Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5289C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A48920656
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A48920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgoMr-0007KR-RQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hgoIp-0002Jt-Ih
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hgoIo-00068g-3a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:40:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hgoIi-00061W-S0; Fri, 28 Jun 2019 06:40:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE2B7308FED2;
 Fri, 28 Jun 2019 10:40:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com
 [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10CE019C4F;
 Fri, 28 Jun 2019 10:39:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E478011AA3; Fri, 28 Jun 2019 12:39:57 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 12:39:51 +0200
Message-Id: <20190628103957.9504-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 10:40:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/6] Vga 20190628 patches
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeac=
de:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-=
2019' into staging (2019-06-21 15:40:50 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20190628-pull-request

for you to fetch changes up to 263807f4e85e94f2d4e988d61d2fc0319b1dd36b:

  ati-vga: switch to vgabios-ati.bin (2019-06-28 10:49:36 +0200)

----------------------------------------------------------------
vga: ati fixes, add ati vgabios.

----------------------------------------------------------------

BALATON Zoltan (3):
  i2c: Move bitbang_i2c.h to include/hw/i2c/
  ati-vga: Implement DDC and EDID info from monitor
  ati-vga: Fixes to offset and pitch registers

Gerd Hoffmann (3):
  seabios: add config for ati vgabios
  seabios: add ati vgabios binary
  ati-vga: switch to vgabios-ati.bin

 hw/display/ati_int.h                 |   6 ++
 hw/display/ati_regs.h                |   6 +-
 {hw =3D> include/hw}/i2c/bitbang_i2c.h |   2 +
 include/hw/i2c/i2c.h                 |   2 -
 include/hw/i2c/ppc4xx_i2c.h          |   2 +-
 hw/display/ati.c                     |  99 +++++++++++++++++++++++----
 hw/display/ati_2d.c                  |  26 ++++---
 hw/display/ati_dbg.c                 |   2 +
 hw/i2c/bitbang_i2c.c                 |   2 +-
 hw/i2c/ppc4xx_i2c.c                  |   1 -
 hw/i2c/versatile_i2c.c               |   2 +-
 hw/display/Kconfig                   |   2 +
 pc-bios/vgabios-ati.bin              | Bin 0 -> 38912 bytes
 roms/config.vga-ati                  |   4 ++
 14 files changed, 127 insertions(+), 29 deletions(-)
 rename {hw =3D> include/hw}/i2c/bitbang_i2c.h (80%)
 create mode 100644 pc-bios/vgabios-ati.bin
 create mode 100644 roms/config.vga-ati

--=20
2.18.1


