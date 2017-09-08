Received: from eggs.gnu.org ([2001:4830:134:3::10]:42501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dqJnz-00026g-Dh
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dqJnu-0005ei-J8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:58:47 -0400
Received: from chuckie.co.uk ([82.165.15.123]:53045
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dqJnu-0005bC-CL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:58:42 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  8 Sep 2017 14:58:24 +0100
Message-Id: <1504879106-2225-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] sun4u: add Sun HME (Happy Meal Ethernet)
 on-board NIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Only a few OSs contain support for QEMU's in-built PCI NICs as they were
very rarely used with sun4u hardware and so either aren't compiled in by
default or fail because of endian issues.

This patchset implements the Sun HME (Happy Meal Ethernet) NIC for sun4u, a
common in-built NIC to provide out-of-the-box networking for nearly all
OSs and then makes it the default for sun4u machines.

The remaining hold-outs in my tests are OpenBSD and OpenSolaris, however
this is because they map PCI space differently using a feature which isn't
yet implemented in QEMU's sun4u MMU code.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  net: add Sun HME (Happy Meal Ethernet) on-board NIC
  sun4u: use sunhme as default on-board NIC

 default-configs/sparc64-softmmu.mak |    1 +
 hw/net/Makefile.objs                |    1 +
 hw/net/sunhme.c                     |  978 +++++++++++++++++++++++++++++++++++
 hw/net/trace-events                 |   29 ++
 hw/sparc64/sun4u.c                  |   25 +-
 include/hw/net/mii.h                |    4 +
 include/hw/pci/pci_ids.h            |    1 +
 7 files changed, 1035 insertions(+), 4 deletions(-)
 create mode 100644 hw/net/sunhme.c

-- 
1.7.10.4
