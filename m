Received: from eggs.gnu.org ([2001:4830:134:3::10]:60937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRbF-0001F5-4a
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRbB-0005KE-5z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTRbB-0005Ji-1W
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43282406DE36
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:43:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-1.ams2.redhat.com [10.36.117.1])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F05E2022F02
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:43:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 14:43:27 +0200
Message-Id: <20180614124330.12224-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/3] Miscellaneous patches for 2018-06-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268=
e2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-req=
uest' into staging (2018-06-12 15:34:34 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-06-13-v2

for you to fetch changes up to 3190af2dea9aceee72a0dfa087b8ea67ecff5519:

  Purge uses of banned g_assert_FOO() (2018-06-14 14:33:28 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2018-06-13

----------------------------------------------------------------
Markus Armbruster (2):
      Revert "Makefile: add target to print generated files"
      Purge uses of banned g_assert_FOO()

Paolo Bonzini (1):
      coverity-model: replay data is considered trusted

 Makefile                      |  3 ---
 hw/ide/ahci.c                 |  2 +-
 hw/ppc/spapr_ovec.c           | 12 ++++++------
 hw/usb/dev-smartcard-reader.c |  2 +-
 qom/object.c                  | 10 +++++-----
 scripts/coverity-model.c      | 12 ++++++++++++
 util/qht.c                    |  2 +-
 7 files changed, 26 insertions(+), 17 deletions(-)

--=20
2.17.1
