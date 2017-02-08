Received: from eggs.gnu.org ([2001:4830:134:3::10]:47447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cba59-0008CS-9R
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1cba54-0003Hx-GN
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:47:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:35319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juro.bystricky@intel.com>)
	id 1cba54-0003Hg-8T
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:47:14 -0500
From: Juro Bystricky <juro.bystricky@intel.com>
Date: Wed,  8 Feb 2017 13:43:10 -0800
Message-Id: <1486590191-10949-1-git-send-email-juro.bystricky@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/1] Nios2: Altera JATAG UART
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

Second version, had to remove a long web link (over 90 chars).


Juro Bystricky (1):
  nios2: Add Altera JTAG UART emulation

 default-configs/nios2-softmmu.mak |   1 +
 hw/char/Makefile.objs             |   1 +
 hw/char/altera_juart.c            | 265 ++++++++++++++++++++++++++++++++++++++
 include/hw/char/altera_juart.h    |  44 +++++++
 4 files changed, 311 insertions(+)
 create mode 100644 hw/char/altera_juart.c
 create mode 100644 include/hw/char/altera_juart.h

-- 
2.7.4
