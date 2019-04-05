Received: from eggs.gnu.org ([209.51.188.92]:56235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6H-0003mE-Dy
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6F-0004Dh-DJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCR6A-00045R-Qj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:50 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  5 Apr 2019 16:49:32 +0100
Message-Id: <20190405154934.18664-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, chen.zhang@intel.com, quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 10546e09e174e0bb185b66a4c397aa845efcd3=
6e:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-4.0-=
rc3-v2' into staging (2019-04-05 04:50:30 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20190405a

for you to fetch changes up to d013283a46e1f197594e76ed320f867067ab80b3:

  migration: Fix migrate_set_parameter (2019-04-05 15:32:13 +0100)

----------------------------------------------------------------
Migration fixes pull for 4.0

A couple of fixes for crashes in colo and
migration parameters.

----------------------------------------------------------------
Juan Quintela (1):
      migration: Fix migrate_set_parameter

Zhang Chen (1):
      migration/ram.c: Fix codes conflict about bitmap_mutex

 hmp.c           | 6 ++++--
 migration/ram.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)
