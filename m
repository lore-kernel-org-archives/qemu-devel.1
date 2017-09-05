Received: from eggs.gnu.org ([2001:4830:134:3::10]:45603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpAAY-00073d-MN
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpAAU-00079e-0x
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpAAT-00079F-Rd
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:13 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:29:08 +0100
Message-Id: <20170905092910.8946-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 0/2] Merge QEMU crypto 2017/09/05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit 32f0f68bb77289b75a82925f712bb52e16eac3=
ba:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pul=
l-request' into staging (2017-09-01 17:28:54 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qcrypto-20170905-1

for you to fetch changes up to 23c1595b0297e6ca8f37559af6f0b8533aa1fd99:

  crypto: fix test cert generation to not use SHA1 algorithm (2017-09-04 =
10:45:19 +0100)

----------------------------------------------------------------
Merge QEMU crypto 2017/09/05 v1

----------------------------------------------------------------

Daniel P. Berrange (1):
  crypto: fix test cert generation to not use SHA1 algorithm

Philippe Mathieu-Daud=C3=A9 (1):
  tests: fix incorrect size_t format in benchmark-crypto

 tests/benchmark-crypto-cipher.c | 4 ++--
 tests/benchmark-crypto-hash.c   | 4 ++--
 tests/benchmark-crypto-hmac.c   | 4 ++--
 tests/crypto-tls-x509-helpers.c | 3 ++-
 4 files changed, 8 insertions(+), 7 deletions(-)

--=20
2.13.5
