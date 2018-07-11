Received: from eggs.gnu.org ([2001:4830:134:3::10]:54397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fdLDa-0004q6-B0
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fdLDX-0003CU-9A
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fdLDX-0003Bu-38
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:56:03 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A2A33086265
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 19:56:01 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 11 Jul 2018 13:55:58 -0600
Message-ID: <153133890557.31530.586346402906852972.stgit@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] VFIO fixes for qemu-3.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit c447afd5783b9237fa51b7a85777007d8d568b=
fc:

  Update version for v3.0.0-rc0 release (2018-07-10 18:19:50 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20180711.1

for you to fetch changes up to 26c0ae56386edacc8b0da40264748f59afedb1bb:

  vfio/pci: do not set the PCIDevice 'has_rom' attribute (2018-07-11 13:4=
3:57 -0600)

----------------------------------------------------------------
VFIO fixes 2018-07-11

 - Avoid RAMBlock segfault in option ROM teardown for vfio-pci devices
   (C=C3=A9dric Le Goater)

----------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      vfio/pci: do not set the PCIDevice 'has_rom' attribute

 hw/vfio/pci.c | 1 -
 1 file changed, 1 deletion(-)
