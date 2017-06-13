Received: from eggs.gnu.org ([2001:4830:134:3::10]:45413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqhX-0005HZ-PE
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqhQ-00005f-GN
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:38:00 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqhQ-00005R-C7
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:37:56 -0400
Received: by mail-qt0-x242.google.com with SMTP id s33so36829403qtg.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:37:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Jun 2017 15:37:37 -0300
Message-Id: <20170613183025.5145-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] Fix upstream error: redefinition of
 typedef 'LoadStateHandler'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>

Also included Fam's patch for bison/flex, not required but still silent few warnings.

patchew output:

    === OUTPUT BEGIN ===
    In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
    /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition of typedef ‘LoadStateHandler’
    /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous declaration of ‘LoadStateHandler’ was here
    make: *** [hw/net/vmxnet3.o] Error 1
    make: *** Waiting for unfinished jobs....
    tests/docker/Makefile.include:118: recipe for target 'docker-run' failed
    make[1]: *** [docker-run] Error 2
    make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-x6sxqrj2/src'
    tests/docker/Makefile.include:149: recipe for target 'docker-run-test-quick@centos6' failed
    make: *** [docker-run-test-quick@centos6] Error 2
    === OUTPUT END ===

Fam Zheng (1):
  docker: Add flex and bison to centos6 image

Philippe Mathieu-Daudé (1):
  migration: remove duplicate typedef

 include/migration/vmstate.h             | 2 +-
 tests/docker/dockerfiles/centos6.docker | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0
