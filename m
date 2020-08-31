Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80F1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C83A2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9jVZzDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C83A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfNC-0006Ub-MX
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFd-0008IG-IC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfFZ-0006av-Mu
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k3IAjuaGUNQDAEJRAT+o7dLmzO0d5cnVS4AqTvfNDAM=;
 b=V9jVZzDqFaBWqrqETxvq6l2Ix/cxgHRBRqiQRKVVCpDj9faKwZ7zJtfIL2dMec0X1jAmCd
 x1+WKdzYGxQ1qt1ie/e2P+KyCoSlvpHfrRqLfMIrmE3RFSYWFhrP+y7UC/1B8oADHbatrH
 cQWeAmvsgGcndx7sXU8k9VogPoPlon4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-WscYzVlDPdK8iGTdCgyi5g-1; Mon, 31 Aug 2020 04:33:09 -0400
X-MC-Unique: WscYzVlDPdK8iGTdCgyi5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3832818A2241
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 08:33:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C30A51002D51;
 Mon, 31 Aug 2020 08:33:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DD86E17447; Mon, 31 Aug 2020 10:33:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Usb 20200831 patches
Date: Mon, 31 Aug 2020 10:32:43 +0200
Message-Id: <20200831083301.6357-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0=
:=0D
=0D
  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pul=
l-=3D=0D
request' into staging (2020-08-28 22:30:11 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/usb-20200831-pull-request=0D
=0D
for you to fetch changes up to b946434f2659a182afc17e155be6791ebfb302eb:=0D
=0D
  usb: fix setup_len init (CVE-2020-14364) (2020-08-31 08:23:39 +0200)=0D
=0D
----------------------------------------------------------------=0D
usb: usb_packet_map fixes for ehci and xhci.=0D
usb: setup_len fix (CVE-2020-14364).=0D
usb: u2f key support (GSoC).=0D
 * v2: 32bit build fixed.=0D
 * v3: libu2f-emu dependency fixed.=0D
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


