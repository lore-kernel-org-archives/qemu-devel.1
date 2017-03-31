Received: from eggs.gnu.org ([2001:4830:134:3::10]:33619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ctzvL-0000H9-Ak
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ctzvH-0001O4-Gs
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ctzvH-0001MP-9w
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0266E76F6
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 17:01:13 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 31 Mar 2017 11:01:08 -0600
Message-ID: <20170331170018.11643.80499.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/1] VFIO fixes 2017-03-31
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 37c4a85cd256a51c5f58ee7e531f25f0e89b2c87:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170331' into
staging (2017-03-31 12:43:27 +0100)

are available in the git repository at:


  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170331.0

for you to fetch changes up to 93587e3af3a259deac89c12863d93653d69d22b8:

  Revert "vfio/pci-quirks.c: Disable stolen memory for igd VFIO" (2017-03-31
10:04:41 -0600)

----------------------------------------------------------------
VFIO fixes 2017-03-31

 - We can't disable stolen memory for UPT mode, it breaks Windows
   drivers on Gen9+ IGD (Xiong Zhang)

----------------------------------------------------------------
Xiong Zhang (1):
      Revert "vfio/pci-quirks.c: Disable stolen memory for igd VFIO"

 hw/vfio/pci-quirks.c | 65
++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 38 deletions(-)
