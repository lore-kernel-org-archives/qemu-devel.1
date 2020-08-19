Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125A7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D677C20772
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+e/hEYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D677C20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8H34-0002Rl-4x
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 01:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwO-0007do-3H
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwH-0006h0-Lo
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597816011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d/ToY+CksEUdIJwGBvYGmud0e5v2j522cJh+0DTTbS8=;
 b=g+e/hEYS2jhpJda0N/0NeRG2s7XuluvoSbMDN18xPhoZBP1VdlqvszOMCfgQzYT9Bq7Asf
 Zi/JODt8ycToPWd5n727L2nlw8a0VDKYXoXLRU0LqQi33PzN/7KYi8HAoQZxfOokgZ1u+b
 F9JG2VPYkVXBZ38nP4Pm9rhLVy8CuIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-oRc50urZM-O0t1UQCVr0gg-1; Wed, 19 Aug 2020 01:46:49 -0400
X-MC-Unique: oRc50urZM-O0t1UQCVr0gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 399BF1DDF7
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 05:46:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CC86100AE55;
 Wed, 19 Aug 2020 05:46:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4F6239D8F; Wed, 19 Aug 2020 07:46:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Usb 20200819 patches
Date: Wed, 19 Aug 2020 07:46:27 +0200
Message-Id: <20200819054644.30610-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:28:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:

  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20200819-pull-request

for you to fetch changes up to d7e5b2e1a4035fb81517a2034bb955e58f28d5b9:

  hw/usb: Add U2F device autoscan to passthru mode (2020-08-19 07:35:27 +0200)

----------------------------------------------------------------
usb: usb_packet_map error handling for xhci/ehci
usb: add U2F devices (GSoC).

----------------------------------------------------------------

César Belley (13):
  hw/usb: Regroup USB HID protocol values
  docs: Add USB U2F key device documentation
  hw/usb: Add U2F key base class
  hw/usb: Add U2F key base class implementation
  hw/usb: Add U2F key passthru mode
  hw/usb: Add U2F key emulated mode
  hw/usb: Add U2F key build recipe
  configure: Add USB U2F key device
  docs/system: Add U2F key to the USB devices examples
  docs/qdev-device-use.txt: Add USB U2F key to the QDEV devices examples
  scripts: Add u2f-setup-gen script
  hw/usb: Add U2F device check to passthru mode
  hw/usb: Add U2F device autoscan to passthru mode

Gerd Hoffmann (1):
  ehci: drop pointless warn_report for guest bugs.

Li Qiang (3):
  hw: xhci: check return value of 'usb_packet_map'
  hw: ehci: destroy sglist in error path
  hw: ehci: check return value of 'usb_packet_map'

 configure                |  27 ++
 docs/qdev-device-use.txt |   1 +
 docs/u2f.txt             | 110 ++++++++
 scripts/u2f-setup-gen.py | 170 ++++++++++++
 hw/usb/u2f.h             |  92 +++++++
 include/hw/usb/hid.h     |  17 ++
 hw/usb/dev-hid.c         |  26 +-
 hw/usb/dev-wacom.c       |  12 +-
 hw/usb/hcd-ehci.c        |  12 +-
 hw/usb/hcd-xhci.c        |   5 +-
 hw/usb/u2f-emulated.c    | 405 ++++++++++++++++++++++++++++
 hw/usb/u2f-passthru.c    | 551 +++++++++++++++++++++++++++++++++++++++
 hw/usb/u2f.c             | 352 +++++++++++++++++++++++++
 docs/system/usb.rst      |   3 +
 hw/usb/Kconfig           |   5 +
 hw/usb/Makefile.objs     |   9 +
 16 files changed, 1765 insertions(+), 32 deletions(-)
 create mode 100644 docs/u2f.txt
 create mode 100755 scripts/u2f-setup-gen.py
 create mode 100644 hw/usb/u2f.h
 create mode 100644 include/hw/usb/hid.h
 create mode 100644 hw/usb/u2f-emulated.c
 create mode 100644 hw/usb/u2f-passthru.c
 create mode 100644 hw/usb/u2f.c

-- 
2.18.4


