Received: from eggs.gnu.org ([2001:4830:134:3::10]:56856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gSQNg-0005fU-D5
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gSQNc-0004Rz-8s
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:45:40 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gSQNc-0004QQ-06
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:45:36 -0500
Received: by mail-wr1-x442.google.com with SMTP id u3so2775266wrs.3
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:45:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 18:45:29 +0100
Message-Id: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a TAP
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, eblake@redhat.com, berrange@redhat.com

gtester is deprecated by upstream glib and it does not support tests
that call g_test_skip in some glib stable releases.

glib suggests instead using Automake's TAP support.  We do not support
Automake, but we can copy the code that beautifies the TAP output and
use it.  I chose to use the Perl copy rather than the shell/awk one,
in order to reuse Perl's TAP parsing package, but I'm open to suggestions
about which language to use.

Thanks,

Paolo

Paolo Bonzini (2):
  test: execute g_test_run when tests are skipped
  test: replace gtester with a TAP driver

 scripts/gtester-cat                          |  26 --
 scripts/tap-driver.pl                        | 386 +++++++++++++++++++++++++++
 scripts/tap-merge.pl                         | 108 ++++++++
 tests/Makefile.include                       |  54 ++--
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
 14 files changed, 540 insertions(+), 52 deletions(-)
 delete mode 100755 scripts/gtester-cat
 create mode 100755 scripts/tap-driver.pl
 create mode 100755 scripts/tap-merge.pl

-- 
1.8.3.1
