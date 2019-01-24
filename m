Received: from eggs.gnu.org ([209.51.188.92]:47946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9W-0004IZ-Tr
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9V-0004oQ-6R
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmg9U-0004Tv-R7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CA50107AB
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:38:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-138.ams2.redhat.com
	[10.36.116.138])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E8B6E10021B1
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:38:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Jan 2019 15:38:21 +0100
Message-Id: <20190124143825.25921-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] QAPI patches for 2019-01-24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f6b06fcceef465de0cf2514c9f76fe01928967=
81:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-requ=
est' into staging (2019-01-23 17:57:47 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-01-24

for you to fetch changes up to bbc0586ced6e9ffdfd29d89fcc917b3d90ac3938:

  json: Fix % handling when not interpolating (2019-01-24 15:20:59 +0100)

----------------------------------------------------------------
QAPI patches for 2019-01-24

----------------------------------------------------------------
Christophe Fergeau (1):
      json: Fix % handling when not interpolating

Markus Armbruster (2):
      qapi: Belatedly update docs for commit 9c2f56e9f9d
      qapi: Eliminate indirection through qmp_event_get_func_emit()

Wainer dos Santos Moschetta (1):
      qmp: Add examples to qom list, get, and set commands

 docs/devel/qapi-code-gen.txt | 12 +++---------
 include/qapi/qmp-event.h     |  6 ------
 monitor.c                    |  4 +---
 qapi/misc.json               | 36 ++++++++++++++++++++++++++++++++++++
 qapi/qmp-event.c             | 12 ------------
 qobject/json-parser.c        | 10 ++++++----
 scripts/qapi/events.py       | 24 ++++++++++++++----------
 stubs/monitor.c              |  5 +++++
 tests/Makefile.include       |  4 ++--
 tests/check-qjson.c          |  5 +++++
 tests/test-qmp-event.c       |  6 +-----
 11 files changed, 73 insertions(+), 51 deletions(-)

--=20
2.17.2
