Received: from eggs.gnu.org ([209.51.188.92]:56447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfr7-0004wK-M6
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfr6-0008MU-Tr
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:05 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 13:18:54 -0600
Message-Id: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/6] include: Auto-generate the sizes lookup
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lbloch@janustech.com, armbru@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org

Patches speak louder than words.  This is my counter-proposal to
Leonid's thread on how best to respresent the S_*iB macros in units.h,
where my proposal is that we don't need them at all. (hence my subject
line, even though it is completely unrelated to the series)

True, my diffstat is even bigger, but I think it is more maintainable
in the long run (if calling QemuOpts maintainable is even appropriate).

Eric Blake (6):
  qemu-option: Allow integer defaults
  block: Take advantage of QemuOpt default integers
  Revert "vdi: Use a literal number of bytes for DEFAULT_CLUSTER_SIZE"
  qemu: Prefer '(x * MiB)' over 'S_xiB'
  Revert "include: Add a comment to explain the origin of sizes' lookup
    table"
  Revert "include: Add a lookup table of sizes"

 block/qcow2.h         | 10 +++---
 include/qemu/option.h | 12 +++++++
 include/qemu/units.h  | 73 -------------------------------------------
 block/parallels.c     |  2 +-
 block/qcow2.c         |  2 +-
 block/qed.c           |  2 +-
 block/vdi.c           |  6 ++--
 block/vhdx.c          |  3 +-
 util/qemu-option.c    | 69 ++++++++++++++++++++++++++++++++++------
 9 files changed, 84 insertions(+), 95 deletions(-)

--=20
2.20.1
