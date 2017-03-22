Received: from eggs.gnu.org ([2001:4830:134:3::10]:52578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN8-0007tX-GM
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN5-0001Jx-B0
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqkN5-0001Iv-3E
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD14E8FCFC
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A88067F38D
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 18:48:11 +0100
Message-Id: <1490204908-26567-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 for-2.9 00/17] QAPI patches for 2017-03-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v2:
* Leak fix squashed into 16/17

The following changes since commit 940a8ce075e3408742a4edcabfd6c2a15e2539=
eb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-03-20 16:34:26 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-03-22-v2

for you to fetch changes up to 02bbae70011a95676408731e6710eba93d2e3ebf:

  qapi: Fix QemuOpts visitor regression on unvisited input (2017-03-22 18=
:39:44 +0100)

----------------------------------------------------------------
QAPI patches for 2017-03-22

----------------------------------------------------------------
Eric Blake (3):
      tests: Expose regression in QemuOpts visitor
      qom: Avoid unvisited 'id'/'qom-type' in user_creatable_add_opts
      qapi: Fix QemuOpts visitor regression on unvisited input

Markus Armbruster (14):
      test-keyval: Tweaks to improve list coverage
      keyval: Improve some comments
      test-keyval: Cover alternate and 'any' type
      keyval: Document issues with 'any' and alternate types
      MAINTAINERS: Add myself for files I touched recently
      qapi: Drop excessive Make dependencies on qapi2texi.py
      qapi2texi: Fix to actually fail when 'doc-required' is false
      qapi: Drop unused QAPIDoc member optional
      tests/qapi-schema: Make test-qapi.py print docs again
      tests/qapi-schema: Systematic positive doc comment tests
      qapi2texi: Fix translation of *strong* and _emphasized_
      qapi: Fix string input visitor regression for empty lists
      Revert "hostmem: fix QEMU crash by 'info memdev'"
      test-qobject-input-visitor: Cover visit_type_uint64()

 MAINTAINERS                        |  11 ++
 Makefile                           |   7 +-
 backends/hostmem.c                 |  22 ++--
 qapi/opts-visitor.c                |   6 +-
 qapi/string-input-visitor.c        |   4 +
 qom/object_interfaces.c            |   8 +-
 scripts/qapi.py                    |   1 -
 scripts/qapi2texi.py               |   5 +-
 tests/Makefile.include             |  15 ++-
 tests/qapi-schema/doc-good.err     |   0
 tests/qapi-schema/doc-good.exit    |   1 +
 tests/qapi-schema/doc-good.json    | 136 +++++++++++++++++++++
 tests/qapi-schema/doc-good.out     | 148 ++++++++++++++++++++++
 tests/qapi-schema/doc-good.texi    | 243 +++++++++++++++++++++++++++++++=
++++++
 tests/qapi-schema/test-qapi.py     |  11 ++
 tests/test-keyval.c                |  59 ++++++++-
 tests/test-opts-visitor.c          |  27 ++++-
 tests/test-qobject-input-visitor.c |  30 +++++
 tests/test-string-input-visitor.c  |  11 +-
 util/keyval.c                      |  57 ++++++---
 20 files changed, 747 insertions(+), 55 deletions(-)
 create mode 100644 tests/qapi-schema/doc-good.err
 create mode 100644 tests/qapi-schema/doc-good.exit
 create mode 100644 tests/qapi-schema/doc-good.json
 create mode 100644 tests/qapi-schema/doc-good.out
 create mode 100644 tests/qapi-schema/doc-good.texi

--=20
2.7.4
