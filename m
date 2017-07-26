Received: from eggs.gnu.org ([2001:4830:134:3::10]:35905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daRJU-0000or-12
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daRJP-0001U9-9Y
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:45:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1daRJP-0001TX-2K
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:45:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 008E64E33D
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 18:45:34 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 26 Jul 2017 12:45:31 -0600
Message-ID: <20170726184421.1315.42536.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] VFIO fixes for v2.10-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 522fd24ca030c27c591dafedd65c1dfd51e404=
50:

  Update version for v2.10.0-rc0 release (2017-07-25 17:13:09 +0100)

are available in the git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20170726.0

for you to fetch changes up to 96d2c2c57452f8b6bc3decae71435e7230f3432e:

  vfio/pci: fix use of freed memory (2017-07-26 11:38:18 -0600)

----------------------------------------------------------------
VFIO fixes 2017-07-26

 - Error path use after free bug fixes (Philippe Mathieu-Daud=C3=A9)

----------------------------------------------------------------
Philippe Mathieu-Daud=C3=A9 (2):
      vfio/platform: fix use of freed memory
      vfio/pci: fix use of freed memory

 hw/vfio/pci.c      | 11 +++++++----
 hw/vfio/platform.c |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)
