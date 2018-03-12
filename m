Received: from eggs.gnu.org ([2001:4830:134:3::10]:38977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkI-0004Mk-Ar
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkF-0003aG-5F
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:31:58 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:60993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1evKkE-00032v-R8
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:31:55 -0400
Received: from unknown (HELO localhost.localdomain)
	(Authenticated_SSL:abouassida@[41.224.44.126])
	(envelope-sender <abdallah.bouassida@lauterbach.com>)
	by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-SHA
	encrypted SMTP
	for <qemu-devel@nongnu.org>; 12 Mar 2018 10:31:36 -0000
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Date: Mon, 12 Mar 2018 11:31:26 +0100
Message-Id: <1520850690-23245-1-git-send-email-abdallah.bouassida@lauterbach.com>
Subject: [Qemu-devel] [PATCH v4 0/4] Add a dynamic XML-description of the
 cp-registers to GDB
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

The previous version:
http://patchwork.ozlabs.org/project/qemu-devel/list/?series=30973

Abdallah Bouassida (4):
  target/arm: Add "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo
    type
  target/arm: Add "_S" suffix to the secure version of a sysreg
  target/arm: Add the XML dynamic generation
  target/arm: Add arm_gdb_set_sysreg() callback

 gdbstub.c            | 10 ++++++++
 include/qom/cpu.h    |  5 +++-
 target/arm/cpu.c     |  1 +
 target/arm/cpu.h     | 20 ++++++++++++++-
 target/arm/gdbstub.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c  | 72 +++++++++++++++++++++++++++++++++++++++++++---------
 6 files changed, 165 insertions(+), 14 deletions(-)

-- 
2.7.4
