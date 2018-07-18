Received: from eggs.gnu.org ([2001:4830:134:3::10]:49513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fflBD-0007bm-Lg
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fflBA-00035l-Hs
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fflBA-00035f-Cs
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0E3F81A4EB7
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 12:03:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 18 Jul 2018 13:03:31 +0100
Message-Id: <20180718120334.27138-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] crypto: increase min required gnutls,
 gcrypt and nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since adopting a formal policy around supported build hosts, and
increasing the minimum required glib version, it is now possible to also
increase the min required versions for gnutls, gcrypt and nettle
libraries. This allows simplification of a bunch of conditional logic.

Daniel P. Berrang=C3=A9 (3):
  crypto: require gnutls >=3D 3.1.18 for building QEMU
  crypto: require libgcrypt >=3D 1.5.0 for building QEMU
  crypto: require nettle >=3D 1.5.0 for building QEMU

 configure                        | 161 ++++++++-----------------------
 crypto/Makefile.objs             |   8 +-
 crypto/init.c                    |  23 +----
 crypto/tlscredsx509.c            |  21 ----
 crypto/tlssession.c              |   8 +-
 tests/Makefile.include           |   2 +-
 tests/crypto-tls-x509-helpers.h  |   3 +-
 tests/test-crypto-block.c        |   2 +-
 tests/test-crypto-tlscredsx509.c |   8 +-
 9 files changed, 51 insertions(+), 185 deletions(-)

--=20
2.17.1
