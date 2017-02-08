Received: from eggs.gnu.org ([2001:4830:134:3::10]:39777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbbNO-0004C2-NW
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cbbNJ-0003eN-20
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:10:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:9163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juro.bystricky@intel.com>)
	id 1cbbNI-0003dk-QO
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:10:08 -0500
From: Juro Bystricky <juro.bystricky@intel.com>
Date: Wed,  8 Feb 2017 15:06:05 -0800
Message-Id: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/1] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marex@denx.de, crwulff@gmail.com, jurobystricky@hotmail.com, Juro Bystricky <juro.bystricky@intel.com>

v3: including a link to HW registers specs


Juro Bystricky (1):
  nios2: Add Altera JTAG UART emulation

 default-configs/nios2-softmmu.mak |   1 +
 hw/char/Makefile.objs             |   1 +
 hw/char/altera_juart.c            | 268 ++++++++++++++++++++++++++++++++++++++
 include/hw/char/altera_juart.h    |  44 +++++++
 4 files changed, 314 insertions(+)
 create mode 100644 hw/char/altera_juart.c
 create mode 100644 include/hw/char/altera_juart.h

-- 
2.7.4
