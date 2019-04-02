Received: from eggs.gnu.org ([209.51.188.92]:41611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBL1D-0000n8-2o
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBL1C-0002xJ-1q
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:08:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBL1B-0002wM-QA
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:08:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AD698762F
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 15:08:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DF75F6B919
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 15:08:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 17:08:03 +0200
Message-Id: <20190402150803.23863-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/8] Miscellaneous patches for 2019-04-02
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit d61d1a1fb2f1db6c54651844a28389c523f3f8=
c7:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20190402-pull-r=
equest' into staging (2019-04-02 08:18:24 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-04-02

for you to fetch changes up to 79b9d4bde7db3f760851217b329c68a883184c6b:

  accel: Unbreak accelerator fallback (2019-04-02 13:50:09 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2019-04-02

Two regression fixes for 4.0:

* Unbreak migration for Xen
* Unbreak accelerator fallback

Three safe bug fixes thrown in:

* Fix error location of qemu-system-FOO positional arguments
* COLOStatus minor doc fix
* COLOStatus member rename to conform to naming rules

----------------------------------------------------------------
Markus Armbruster (6):
      vl: Fix error location of positional arguments
      Revert "vl: Fix to create migration object before block backends ag=
ain"
      Revert "migration: move only_migratable to MigrationState"
      migration: Support adding migration blockers earlier
      vl: Document dependencies hiding in global and compat props
      accel: Unbreak accelerator fallback

Zhang Chen (2):
      qapi/migration.json: Fix ColoStatus member last_mode's version
      qapi/migration.json: Rename COLOStatus last_mode to last-mode

 accel/accel.c           |  3 ++-
 include/sysemu/sysemu.h |  1 +
 migration/migration.c   | 11 +++++++----
 migration/migration.h   |  3 ---
 migration/savevm.c      |  2 +-
 qapi/migration.json     |  6 +++---
 vl.c                    | 45 ++++++++++++++++++++++++++++++-------------=
--
 7 files changed, 44 insertions(+), 27 deletions(-)

--=20
2.17.2
