Received: from eggs.gnu.org ([2001:4830:134:3::10]:50339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffiuc-0003UC-N7
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffiuY-0001BF-RD
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffiuY-0001Ax-MW
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:38:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A53E1401EF11
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 09:38:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 18 Jul 2018 10:38:11 +0100
Message-Id: <20180718093815.8104-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for 3.0 0/4] Multiple fixes and improvements to
 TLS tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The switch to enable TLS 1.3 protocol support in GNUTLS in Fedora
exposed a subtle flaw in our TLS unit tests. This was horrible to debug
because of bad error reporting in our tests which caused all the error
messages to be irretrievably lost instead of displayed on stderr.

Daniel P. Berrang=C3=A9 (4):
  tests: call qcrypto_init instead of gnutls_global_init
  tests: don't silence error reporting for all tests
  tests: use error_abort in places expecting errors
  tests: fix TLS handshake failure with TLS 1.3

 stubs/error-printf.c             |  5 +-
 tests/crypto-tls-x509-helpers.c  |  4 +-
 tests/test-crypto-tlscredsx509.c | 11 +----
 tests/test-crypto-tlssession.c   | 80 ++++++++++++--------------------
 tests/test-io-channel-tls.c      | 24 ++++------
 tests/test-vmstate.c             |  3 ++
 6 files changed, 51 insertions(+), 76 deletions(-)

--=20
2.17.1
