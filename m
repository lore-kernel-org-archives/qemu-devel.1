Received: from eggs.gnu.org ([2001:4830:134:3::10]:35938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OW-0003Mz-EK
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gA1OS-0000mR-T0
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gA1OR-0000j2-J5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 19:26:24 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Tue,  9 Oct 2018 19:26:00 -0400
Message-Id: <20181009232607.15521-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/7] Acceptance Tests: basic architecture
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

The current version of the Acceptance Tests have been basically tested
on x86_64.  Most of them should be valid tests on many different
architectures.

This introduces another standard test parameter, 'arch', and a public
test attribute with the same name.  Then, because of the different
behavior in different QEMU targets, it adds a more explicit
configuration of the QEMUMachine machine type used on the tests (the
self.vm attribute).

Finally, for tests that are known to be architecture specific, it
changes the approach, from using tags to canceling the test.  The
difference is that this reuses the same 'arch' parameter (so no need
to pass tags for the same reason), and instead of completely excluding
the test from the job, it just won't be executed on architectures that
are not supported.  More details about this on the last commit.

Changes from v1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Fixed typo in docstring (s/param/type) (Murilo)

 * Pretty print the "arch.json" variants file, in order to make
   editing easier and avoid hitting email line length limits (Eric,
   Philippe)

 * Distinguish between host and target arch when canceling tests
   (Philippe)

Cleber Rosa (7):
  Acceptance Tests: improve docstring on pick_default_qemu_bin()
  Acceptance Tests: introduce arch parameter and attribute
  scripts/qemu.py: add method and private attribute for arch
  scripts/qemu.py: set predefined machine type based on arch
  Acceptance Tests: set machine type
  Acceptance Tests: add variants definition for architectures
  Acceptance Tests: change the handling of tests for specific archs

 docs/devel/testing.rst                    | 18 +++++
 scripts/qemu.py                           | 29 ++++++-
 tests/acceptance/avocado_qemu/__init__.py | 17 ++++-
 tests/acceptance/boot_linux_console.py    |  6 +-
 tests/acceptance/variants/arch.json       | 92 +++++++++++++++++++++++
 tests/acceptance/version.py               |  2 +
 tests/acceptance/vnc.py                   |  5 ++
 7 files changed, 163 insertions(+), 6 deletions(-)
 create mode 100644 tests/acceptance/variants/arch.json

--=20
2.17.1
