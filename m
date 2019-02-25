Received: from eggs.gnu.org ([209.51.188.92]:36833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI47-00084K-PH
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI45-0000Vf-UW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:11 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:44 +0100
Message-Id: <20190225152053.15976-3-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/71] MAINTAINERS: Remove myself as block
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Jeff Cody <jcody@redhat.com>

I'll not be involved in day-to-day qemu development.  Remove myself as
maintainer from the remainder of the network block drivers, and revert
them to the general block layer maintainership.

Move 'sheepdog' to the 'Odd Fixes' support level.

For VHDX, added my personal email address as a maintainer, as I can
answer questions or send the occassional bug fix.  Leaving it as
'Supported', instead of 'Odd Fixes', because I think the rest of the
block layer maintainers and developers will upkeep it as well, if
needed.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Acked-by: Max Reitz <mreitz@redhat.com>
Message-Id: <63e205cb84c8f0a10c1bc6d5d6856d72ceb56e41.1537984851.git.jcod=
y@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 MAINTAINERS | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb4d9829a4..e7f69f31ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2246,26 +2246,22 @@ F: block/vmdk.c
=20
 RBD
 M: Josh Durgin <jdurgin@redhat.com>
-M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/rbd.c
-T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 Sheepdog
 M: Liu Yuan <namei.unix@gmail.com>
-M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
-S: Supported
+L: sheepdog@lists.wpkg.org
+S: Odd Fixes
 F: block/sheepdog.c
-T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 VHDX
-M: Jeff Cody <jcody@redhat.com>
+M: Jeff Cody <codyprime@gmail.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/vhdx*
-T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 VDI
 M: Stefan Weil <sw@weilnetz.de>
@@ -2295,34 +2291,26 @@ F: docs/interop/nbd.txt
 T: git https://repo.or.cz/qemu/ericb.git nbd
=20
 NFS
-M: Jeff Cody <jcody@redhat.com>
 M: Peter Lieven <pl@kamp.de>
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/nfs.c
-T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 SSH
 M: Richard W.M. Jones <rjones@redhat.com>
-M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/ssh.c
-T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 CURL
-M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/curl.c
-T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 GLUSTER
-M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/gluster.c
-T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 Null Block Driver
 M: Fam Zheng <fam@euphon.net>
--=20
2.20.1
