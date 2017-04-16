Received: from eggs.gnu.org ([2001:4830:134:3::10]:37874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cztWZ-0003iU-Vw
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cztWW-0007pT-0Q
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:07 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cztWV-0007ou-Ph
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:03 -0400
Received: by mail-pg0-x241.google.com with SMTP id o123so24023059pga.1
	for <qemu-devel@nongnu.org>; Sun, 16 Apr 2017 16:24:03 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon, 17 Apr 2017 08:23:49 +0900
Message-Id: <cover.1492384862.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH 0/7] Openrisc misc features / fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>

Hello,

The first patch here I sent a few weeks ago and got go response.  Sending
again.

The second was requested by the uclibc-ng maintainer as when he is testing
his builds he uses qemu and would like to have a way for the system to shut
down.  This models how our other simulators shutdown, so no changes are
needed on the kernel side.

The others I added while working on upcoming openrisc smp support.

-Stafford

Stafford Horne (7):
  target/openrisc: Fixes for memory debugging
  target/openrisc: add shutdown logic
  target/openrisc: add numcores and coreid support
  target/openrisc: implement shadow registers
  migration: Add VMSTATE_UINTTL_2DARRAY()
  migration: Add VMSTATE_STRUCT_2DARRAY()
  target/openrisc: Implement full vmstate serialization

 include/migration/cpu.h      |  7 ++++
 include/migration/vmstate.h  | 15 +++++++++
 target/openrisc/cpu.c        |  5 ++-
 target/openrisc/cpu.h        |  4 ++-
 target/openrisc/helper.h     |  1 +
 target/openrisc/machine.c    | 76 ++++++++++++++++++++++++++++++++++++++++++--
 target/openrisc/mmu.c        | 23 +++++++++++---
 target/openrisc/sys_helper.c | 32 +++++++++++++++++++
 target/openrisc/translate.c  |  8 +++--
 9 files changed, 160 insertions(+), 11 deletions(-)

-- 
2.9.3
