Received: from eggs.gnu.org ([2001:4830:134:3::10]:34491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNxE8-0002RS-7P
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNxE5-00070V-2h
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:17:04 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 May 2018 11:16:55 +0200
Message-Id: <1527671818-23809-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] pc-bios/s390-ccw: Allow network booting
 via pxelinux.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

This patch series adds pxelinux.cfg-style network booting to the s390-ccw
firmware. The core pxelinux.cfg loading and parsing logic has recently
been merged to SLOF, so these patches now just have to make sure to call
the right functions to get the config file loaded and parsed. Once this is
done, the kernel and initrd are loaded separately, and are then glued
together in RAM.

Note that you have to update the roms/SLOF submodule to the latest version
of SLOF first (64c526a6020c3042e3b2a505d5f5f11478d5f2cb). Unfortunately the
SLOF.git mirror on qemu.org currently is not updated anymore (i.e. this also
must be fixed), so you need to use the upstream https://github.com/aik/SLOF
if you want to test the patches right now.

Thomas Huth (3):
  pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
  pc-bios/s390-ccw/net: Add support for pxelinux-style config files
  pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the
    UUID

 pc-bios/s390-ccw/netboot.mak |   9 +-
 pc-bios/s390-ccw/netmain.c   | 208 ++++++++++++++++++++++++++++---------------
 2 files changed, 143 insertions(+), 74 deletions(-)
