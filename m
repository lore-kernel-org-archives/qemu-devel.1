Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNhnO-0007fT-8Q
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNhnJ-0003d5-IF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:43:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dNhnJ-0003cd-Bv
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:43:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2560915D9
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 15:43:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Jun 2017 17:43:46 +0200
Message-Id: <20170621154347.32084-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Usb 20170621 patches
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

The following changes since commit 8dfaf23ae1f2273a9730a9b309cc8471269bb524:

  tcg/tci: fix tcg-interpreter build (2017-06-20 18:39:15 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20170621-pull-request

for you to fetch changes up to 896b6757f9c4d176ce4439238efea223a2952411:

  usb-host: support devices with sparse/non-sequential USB interfaces (2017-06-21 15:30:08 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Samuel Brian (1):
  usb-host: support devices with sparse/non-sequential USB interfaces

 hw/usb/host-libusb.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

-- 
2.9.3
