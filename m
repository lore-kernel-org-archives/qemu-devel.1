Received: from eggs.gnu.org ([2001:4830:134:3::10]:35399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85TL-0008Bq-He
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85TH-0008Be-Ih
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d85TH-0008BG-CI
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:46:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19BADC054915
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 13:46:34 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  9 May 2017 14:46:19 +0100
Message-Id: <20170509134623.13120-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 0/4] Merge qcrypto 2017/05/07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit dd1559bb267becbb838de41132ef60771d183e5d:

  Merge remote-tracking branch 'elmarco/tags/chr-tests-pull-request' into staging (2017-05-05 17:07:55 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qcrypto-2017-05-09-1

for you to fetch changes up to a37278169d0d7d33270c6817f4a2e4f7345e1098:

  crypto: qcrypto_random_bytes() now works on windows w/o any other crypto libs (2017-05-09 14:41:47 +0100)

----------------------------------------------------------------
Merge qcrypto 2017/05/09 v1

----------------------------------------------------------------

Daniel P. Berrange (3):
  Default to GSSAPI (Kerberos) instead of DIGEST-MD5 for SASL
  List SASL config file under the cryptography maintainer's realm
  crypto: move 'opaque' parameter to (nearly) the end of parameter list

Geert Martin Ijewski (1):
  crypto: qcrypto_random_bytes() now works on windows w/o any other
    crypto libs

 MAINTAINERS               |  1 +
 block/crypto.c            |  6 +++---
 crypto/block-luks.c       | 13 +++++++-----
 crypto/init.c             |  6 ++++++
 crypto/random-gcrypt.c    |  2 ++
 crypto/random-gnutls.c    |  3 +++
 crypto/random-platform.c  | 45 ++++++++++++++++++++++++++++++++-------
 include/crypto/block.h    |  6 +++---
 include/crypto/random.h   |  9 ++++++++
 qemu-doc.texi             | 50 +++++++++++++++++++++++++------------------
 qemu.sasl                 | 54 +++++++++++++++++++++++++++--------------------
 tests/test-crypto-block.c |  6 +++---
 12 files changed, 135 insertions(+), 66 deletions(-)

-- 
2.9.3
