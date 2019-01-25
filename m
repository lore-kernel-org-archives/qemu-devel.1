Received: from eggs.gnu.org ([209.51.188.92]:53785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn27w-0008LS-90
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn27s-0003bY-TD
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gn27o-0003UE-U0
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:31 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 25 Jan 2019 12:06:08 -0200
Message-Id: <20190125140610.7810-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Python 3 compatibility fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

The following changes since commit 9dd0d8111fbb8015db75a38933aee1d45f9e64=
a3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-01-24'=
 into staging (2019-01-25 11:52:12 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to 651514df88fd53d537b3b78a7548663cc0816b1b:

  decodetree: re.fullmatch was added in 3.4 (2019-01-25 11:41:42 -0200)

----------------------------------------------------------------
Python 3 compatibility fixes

----------------------------------------------------------------

Nisarg Shah (1):
  device-crash-test: Python 3 compatibility fix

Paolo Bonzini (1):
  decodetree: re.fullmatch was added in 3.4

 scripts/decodetree.py     | 2 +-
 scripts/device-crash-test | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
