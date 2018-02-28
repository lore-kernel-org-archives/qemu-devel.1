Received: from eggs.gnu.org ([2001:4830:134:3::10]:40135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1eqzV2-0003aD-4q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1eqzUx-0007KF-9q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:02:16 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:40468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1eqzUw-0007C0-Vd
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:02:11 -0500
Received: from unknown (HELO localhost.localdomain)
	(Authenticated_SSL:abouassida@[41.224.44.126])
	(envelope-sender <abdallah.bouassida@lauterbach.com>)
	by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-SHA
	encrypted SMTP
	for <qemu-devel@nongnu.org>; 28 Feb 2018 11:01:51 -0000
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Date: Wed, 28 Feb 2018 12:01:21 +0100
Message-Id: <1519815685-29200-1-git-send-email-abdallah.bouassida@lauterbach.com>
Subject: [Qemu-devel] [PATCH v3 0/4] target/arm: Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, khaled.jmal@lauterbach.com, Abdallah Bouassida <abdallah.bouassida@lauterbach.com>

The last exchange:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03618.html

- Add a new "ARM_CP_NO_GDB" bit field and enable it when creating CP_ANY
  wildcard aliases.
- Add "_S" suffix to the secure version of a sysreg and fix the reg names that
  were manually containing (S) or (NS).
- Add the XML dynamic generation and add a callback to read these sysregs.
- Add a callback to set these sysregs (I put this as a separate patch as
  we still discussing if we'll give a write access for these sysregs from GDB).

@Peter: Intresting advises from your last review, Thanks a lot ;)


Abdallah Bouassida (4):
  target/arm: Add "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo
    type
  target/arm: Add "_S" suffix to the secure version of a sysreg
  target/arm: Add the XML dynamic generation
  target/arm: Add arm_gdb_set_sysreg() callback

 gdbstub.c            |   7 ++++
 include/qom/cpu.h    |   9 +++-
 target/arm/cpu.c     |   3 ++
 target/arm/cpu.h     |  22 +++++++++-
 target/arm/gdbstub.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c  |  35 ++++++++++------
 6 files changed, 177 insertions(+), 15 deletions(-)

-- 
2.7.4
