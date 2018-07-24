Received: from eggs.gnu.org ([2001:4830:134:3::10]:59963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0Po-0001yn-7D
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0Pj-0003Gq-RO
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fi0Pj-0003GK-MU
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:43:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E436401EF02
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 16:43:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 24 Jul 2018 17:43:47 +0100
Message-Id: <20180724164351.7293-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3bae150448dbd888a480f892ebbf01caec0d83=
29:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-07-24 15:26:01 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qcrypto-next-pull-request

for you to fetch changes up to db0a8c70f25fe497c4b786d8edac063daa744c0d:

  tests: fix TLS handshake failure with TLS 1.3 (2018-07-24 17:36:12 +010=
0)

----------------------------------------------------------------
Fix unit test compatibility with TLS 1.3

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (4):
  tests: call qcrypto_init instead of gnutls_global_init
  tests: don't silence error reporting for all tests
  tests: use error_abort in places expecting errors
  tests: fix TLS handshake failure with TLS 1.3

 include/crypto/init.h            |  2 +
 stubs/error-printf.c             |  3 +-
 tests/crypto-tls-x509-helpers.c  |  3 +-
 tests/test-crypto-tlscredsx509.c | 11 +----
 tests/test-crypto-tlssession.c   | 80 ++++++++++++--------------------
 tests/test-io-channel-tls.c      | 24 ++++------
 tests/test-vmstate.c             |  2 +
 7 files changed, 49 insertions(+), 76 deletions(-)

--=20
2.17.1
