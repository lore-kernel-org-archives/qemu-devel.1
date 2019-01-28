Received: from eggs.gnu.org ([209.51.188.92]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1goBEL-0003Zq-G0
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1goB6g-0004ps-Cd
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:54:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1goB6e-0004Zt-Fh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:54:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D011D4E90B
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:47:34 +0000 (UTC)
From: Caio Carrara <ccarrara@redhat.com>
Date: Mon, 28 Jan 2019 15:47:23 -0200
Message-Id: <20190128174725.8809-1-ccarrara@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] Acceptance tests: adds multi vm
 capability and basic migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wainersm@redhat.com, ehabkost@redhat.com, philmd@redhat.com, crosa@redhat.com, Caio Carrara <ccarrara@redhat.com>

This is the second attempt to add the multi vm capability to base class
of acceptance tests. The difference from first version is that in this
current version a simple migration test was added (done by Cleber) so
the new code that is being added is properly used and we're not adding
"new dead code".

There are more tests and test cases that can be added, but I'm assuming
this patch is complete enough and other series can be sent after
covering the other cases.

Caio Carrara (1):
  tests.acceptance: adds multi vm capability for acceptance tests

Cleber Rosa (1):
  Acceptance tests: add simple migration test

 docs/devel/testing.rst                    | 40 +++++++++++++++++++-
 tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++++--
 tests/acceptance/migration.py             | 45 +++++++++++++++++++++++
 3 files changed, 105 insertions(+), 5 deletions(-)
 create mode 100644 tests/acceptance/migration.py

--=20
2.20.1
