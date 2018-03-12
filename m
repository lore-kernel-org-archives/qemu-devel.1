Received: from eggs.gnu.org ([2001:4830:134:3::10]:56648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evVfQ-0000XN-Et
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evVfM-00028i-9j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evVfM-00028T-2l
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 19:11:28 -0300
Message-Id: <20180312221132.14141-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Python queue, 2018-03-12
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

The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b669=
6e:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-r=
equest' into staging (2018-03-12 16:14:37 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to 006cc558359d23f070c84d6db324bbb9b54962d7:

  device-crash-test: Use 'python' binary (2018-03-12 19:10:16 -0300)

----------------------------------------------------------------
Python queue, 2018-03-12

----------------------------------------------------------------

Eduardo Habkost (4):
  device-crash-test: New known crashes
  qemu.py: Use items() instead of iteritems()
  qmp.py: Encode json data before sending
  device-crash-test: Use 'python' binary

 scripts/qemu.py           | 2 +-
 scripts/qmp/qmp.py        | 2 +-
 scripts/device-crash-test | 6 +++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

--=20
2.14.3
