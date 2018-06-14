Received: from eggs.gnu.org ([2001:4830:134:3::10]:39903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTTcy-0006xH-Fb
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTTct-0006Q4-OC
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:53:32 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 14 Jun 2018 16:53:16 +0200
Message-Id: <1528988003-21855-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 0/7] pxelinux.cfg-style booting
 for the s390x bios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

This PULL request is not for master.


 Hi Cornelia,

the following changes since commit f0b9be93001e6215dc1195f3d75ad2da8b3b694a:

  s390x/cpumodels: add z14 Model ZR1 (2018-06-13 13:36:19 +0200)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/s390x-2018-06-14

for you to fetch changes up to 298d87666ddaf329326f7ed351a2d407f06d8b1a:

  pc-bios/s390-ccw: Update the s390-netboot.img binary (2018-06-14 16:13:49 +0200)

------------------------------------------------------------------------
Add support for pxelinux.cfg-style network booting to the s390x firmware
------------------------------------------------------------------------

Collin Walling (1):
      pc-bios/s390-ccw: define loadparm length

Thomas Huth (6):
      roms: Update SLOF submodule to current status
      pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
      pc-bios/s390-ccw/net: Add support for pxelinux-style config files
      pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the UUID
      pc-bios/s390-ccw: Optimize the s390-netboot.img for size
      pc-bios/s390-ccw: Update the s390-netboot.img binary

 pc-bios/s390-ccw/Makefile    |   1 +
 pc-bios/s390-ccw/iplb.h      |   4 +-
 pc-bios/s390-ccw/main.c      |   8 +-
 pc-bios/s390-ccw/netboot.mak |  13 +--
 pc-bios/s390-ccw/netmain.c   | 226 +++++++++++++++++++++++++++++--------------
 pc-bios/s390-ccw/sclp.c      |   2 +-
 pc-bios/s390-ccw/sclp.h      |   2 +-
 pc-bios/s390-netboot.img     | Bin 87872 -> 54944 bytes
 roms/SLOF                    |   2 +-
 9 files changed, 174 insertions(+), 84 deletions(-)


-- 
1.8.3.1
