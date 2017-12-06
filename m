Received: from eggs.gnu.org ([2001:4830:134:3::10]:33402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eMd62-0003Db-Q7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eMd5z-0000zq-NY
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:02:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eMd5z-0000zQ-Fb
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:02:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C69B61D20
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 17:02:54 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 06 Dec 2017 10:02:50 -0700
Message-ID: <20171206170019.24842.47488.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL for-2.11 0/1] VFIO: Fix vfio-kvm device group
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 2babfe0c9241c239272a03fec785165a50e8288c:

  Update version for v2.11.0-rc4 release (2017-12-05 16:36:46 +0000)

are available in the git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20171206.0

for you to fetch changes up to 13e6ae741cc0848a1819f435e2251d6d0bfae3e1:

  vfio: Fix vfio-kvm group registration (2017-12-05 13:22:45 -0700)

----------------------------------------------------------------
VFIO fix for v2.11-final

 - Fix bug failing to register all but the first group attached to
   a container with kvm-vfio device (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio: Fix vfio-kvm group registration

 hw/vfio/common.c | 1 +
 1 file changed, 1 insertion(+)
