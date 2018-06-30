Received: from eggs.gnu.org ([2001:4830:134:3::10]:55564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZBKd-0003XM-1u
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZBKZ-0001K8-Uk
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fZBKZ-0001Iy-OS
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id s11-v6so1614619wra.13
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 01:34:07 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sat, 30 Jun 2018 10:33:53 +0200
Message-Id: <20180630083357.23489-1-huth@tuxfamily.org>
Subject: [Qemu-devel] [PATCH v1 0/4] m68k: Add basic support for the
 NeXTcube machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>, Natalia Portillo <claunia@claunia.com>

During Google Summer of Code 2011, Bryce Lanham added the possibility to
emulate the NeXTcube machine in QEMU, e.g. see this URL for some details:

https://wiki.qemu.org/Google_Summer_of_Code_2011#NeXT_machines_system_emulation

But since the machine requires a 68040 CPU and this was not included in
upstream QEMU in 2011 yet, the patches have never been merged to upstream.
Now in 2018, Laurent completed the full 680x0 support in upstream QEMU, so
we could finally merge the NeXTcube support, too.

The QEMU interfaces changed a lot since 2011, so I had to modify the
sources quite a bit, but with the attached patches, it is now possible
to boot up to the firmware monitor again.

Note that boot device emulation is either still missing (network), or
not working correctly yet (SCSI), so you can not boot any operating
systems with this machine yet.

Please ignore the checkpatch warnings about C99 "//" comments. There
are many of those in the sources, used to comment out alternative code
lines. I did not want to remove those yet, since some of them could
still be helpful while improving the machine emulation in the future.

Thomas Huth (4):
  m68k: Add NeXTcube framebuffer device emulation
  m68k: Add NeXTcube keyboard device
  m68k: Add NeXTcube machine
  m68k: Add an entry for the NeXTcube machine to the MAINTAINERS file

 MAINTAINERS                      |    7 +
 default-configs/m68k-softmmu.mak |    4 +
 hw/display/Makefile.objs         |    1 +
 hw/display/next-fb.c             |  152 ++++
 hw/m68k/Makefile.objs            |    5 +-
 hw/m68k/next-cube.c              | 1103 ++++++++++++++++++++++++++++++
 hw/m68k/next-kbd.c               |  289 ++++++++
 include/hw/m68k/next-cube.h      |   49 ++
 8 files changed, 1608 insertions(+), 2 deletions(-)
 create mode 100644 hw/display/next-fb.c
 create mode 100644 hw/m68k/next-cube.c
 create mode 100644 hw/m68k/next-kbd.c
 create mode 100644 include/hw/m68k/next-cube.h

-- 
2.17.1
