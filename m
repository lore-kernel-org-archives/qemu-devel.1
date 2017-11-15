Received: from eggs.gnu.org ([2001:4830:134:3::10]:39629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEsAu-0003Zv-SI
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eEsAq-0005h7-Vo
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:31:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eEsAq-0005gN-PR
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:31:52 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 15 Nov 2017 08:31:41 +0100
Message-Id: <20171115073144.14758-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] ivshmem: MSI bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: geoff@hostfission.com, pbonzini@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com

Fixes bugs in the ivshmem device implementation uncovered with the new
Windows ivshmem driver:
https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshm=
em

v1->v2:
* Patch 1 - added reproducer info to commit message (Markus)
* Patch 2 - restructured conditionals, fixed comment formatting (Markus)
* Patch 3 - added reproducer info to commit message (Markus)

Ladi Prosek (3):
  ivshmem: Don't update non-existent MSI routes
  ivshmem: Always remove irqfd notifiers
  ivshmem: Improve MSI irqfd error handling

 hw/misc/ivshmem.c | 77 +++++++++++++++++++++++++++++++++++++++++--------=
------
 1 file changed, 58 insertions(+), 19 deletions(-)

--=20
2.13.5
