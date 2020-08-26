Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9D9C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF64214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd9yjaA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF64214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwr7-0005dL-9a
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAwnD-0006eN-VH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:52:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAwnC-0008Kl-6S
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598453569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p+IkZVWUHs7gowXXFjoHzKd2vKzCZ/P3uiHdOw0K5Uk=;
 b=Bd9yjaA6dbwAtRgby8z07BQ1jgodZho0t70CAXuTTRUAiT1fafaY9TH8zLz7E7nwz9e4Se
 8ioUmyk4u/UFpx1mq7nl8aDHf+gL0AFHGAPnBoDGyQL3Rr7qSIc9E2GTZW+yz+Sryz6OMF
 RDMMD24uRVsXl3j64KduBWd2hUw85eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-2CworU3kP3CRdeQwqCsFsA-1; Wed, 26 Aug 2020 10:52:45 -0400
X-MC-Unique: 2CworU3kP3CRdeQwqCsFsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35BA810074B1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 14:52:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C768D7A41C;
 Wed, 26 Aug 2020 14:52:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A0AAF9D78; Wed, 26 Aug 2020 16:52:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Usb 20200826 patches
Date: Wed, 26 Aug 2020 16:52:21 +0200
Message-Id: <20200826145239.6077-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d1a2b51f868d09ca8489ee9aee9c55632ed8fb92=
:=0D
=0D
  Merge remote-tracking branch 'remotes/berrange/tags/socket-next-pull-requ=
es=3D=0D
t' into staging (2020-08-25 15:01:43 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/usb-20200826-pull-request=0D
=0D
for you to fetch changes up to 0cb60cbaf4831d859134eea39ae99ae23db79d9d:=0D
=0D
  usb: fix setup_len init (CVE-2020-14364) (2020-08-26 14:42:00 +0200)=0D
=0D
----------------------------------------------------------------=0D
usb: usb_packet_map fixes for ehci and xhci.=0D
usb: u2f key support (GSoC).=0D
usb: setup_len fix (CVE-2020-14364).=0D
=0D
----------------------------------------------------------------=0D
=0D
C=3DC3=3DA9sar Belley (12):=0D
  hw/usb: Regroup USB HID protocol values=0D
  docs: Add USB U2F key device documentation=0D
  hw/usb: Add U2F key base class=0D
  hw/usb: Add U2F key base class implementation=0D
  hw/usb: Add U2F key passthru mode=0D
  hw/usb: Add U2F key emulated mode=0D
  meson: Add U2F key to meson=0D
  docs/system: Add U2F key to the USB devices examples=0D
  docs/qdev-device-use.txt: Add USB U2F key to the QDEV devices examples=0D
  scripts: Add u2f-setup-gen script=0D
  hw/usb: Add U2F device check to passthru mode=0D
  hw/usb: Add U2F device autoscan to passthru mode=0D
=0D
Gerd Hoffmann (3):=0D
  ehci: drop pointless warn_report for guest bugs.=0D
  usb-host: workaround libusb bug=0D
  usb: fix setup_len init (CVE-2020-14364)=0D
=0D
Li Qiang (3):=0D
  hw: xhci: check return value of 'usb_packet_map'=0D
  hw: ehci: destroy sglist in error path=0D
  hw: ehci: check return value of 'usb_packet_map'=0D
=0D
 configure                |   8 +-=0D
 docs/qdev-device-use.txt |   1 +=0D
 docs/u2f.txt             | 110 ++++++++=0D
 meson_options.txt        |   1 +=0D
 scripts/u2f-setup-gen.py | 170 ++++++++++++=0D
 hw/usb/u2f.h             |  92 +++++++=0D
 include/hw/usb/hid.h     |  17 ++=0D
 hw/usb/core.c            |  16 +-=0D
 hw/usb/dev-hid.c         |  26 +-=0D
 hw/usb/dev-wacom.c       |  12 +-=0D
 hw/usb/hcd-ehci.c        |  12 +-=0D
 hw/usb/hcd-xhci.c        |   5 +-=0D
 hw/usb/host-libusb.c     |  37 ++-=0D
 hw/usb/u2f-emulated.c    | 405 ++++++++++++++++++++++++++++=0D
 hw/usb/u2f-passthru.c    | 551 +++++++++++++++++++++++++++++++++++++++=0D
 hw/usb/u2f.c             | 352 +++++++++++++++++++++++++=0D
 docs/system/usb.rst      |   3 +=0D
 hw/usb/Kconfig           |   5 +=0D
 hw/usb/meson.build       |   7 +=0D
 meson.build              |   7 +=0D
 20 files changed, 1797 insertions(+), 40 deletions(-)=0D
 create mode 100644 docs/u2f.txt=0D
 create mode 100755 scripts/u2f-setup-gen.py=0D
 create mode 100644 hw/usb/u2f.h=0D
 create mode 100644 include/hw/usb/hid.h=0D
 create mode 100644 hw/usb/u2f-emulated.c=0D
 create mode 100644 hw/usb/u2f-passthru.c=0D
 create mode 100644 hw/usb/u2f.c=0D
=0D
--=3D20=0D
2.27.0=0D
=0D


