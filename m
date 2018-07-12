Received: from eggs.gnu.org ([2001:4830:134:3::10]:51491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fdXyK-0000oG-0a
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fdXyG-0000cu-2b
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:33:12 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 12 Jul 2018 11:32:59 +0200
Message-Id: <20180712093301.9343-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-3.0 0/2] s390x changes for 3.0-rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit c447afd5783b9237fa51b7a85777007d8d568b=
fc:

  Update version for v3.0.0-rc0 release (2018-07-10 18:19:50 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180712

for you to fetch changes up to 78dcf512efe72e211e6ca7783069364b01a1c05b:

  error: Remove NULL checks on error_propagate() calls (2018-07-11 14:36:=
54 +0200)

----------------------------------------------------------------
- fix confusion around sizes in storage attribute migration
- remove NULL check on error_propagate() in virtio-ccw

----------------------------------------------------------------

Claudio Imbrenda (1):
  s390x/storage attributes: fix CMMA_BLOCK_SIZE usage

Philippe Mathieu-Daud=C3=A9 (1):
  error: Remove NULL checks on error_propagate() calls

 hw/s390x/s390-stattrib-kvm.c | 3 ++-
 hw/s390x/s390-stattrib.c     | 5 +++--
 hw/s390x/virtio-ccw.c        | 4 +---
 3 files changed, 6 insertions(+), 6 deletions(-)

--=20
2.14.4
