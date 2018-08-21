Received: from eggs.gnu.org ([2001:4830:134:3::10]:51884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fs9pI-00041z-Rd
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fs9oL-0006Uo-TF
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:47:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fs9oK-0006C5-V4
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE12E7D84D
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 16:47:12 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 21 Aug 2018 10:47:10 -0600
Message-ID: <153486991405.14686.16930315204565109405.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/1] vfio coverity reported error fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit ee135aa0428fe5af2af7be04ff16d2b596a9330a:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.1-20180821' into staging (2018-08-21 13:27:11 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-fix-20180821.0

for you to fetch changes up to 5d6023cf74cf403fd3aee903050f43278d359e6a:

  vfio/pci: Handle subsystem realpath() returning NULL (2018-08-21 10:29:26 -0600)

----------------------------------------------------------------
VFIO fix 2018-08-21

 - Fix coverity reported issue with use of realpath (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci: Handle subsystem realpath() returning NULL

 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
