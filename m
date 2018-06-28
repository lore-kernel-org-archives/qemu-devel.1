Received: from eggs.gnu.org ([2001:4830:134:3::10]:52463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4M-00074a-8i
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4J-0003bO-4O
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:46:54 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4J-0003al-00
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:46:51 -0400
Received: by mail-qt0-x243.google.com with SMTP id z6-v6so5326395qti.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:46:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 13:46:35 -0300
Message-Id: <20180628164643.9668-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] Docker improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

This is a set of various unrelated Docker patches, from my daily
docker-qemu usage.

Last RFC patches restore building for ppc32 hosts, which sometimes
triggers interesting 32-bit errors (atomic updates).

The other 32-bit host is the MXE MinGW32 port.

Regards,

Phil.

Philippe Mathieu-Daudé (8):
  docker: ubuntu: Update the package list before installing new ones
  docker: ubuntu: Use SDL2
  docker: Clean the MXE base image
  docker: Add packages required to build a Linux kernel
  docker: Restrict the 'travis' job to the Travis image
  docker: Do not run tests in 'intermediate' images
  docker: Cross build QEMU on ppc32 hosts
  .shippable.yml: Restore the powerpc-cross image

 .shippable.yml                                |  2 +
 tests/docker/Makefile.include                 | 16 +++++--
 tests/docker/dockerfiles/debian-apt-fake.sh   | 46 +++++++++++++++++++
 .../dockerfiles/debian-powerpc-cross.docker   | 43 +++++++++++++++++
 tests/docker/dockerfiles/debian-sid.docker    |  6 ++-
 tests/docker/dockerfiles/debian8-mxe.docker   |  2 +-
 tests/docker/dockerfiles/ubuntu.docker        |  8 ++--
 7 files changed, 114 insertions(+), 9 deletions(-)
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh

-- 
2.18.0
