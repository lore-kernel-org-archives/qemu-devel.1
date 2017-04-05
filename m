Received: from eggs.gnu.org ([2001:4830:134:3::10]:41301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvpqH-0005n7-Rz
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvpqD-00005M-W7
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:39:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:1231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvpqD-0008WJ-LG
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:39:37 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 5 Apr 2017 18:39:34 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A4F5CF@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 0/3] move xen related files to corresponding
 xen directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony.perard@citrix.com" <anthony.perard@citrix.com>, 'Paolo Bonzini' <pbonzini@redhat.com>

move xen related files to corresponding xen directory.

move xen-common.c to hw/xen/
move xen-hvm.c to hw/i386/xen/
move xen-mapcache.c to hw/i386/xen/


Signed-off -by: Anthony Xu <anthony.xu@intel.com>



Makefile.target                    |    6 -
 default-configs/i386-softmmu.mak   |    1 -
 default-configs/x86_64-softmmu.mak |    1 -
 hw/i386/xen/Makefile.objs          |    2 +-
 hw/i386/xen/trace-events           |   17 +
 hw/i386/xen/xen-hvm.c              | 1422 ++++++++++++++++++++++++++++++++=
++++
 hw/i386/xen/xen-mapcache.c         |  459 ++++++++++++
 hw/xen/Makefile.objs               |    2 +-
 hw/xen/xen-common.c                |  158 ++++
 stubs/Makefile.objs                |    2 +
 stubs/xen-common.c                 |   14 +
 stubs/xen-hvm.c                    |   63 ++
 trace-events                       |   16 -
 xen-common-stub.c                  |   14 -
 xen-common.c                       |  158 ----
 xen-hvm-stub.c                     |   63 --
 xen-hvm.c                          | 1422 --------------------------------=
----
 xen-mapcache.c                     |  459 ------------
 18 files changed, 2137 insertions(+), 2142 deletions(-)
 create mode 100644 hw/i386/xen/xen-hvm.c
 create mode 100644 hw/i386/xen/xen-mapcache.c
 create mode 100644 hw/xen/xen-common.c
 create mode 100644 stubs/xen-common.c
 create mode 100644 stubs/xen-hvm.c
 delete mode 100644 xen-common-stub.c
 delete mode 100644 xen-common.c
 delete mode 100644 xen-hvm-stub.c
 delete mode 100644 xen-hvm.c
 delete mode 100644 xen-mapcache.c
