Received: from eggs.gnu.org ([2001:4830:134:3::10]:34524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iY-00027k-KQ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iV-0008Eg-F8
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gA7iV-0007dX-6X
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8398581DE9
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E2F6977DD7
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 10 Oct 2018 08:11:08 +0200
Message-Id: <20181010061113.6057-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Miscellaneous patches for 2018-10-10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 7c69b7c849641a39ba3defa40d384a2ba24cd7=
a2:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
81008' into staging (2018-10-08 15:01:30 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-10-10

for you to fetch changes up to b266f1d1123396f9f5df865508f7555ab0c9582a:

  ivshmem: Fix unplug of device "ivshmem-plain" (2018-10-10 08:01:36 +020=
0)

----------------------------------------------------------------
Miscellaneous patches for 2018-10-10

* Fix ivshmem unplug (regressed in v2.7.0)
* Minor test suite and doc work

----------------------------------------------------------------
Kashyap Chamarthy (1):
      qapi/misc.json: Remove superfluous words in CpuModelExpansionType

Marc-Andr=C3=A9 Lureau (1):
      tests/check-qjson: fix a leak

Markus Armbruster (3):
      tests: Restore check-qdict unit test
      libqtest: Inline g_assert_no_errno()
      ivshmem: Fix unplug of device "ivshmem-plain"

 hw/misc/ivshmem.c      | 14 +++++---------
 qapi/misc.json         | 12 ++++++------
 tests/Makefile.include |  2 +-
 tests/check-qdict.c    |  2 ++
 tests/check-qjson.c    |  1 +
 tests/libqtest.c       | 11 +++--------
 6 files changed, 18 insertions(+), 24 deletions(-)

--=20
2.17.1
