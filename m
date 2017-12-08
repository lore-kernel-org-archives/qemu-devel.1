Received: from eggs.gnu.org ([2001:4830:134:3::10]:58490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNDLg-00024w-5S
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eNDLc-0005dc-7k
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:45:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eNDLc-0005bY-0V
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:45:28 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri,  8 Dec 2017 08:45:11 +0100
Message-Id: <20171208074515.1553-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/4] ivshmem: MSI bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, geoff@hostfission.com, marcandre.lureau@redhat.com, armbru@redhat.com

Fixes bugs in the ivshmem device implementation uncovered with the new
Windows ivshmem driver:
https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshm=
em

v1->v2:
* Patch 1 - added reproducer info to commit message (Markus)
* Patch 2 - restructured conditionals, fixed comment formatting (Markus)
* Patch 3 - added reproducer info to commit message (Markus)

v2->v3:
* Added patch 4

Ladi Prosek (4):
  ivshmem: Don't update non-existent MSI routes
  ivshmem: Always remove irqfd notifiers
  ivshmem: Improve MSI irqfd error handling
  ivshmem: Disable irqfd on device reset

 hw/misc/ivshmem.c | 101 ++++++++++++++++++++++++++++++++++++++----------=
------
 1 file changed, 71 insertions(+), 30 deletions(-)

--=20
2.13.6
