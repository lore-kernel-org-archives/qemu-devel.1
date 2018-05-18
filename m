Received: from eggs.gnu.org ([2001:4830:134:3::10]:60883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fJkyv-0006Po-2a
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fJkyr-0003JE-US
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:24:01 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1fJkyr-0003Hf-O0
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:23:57 -0400
From: Julian Brown <julian@codesourcery.com>
Date: Fri, 18 May 2018 12:23:40 -0700
Message-ID: <cover.1526671191.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/2] Nios II generic board config and
 semihosting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sandra Loosemore <sandra@codesourcery.com>, Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>, Andrew Jenner <Andrew_Jenner@mentor.com>

This is a third attempt at sending the patch series:

http://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04259.html

Turns out the git format-patch "--inline" option didn't do what I thought
it did. Apologies for the noise!

Thanks,

Julian

Julian Brown (2):
  Add generic Nios II board.
  Add Nios II semihosting support.

 hw/nios2/Makefile.objs     |   2 +-
 hw/nios2/boot.c            |   5 +-
 hw/nios2/generic_nommu.c   | 128 ++++++++++++++
 qemu-options.hx            |   8 +-
 target/nios2/Makefile.objs |   2 +-
 target/nios2/cpu.h         |   4 +-
 target/nios2/helper.c      |  11 ++
 target/nios2/nios2-semi.c  | 429 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 581 insertions(+), 8 deletions(-)
 create mode 100644 hw/nios2/generic_nommu.c
 create mode 100644 target/nios2/nios2-semi.c

-- 
1.9.1
