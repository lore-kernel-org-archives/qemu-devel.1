Received: from eggs.gnu.org ([2001:4830:134:3::10]:38996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dXCnO-0007mG-5f
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dXCnL-0006nC-CK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:39:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dXCnL-0006ly-3L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:39:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AE327A16A
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 20:39:05 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 17 Jul 2017 14:39:02 -0600
Message-ID: <20170717203658.15922.21967.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/1] VFIO fixes 2017-07-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request'
into staging (2017-07-17 17:54:17 +0100)

are available in the git repository at:


  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170717.0

for you to fetch changes up to 8c37faa475f35d158622422788fe8e5aef3118e1:

  vfio-pci, ppc64/spapr: Reorder group-to-container attaching (2017-07-17
12:39:09 -0600)

----------------------------------------------------------------
VFIO fixes 2017-07-17

 - Init re-order to better support hot-add on SPAR (Alexey Kardashevskiy)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      vfio-pci, ppc64/spapr: Reorder group-to-container attaching

 hw/vfio/common.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)
