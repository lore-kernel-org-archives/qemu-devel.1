Received: from eggs.gnu.org ([2001:4830:134:3::10]:45948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fJRYH-0006GR-67
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fJRYD-0008Op-6V
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:39:13 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1fJRYD-0008Nk-0T
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:39:09 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1fJRY9-0003cO-D0 from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:39:05 -0700
From: Julian Brown <julian@codesourcery.com>
Date: Thu, 17 May 2018 15:38:48 -0700
Message-ID: <cover.1526595970.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=fixed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] Nios II generic board config and
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


These patches add support for a generic MMU-less Nios II board and
add semihosting support for Nios II, the latter based on the m68k
semihosting implementation.  These are useful for testing "bare metal"
Nios II toolchains, given appropriate startup code.  I've tested our
internal builds successfully with these patches.

OK, or any comments?

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
2.8.1
