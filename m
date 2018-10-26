Received: from eggs.gnu.org ([2001:4830:134:3::10]:35401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFz1H-0006FF-JF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFz1G-0005iS-5W
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:07:07 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 26 Oct 2018 11:06:47 +0100
Message-Id: <1540548409-22560-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Deprecate the "collie" machine and
 Strongarm devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

These files lack an entry in the MAINTAINERS file, and according to
the initial commits, the board and devices are incomplete. Since there
have hardly been any commits in the past to really improve them, we
should consider to mark them as deprecated now.

Thomas Huth (2):
  hw/arm: Deprecate the "collie" board
  arm: Deprecate the Strongarm sa1100 and sa1110 processors

 hw/arm/collie.c      |  1 +
 qemu-deprecated.texi | 10 ++++++++++
 2 files changed, 11 insertions(+)

-- 
1.8.3.1
