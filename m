Received: from eggs.gnu.org ([209.51.188.92]:40770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvi-0005Li-HH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvh-0004EP-Mw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hAsvh-0004Dy-EK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  1 Apr 2019 11:08:22 +0200
Message-Id: <20190401090827.20793-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] Compat props bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, kwolf@redhat.com, imammedo@redhat.com

v2:
* PATCH 1-4: Complete rewrite of fatally flawed PATCH v1 1/2 [Igor]

Markus Armbruster (5):
  Revert "vl: Fix to create migration object before block backends
    again"
  Revert "migration: move only_migratable to MigrationState"
  migration: Support adding migration blockers earlier
  vl: Document dependencies hiding in global and compat props
  accel: Unbreak accelerator fallback

 accel/accel.c           |  3 ++-
 include/sysemu/sysemu.h |  1 +
 migration/migration.c   | 11 +++++++----
 migration/migration.h   |  3 ---
 migration/savevm.c      |  2 +-
 vl.c                    | 44 +++++++++++++++++++++++++++--------------
 6 files changed, 40 insertions(+), 24 deletions(-)

--=20
2.17.2
