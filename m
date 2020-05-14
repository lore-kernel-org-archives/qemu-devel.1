Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D25C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6743D206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ae9FhKON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6743D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCv2-0003e9-F8
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZCtu-0001an-G1
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:23:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZCts-0003YR-8r
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589459023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OSXx1pd9i8Y5I6NQZ91HoamKGyyeKBTre1yI38H3Uos=;
 b=Ae9FhKON4NqqWWdFiqy/c30yqXsIdqNrc1CItUQOATdmh/uYIyhip/wCKqkO5nGvMPMtsf
 1mVM9dM6CNcX08T/1it/joGnVt/5+YDTIigTkmjVigRRZua/r+LFCJhzlY4pjPy9NIVCRA
 ZE3tpR+d+JRnyaMsRu8ViF3Ob+Tq9Yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-BJNJ-WCyP_ic70yTPueJFw-1; Thu, 14 May 2020 08:23:41 -0400
X-MC-Unique: BJNJ-WCyP_ic70yTPueJFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3127480058A;
 Thu, 14 May 2020 12:23:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4D7E7D928;
 Thu, 14 May 2020 12:23:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9BB1117444; Thu, 14 May 2020 14:23:34 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Usb 20200514 patches
Date: Thu, 14 May 2020 14:23:27 +0200
Message-Id: <20200514122334.25089-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d5c75ec500d96f1d93447f990cd5a4ef5ba27fae:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2020-05-08-1' into staging (2020-05-12 17:00:10 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20200514-pull-request

for you to fetch changes up to 8b2b45c506f4d71b831473d8de93b3cedaea4844:

  raspi2 acceptance test: add test for dwc-hsotg (dwc2) USB host (2020-05-13 11:06:37 +0200)

----------------------------------------------------------------
usb: add dwc2 emulation for raspi machines.

----------------------------------------------------------------

Paul Zimmerman (7):
  raspi: add BCM2835 SOC MPHI emulation
  dwc-hsotg (dwc2) USB host controller register definitions
  dwc-hsotg (dwc2) USB host controller state definitions
  dwc-hsotg (dwc2) USB host controller emulation
  usb: add short-packet handling to usb-storage driver
  wire in the dwc-hsotg (dwc2) USB host controller emulation
  raspi2 acceptance test: add test for dwc-hsotg (dwc2) USB host

 tests/acceptance/boot_linux_console.py |    9 +-
 hw/usb/hcd-dwc2.h                      |  173 +++
 include/hw/arm/bcm2835_peripherals.h   |    5 +-
 include/hw/misc/bcm2835_mphi.h         |   44 +
 include/hw/usb/dwc2-regs.h             |  895 ++++++++++++++++
 hw/arm/bcm2835_peripherals.c           |   38 +-
 hw/misc/bcm2835_mphi.c                 |  184 ++++
 hw/usb/dev-storage.c                   |   15 +-
 hw/usb/hcd-dwc2.c                      | 1372 ++++++++++++++++++++++++
 hw/misc/Makefile.objs                  |    1 +
 hw/usb/Kconfig                         |    5 +
 hw/usb/Makefile.objs                   |    1 +
 hw/usb/trace-events                    |   47 +
 13 files changed, 2784 insertions(+), 5 deletions(-)
 create mode 100644 hw/usb/hcd-dwc2.h
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 include/hw/usb/dwc2-regs.h
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 hw/usb/hcd-dwc2.c

-- 
2.18.4


