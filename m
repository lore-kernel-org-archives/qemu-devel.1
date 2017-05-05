Received: from eggs.gnu.org ([2001:4830:134:3::10]:59660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6TqU-0007NQ-99
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6TqR-0007ob-69
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d6TqR-0007ny-0L
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:51 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  5 May 2017 11:23:35 +0800
Message-Id: <20170505032340.26467-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A few tweaks to the docker images and running commands allow us to run
qemu-iotests in the fedora container. This will be added to the patchew test
cases later.

Fam Zheng (5):
  docker: Run tests with current user
  docker: Add bzip2 and hostname to fedora image
  docker: Use unconfined security profile
  docker: Add libaio to fedora image
  docker: Add test-block

 tests/docker/Makefile.include          |  3 ++-
 tests/docker/dockerfiles/fedora.docker |  4 ++--
 tests/docker/test-block                | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)
 create mode 100755 tests/docker/test-block

-- 
2.9.3
