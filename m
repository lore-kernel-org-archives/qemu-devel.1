Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB4C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669D52085A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669D52085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6YG-0001xb-NT
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:54:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM6GO-0002BM-V3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM6GN-00015m-6H
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hM6GL-0000gw-3D
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 024CC81F18;
	Thu,  2 May 2019 07:35:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8940F7EE82;
	Thu,  2 May 2019 07:35:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 7558711AAF; Thu,  2 May 2019 09:35:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 09:35:36 +0200
Message-Id: <20190502073543.4391-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 02 May 2019 07:35:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/7] Usb 20190502 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502073536.uDNbj01fAYwnDhJPqWi2uoekZyjk3UiN44jvSOXo7xE@z>

The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a607=
31:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-30 17:06:57 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20190502-pull-request

for you to fetch changes up to f3ea801df82991e852862bcaede23a4607859dd8:

  hw/usb: avoid format truncation warning when formatting port name (2019=
-05-02 09:34:13 +0200)

----------------------------------------------------------------
usb: bugfixes for mtp and xhci, split ohci-pci.

----------------------------------------------------------------

Bandan Das (1):
  usb-mtp: change default to success for usb_mtp_update_object

Daniel P. Berrang=C3=A9 (3):
  usb-mtp: fix string length for filename when writing metadata
  usb-mtp: fix alignment of access of ObjectInfo filename field
  hw/usb: avoid format truncation warning when formatting port name

Longpeng (1):
  usb/xhci: avoid trigger assertion if guest write wrong epid

Thomas Huth (2):
  hw/usb/hcd-ohci: Do not use PCI functions with sysbus devices in
    ohci_die()
  hw/usb/hcd-ohci: Move PCI-related code into a separate file

 hw/usb/hcd-ohci.h     | 104 ++++++++++++++++++++
 hw/usb/dev-mtp.c      |  10 +-
 hw/usb/hcd-ohci-pci.c | 163 +++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c     | 219 ++++--------------------------------------
 hw/usb/hcd-xhci.c     |   4 +-
 hw/sh4/Kconfig        |   2 +-
 hw/usb/Kconfig        |   6 +-
 hw/usb/Makefile.objs  |   1 +
 8 files changed, 301 insertions(+), 208 deletions(-)
 create mode 100644 hw/usb/hcd-ohci.h
 create mode 100644 hw/usb/hcd-ohci-pci.c

--=20
2.18.1


