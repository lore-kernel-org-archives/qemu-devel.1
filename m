Received: from eggs.gnu.org ([2001:4830:134:3::10]:58713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpSb-0006rV-5C
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpSW-0003zl-8l
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkpSW-0003zZ-2J
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:33:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1310C04B94B
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 10:33:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Aug 2017 12:33:36 +0200
Message-Id: <20170824103350.16400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/14] Generate a literal qobject for
 introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series is based on patches 2-5 from "[PATCH v2 00/54] qapi: add #if
pre-processor conditions to generated code". Generating a literal qobject
will allow to easily introduce #if conditionals from the original series.

Marc-Andr=C3=A9 Lureau (14):
  qdict: add qdict_put_null() helper
  qlit: move qlit from check-qjson to qobject/
  qlit: use QLit prefix consistently
  qlit: remove needless type cast
  qlit: rename compare_litqobj_to_qobj
  qlit: make qlit_equal_qobject return a bool
  qlit: make qlit_equal_qobject() take const arguments
  qlit: add QLIT_QNULL and QLIT_BOOL
  qlit: replace assert(qnum_get_try_int)
  tests: add qlit tests
  qlit: improve QLit dict vs qdict comparison
  qlit: improve QLit list vs qlist comparison
  qlit: add qobject_form_qlit()
  qapi: generate a literal qobject for introspection

 scripts/qapi-introspect.py         |  87 +++++++++++---------
 include/qapi/qmp/qdict.h           |   4 +-
 include/qapi/qmp/qlit.h            |  56 +++++++++++++
 monitor.c                          |   2 +-
 qobject/qlit.c                     | 157 +++++++++++++++++++++++++++++++=
++++++
 target/i386/cpu.c                  |   4 +-
 tests/check-qjson.c                | 150 +++++++------------------------=
----
 tests/check-qlit.c                 | 100 +++++++++++++++++++++++
 tests/test-qobject-input-visitor.c |  11 ++-
 docs/devel/qapi-code-gen.txt       |  29 ++++---
 qobject/Makefile.objs              |   2 +-
 tests/Makefile.include             |   5 +-
 12 files changed, 429 insertions(+), 178 deletions(-)
 create mode 100644 include/qapi/qmp/qlit.h
 create mode 100644 qobject/qlit.c
 create mode 100644 tests/check-qlit.c

--=20
2.14.1.146.gd35faa819
