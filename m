Received: from eggs.gnu.org ([2001:4830:134:3::10]:35106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ew6UD-0004Pz-6S
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ew6U8-0001wM-7o
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:30:33 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:50744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ew6U7-0001l5-Ku
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:30:27 -0400
Received: from unknown (HELO localhost.localdomain)
	(Authenticated_SSL:abouassida@[41.224.44.126])
	(envelope-sender <abdallah.bouassida@lauterbach.com>)
	by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-SHA
	encrypted SMTP
	for <qemu-devel@nongnu.org>; 14 Mar 2018 13:30:08 -0000
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Date: Wed, 14 Mar 2018 14:28:01 +0100
Message-Id: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
Subject: [Qemu-devel] [PATCH v5 0/3] target/arm: Add a dynamic
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

The previous version:
http://patchwork.ozlabs.org/project/qemu-devel/list/?series=33190

Abdallah Bouassida (3):
  target/arm: Add "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo
    type
  target/arm: Add "_S" suffix to the secure version of a sysreg
  target/arm: Add the XML dynamic generation

 gdbstub.c            | 10 ++++++++
 include/qom/cpu.h    |  5 +++-
 target/arm/cpu.c     |  1 +
 target/arm/cpu.h     | 29 ++++++++++++++++++++-
 target/arm/gdbstub.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c  | 58 +++++++++++++++++++++++++++++++++---------
 6 files changed, 160 insertions(+), 14 deletions(-)

-- 
2.7.4
