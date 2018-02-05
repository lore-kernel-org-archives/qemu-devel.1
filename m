Received: from eggs.gnu.org ([2001:4830:134:3::10]:59199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipso-0001Rq-Ub
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsl-0006Mc-Lg
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipsl-0006KO-G5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:03 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:39 -0200
Message-Id: <20180205230900.11344-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] Python queue, 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8=
fe:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-requ=
est' into staging (2018-02-02 18:54:11 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to 356dc290f0ef930a24b6af3a0908b1cb58ad47c9:

  docker: change Fedora images to run with python3 (2018-02-05 19:53:55 -=
0200)

----------------------------------------------------------------
Python queue, 2018-02-05

----------------------------------------------------------------

Amador Pahim (7):
  qemu.py: remove unused import
  qemu.py: better control of created files
  qemu.py: refactor launch()
  qemu.py: always cleanup on shutdown()
  qemu.py: use poll() instead of 'returncode'
  qemu.py: cleanup redundant calls in launch()
  qemu.py: don't launch again before shutdown()

Daniel P. Berrange (13):
  qapi: convert to use python print function instead of statement
  qapi: use items()/values() intead of iteritems()/itervalues()
  qapi: Use OrderedDict from standard library if available
  qapi: adapt to moved location of StringIO module in py3
  qapi: Adapt to moved location of 'maketrans' function in py3
  qapi: remove '-q' arg to diff when comparing QAPI output
  qapi: ensure stable sort ordering when checking QAPI entities
  qapi: force a UTF-8 locale for running Python
  scripts: ensure signrom treats data as bytes
  configure: allow use of python 3
  ui: update keycodemapdb to get py3 fixes
  travis: improve python version test coverage
  docker: change Fedora images to run with python3

Miika S (1):
  input: add missing JIS keys to virtio input

 configure                              |  5 +-
 Makefile                               | 22 ++++----
 qapi/ui.json                           |  5 +-
 scripts/qapi.py                        | 43 ++++++++++------
 scripts/qapi2texi.py                   | 11 ++--
 scripts/qemu.py                        | 94 ++++++++++++++++++++++------=
------
 scripts/signrom.py                     |  4 +-
 .travis.yml                            | 14 +++--
 tests/Makefile.include                 |  6 +--
 tests/docker/dockerfiles/fedora.docker |  3 +-
 tests/qapi-schema/test-qapi.py         | 43 ++++++++--------
 ui/keycodemapdb                        |  2 +-
 12 files changed, 151 insertions(+), 101 deletions(-)

--=20
2.14.3
