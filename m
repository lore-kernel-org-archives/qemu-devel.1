Received: from eggs.gnu.org ([2001:4830:134:3::10]:34099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f4RSG-0006Jj-Kv
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f4RSB-00036K-2d
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:31:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f4RSA-00035o-TR
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:30:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9A23406E8A4
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 13:30:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  6 Apr 2018 14:30:43 +0100
Message-Id: <20180406133046.5682-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.12 0/3] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca6=
2d:

  Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qcrypto-next-pull-request

for you to fetch changes up to 057ad0b46992e3ec4ce29b9103162aa3c683f347:

  crypto: ensure we use a predictable TLS priority setting (2018-04-06 11=
:28:31 +0100)

----------------------------------------------------------------

Two improvements to TLS docs, and a fix for the test suite to
avoid breakage on Fedora >=3D 28

----------------------------------------------------------------

Christophe Fergeau (1):
  docs: Document -object tls-creds-x509 priority=3Dxxx

Daniel P. Berrang=C3=A9 (2):
  docs: update information for TLS certificate management
  crypto: ensure we use a predictable TLS priority setting

 qemu-doc.texi                  | 364 ++++++++++++++++++++++++++++++-----=
------
 qemu-options.hx                |  11 +-
 tests/test-crypto-tlssession.c |   1 +
 tests/test-io-channel-tls.c    |   1 +
 4 files changed, 284 insertions(+), 93 deletions(-)

--=20
2.14.3
