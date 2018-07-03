Received: from eggs.gnu.org ([2001:4830:134:3::10]:40669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faK3b-0002ao-RX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faK3X-00079C-Qc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1faK3X-00078e-MP
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:05:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2877B3468F
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 12:05:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  3 Jul 2018 13:05:11 +0100
Message-Id: <20180703120512.31648-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] Qcrypto next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Jones <rjones@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The following changes since commit 9b75dcb15f562577a937ae01f324946513586e=
59:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-07-02' i=
nto staging (2018-07-03 10:47:02 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qcrypto-next-pull-request

for you to fetch changes up to e1a6dc91ddb55ef77a705b62b6e62634631fd57d:

  crypto: Implement TLS Pre-Shared Keys (PSK). (2018-07-03 13:04:38 +0100=
)

----------------------------------------------------------------
Add support for PSK credentials with TLS

----------------------------------------------------------------

Richard W.M. Jones (1):
  crypto: Implement TLS Pre-Shared Keys (PSK).

 crypto/Makefile.objs           |   1 +
 crypto/tlscredspsk.c           | 308 +++++++++++++++++++++++++++++++++
 crypto/tlssession.c            |  56 +++++-
 crypto/trace-events            |   3 +
 include/crypto/tlscredspsk.h   | 106 ++++++++++++
 qemu-doc.texi                  |  37 ++++
 qemu-options.hx                |  24 +++
 tests/Makefile.include         |   4 +-
 tests/crypto-tls-psk-helpers.c |  50 ++++++
 tests/crypto-tls-psk-helpers.h |  29 ++++
 tests/test-crypto-tlssession.c | 179 ++++++++++++++++---
 11 files changed, 774 insertions(+), 23 deletions(-)
 create mode 100644 crypto/tlscredspsk.c
 create mode 100644 include/crypto/tlscredspsk.h
 create mode 100644 tests/crypto-tls-psk-helpers.c
 create mode 100644 tests/crypto-tls-psk-helpers.h

--=20
2.17.1
