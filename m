Received: from eggs.gnu.org ([2001:4830:134:3::10]:56340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSIKM-0001rl-Ev
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSIKH-0007pW-7R
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSIKG-0007p4-W9
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:37 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 10:09:30 +0100
Message-Id: <20181129090933.30622-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] memory: update coalesced_range on
 transaction_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>

The e1000 driver calls memory_region_add_coalescing but
kvm_coalesce_mmio_region is never called for those regions.  The bug
dates back to the introduction of the memory region API; to fix it,
the last patch deletes and re-adds coalesced MMIO ranges when building
the FlatViews.  The first two patches are preparatory changes.

Paolo Bonzini (3):
  memory: extract flat_range_coalesced_io_{del,add}
  memory: avoid unnecessary coalesced_io_del operations
  memory: update coalesced_range on transaction_commit

 memory.c | 78 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 25 deletions(-)

--=20
2.19.1
