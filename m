Received: from eggs.gnu.org ([2001:4830:134:3::10]:47799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC0Ue-00070O-SI
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC0Ub-0003NB-Qa
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC0Ub-0003N3-Ms
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A87EFA466
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 10:20:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 12:20:30 +0200
Message-Id: <20180427102033.20232-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Usb 20180427 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit b8846a4d6352b2a1d2012f8b3b9115640524ae=
da:

  vl.c: new function serial_max_hds() (2018-04-26 13:58:29 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180427-pull-request

for you to fetch changes up to 0f5c642d49c3a843bd8b8790d7014fd84bcf6405:

  ccid-card: include libcacard.h only (2018-04-27 10:57:09 +0200)

----------------------------------------------------------------
usb: ccid bugfix, misc small improvements.

----------------------------------------------------------------

Jason Andryuk (1):
  ccid: Fix dwProtocols advertisement of T=3D0

John Thomson (1):
  Fix libusb-1.0.22 deprecated libusb_set_debug with libusb_set_option

Michal Privoznik (1):
  ccid-card: include libcacard.h only

 configure                     | 2 +-
 hw/usb/ccid-card-emulated.c   | 5 +----
 hw/usb/ccid-card-passthru.c   | 2 +-
 hw/usb/dev-smartcard-reader.c | 4 ++--
 hw/usb/host-libusb.c          | 4 ++++
 5 files changed, 9 insertions(+), 8 deletions(-)

--=20
2.9.3
