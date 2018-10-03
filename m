Received: from eggs.gnu.org ([2001:4830:134:3::10]:52317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7faZ-0004qb-2Q
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7faV-0007iY-0c
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7faU-0007i3-NM
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 15:44:51 +0400
Message-Id: <20181003114454.5662-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] Mark non-volatile memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

As discussed in the "[PATCH v10 6/6] tpm: add ACPI memory clear
interface" thread, and proposed in the "[PATCH] RFC: mark non-volatile
memory region", here is a small series to mark non-volvatile memory
regions and skip them on dump. Upcoming TCG "Platform Reset Attack
Mitigation" will also use this information to eventually skip
non-volatile memory.

Thanks

Marc-Andr=C3=A9 Lureau (3):
  memory: learn about non-volatile memory region
  nvdimm: set non-volatile on the memory region
  memory-mapping: skip non-volatile memory regions in GuestPhysBlockList

 include/exec/memory.h    | 25 ++++++++++++++++++++++
 hw/mem/nvdimm.c          |  1 +
 memory.c                 | 45 +++++++++++++++++++++++++++++++---------
 memory_mapping.c         |  3 ++-
 docs/devel/migration.rst |  1 +
 5 files changed, 64 insertions(+), 11 deletions(-)

--=20
2.19.0.271.gfe8321ec05
