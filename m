Received: from eggs.gnu.org ([2001:4830:134:3::10]:36427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV1XY-0005xK-HE
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV1XU-00052T-KN
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:50:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV1XS-0004yD-Hg
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:50:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7D34300170C
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 21:50:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Dec 2018 22:50:24 +0100
Message-Id: <20181206215026.7716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v2 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, eblake@redhat.com, thuth@redhat.com

gtester is deprecated by upstream glib[1] and it does not support tests
that call g_test_skip in some glib stable releases.

glib suggests instead using Automake's TAP support.  We do not support
Automake, but we can copy the code that beautifies the TAP output and
use it.  I chose to use the Perl copy rather than the shell/awk one
in order to reuse Perl's TAP parsing package.

Thanks,

Paolo

[1] https://blog.gtk.org/2018/07/11/news-from-glib-2-58/

Paolo Bonzini (2):
  test: execute g_test_run when tests are skipped
  test: replace gtester with a TAP driver

 scripts/gtester-cat                          |  26 --
 scripts/tap-driver.pl                        | 377 +++++++++++++++++++
 scripts/tap-merge.pl                         | 110 ++++++
 tests/Makefile.include                       |  54 +--
 tests/cdrom-test.c                           |   2 +-
 tests/docker/dockerfiles/centos7.docker      |   1 +
 tests/docker/dockerfiles/debian-amd64.docker |   1 +
 tests/docker/dockerfiles/debian-ports.docker |   1 +
 tests/docker/dockerfiles/debian-sid.docker   |   1 +
 tests/docker/dockerfiles/debian8.docker      |   1 +
 tests/docker/dockerfiles/debian9.docker      |   1 +
 tests/docker/dockerfiles/fedora.docker       |   1 +
 tests/docker/dockerfiles/ubuntu.docker       |   1 +
 tests/migration-test.c                       |   8 +-
 14 files changed, 533 insertions(+), 52 deletions(-)
 delete mode 100755 scripts/gtester-cat
 create mode 100755 scripts/tap-driver.pl
 create mode 100755 scripts/tap-merge.pl

--=20
2.19.2
