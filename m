Received: from eggs.gnu.org ([2001:4830:134:3::10]:39437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDV3x-0008Uc-3A
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDV3p-0006yx-Aj
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDV3i-0006qy-JI
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:43:25 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 19 Oct 2018 14:43:15 +0100
Message-Id: <20181019134318.17155-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The following changes since commit 2ec24af2379e331d062a6fc1cda65bc262c7c1=
7b:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-october=
-2018-part1-v2' into staging (2018-10-19 10:08:31 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qcrypto-next-pull-request

for you to fetch changes up to 64dd2f3b5b090c21c3e82142de3fe7b4793ce6c8:

  crypto: require nettle >=3D 2.7.1 for building QEMU (2018-10-19 14:41:4=
7 +0100)

----------------------------------------------------------------
Update min required crypto library versions

The min required versions for crypto libraries are now

 - gnutls >=3D 3.1.18
 - nettle >=3D 2.7.1
 - libgcrypt >=3D 1.5.0

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (3):
  crypto: require gnutls >=3D 3.1.18 for building QEMU
  crypto: require libgcrypt >=3D 1.5.0 for building QEMU
  crypto: require nettle >=3D 2.7.1 for building QEMU

 configure                        | 161 ++++++++-----------------------
 tests/crypto-tls-x509-helpers.h  |   3 +-
 crypto/init.c                    |  23 +----
 crypto/tlscredsx509.c            |  21 ----
 crypto/tlssession.c              |   8 +-
 tests/test-crypto-block.c        |   2 +-
 tests/test-crypto-tlscredsx509.c |   8 +-
 crypto/Makefile.objs             |   8 +-
 tests/Makefile.include           |   2 +-
 9 files changed, 51 insertions(+), 185 deletions(-)

--=20
2.17.2
