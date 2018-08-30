Received: from eggs.gnu.org ([2001:4830:134:3::10]:58554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPKs-0000tL-HL
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPKp-0002NB-AO
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvPKp-0002N1-5a
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 17:58:06 +0200
Message-Id: <20180830155810.17629-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/4] tests: add a few QMP-related tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The test patches from "[PATCH v4 00/10] monitor: various code
simplification and fixes" series.

v5:
- add "tests: add qmp_assert_error_class()" patch
- commit message tweaks, TODO

Marc-Andr=C3=A9 Lureau (4):
  tests: add qmp_assert_error_class()
  tests: add qmp/object-add-without-props test
  tests: add qmp/qom-set-without-value test
  tests: add a qmp success-response test

 tests/libqtest.h                        |  9 +++
 tests/drive_del-test.c                  |  5 +-
 tests/libqtest.c                        | 11 ++++
 tests/qmp-cmd-test.c                    | 18 +++++
 tests/qmp-test.c                        | 87 +++++++++++--------------
 tests/test-qga.c                        |  9 +--
 tests/test-qmp-cmds.c                   | 17 +++++
 tests/qapi-schema/qapi-schema-test.json |  2 +
 tests/qapi-schema/qapi-schema-test.out  |  2 +
 9 files changed, 99 insertions(+), 61 deletions(-)

--=20
2.19.0.rc0.48.gb9dfa238d5
