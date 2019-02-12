Received: from eggs.gnu.org ([209.51.188.92]:35346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gte57-0003zd-Mo
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gte0X-0005Xo-Fu
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:46:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1gte0W-0005VV-Tg
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:46:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A58D80F8D
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 19:39:00 +0000 (UTC)
From: Caio Carrara <ccarrara@redhat.com>
Date: Tue, 12 Feb 2019 17:38:53 -0200
Message-Id: <20190212193855.13223-1-ccarrara@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] tests.acceptance: adds multi vm
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
Cc: Caio Carrara <ccarrara@redhat.com>

This is the third attempt to add the multi vm capability to base class
of acceptance tests.

The difference from first version is that in this current version a
simple migration test was added (done by Cleber) so the new code that is
being added is properly used and we're not adding "new dead code".

The difference from the second version is that in this current version
the migration test being added was updated based on last reviews. It was
added more status to consider the migration as finished and also
assertions was added to check the migration success.

There are more tests and test cases that can be added, but I'm assuming
this patch is complete enough and other series can be sent after
covering the other cases.

Caio Carrara (2):
  tests.acceptance: adds multi vm capability for acceptance tests
  tests.acceptance: adds simple migration test

 docs/devel/testing.rst                    | 41 +++++++++++++++++-
 tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++--
 tests/acceptance/migration.py             | 53 +++++++++++++++++++++++
 3 files changed, 114 insertions(+), 5 deletions(-)
 create mode 100644 tests/acceptance/migration.py

--=20
2.20.1
