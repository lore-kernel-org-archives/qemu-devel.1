Received: from eggs.gnu.org ([2001:4830:134:3::10]:47332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3YXC-0001VC-ME
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3YXB-0003eU-Vt
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3YXB-0003eK-RR
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:25 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  4 Apr 2018 10:51:58 +0800
Message-Id: <20180404025201.11921-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Add a CentOS test image to run docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Docker testing on patchew has long suffered from 'make check' hangings. The
cleanness of VM testing is the cure. Now let's add a CentOS 7 image to run the
tests.  It's purely ad-hoc, but hopefully still easy to understand and use for
everyone.

The first patch makes passing source code from host to the container in VM
working, and is a nice clean up.

The second patch makes caches work, to speed up repetitive runs like on
patchew.

The last patch adds the new image that does the job. Two out of three docker
tests running on patchew.org are added to the image. I'll wait for Peter to fix
the 'docker-test-quick@centos6' hanging (oob test) before adding it too.

Fam

Fam Zheng (3):
  archive-source.sh: Drop submodule code
  tests: Add an option for snapshot (default: off)
  tests: Add centos VM testing

 scripts/archive-source.sh | 47 +++------------------------
 tests/vm/basevm.py        |  7 +++-
 tests/vm/centos           | 82 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 44 deletions(-)
 create mode 100755 tests/vm/centos

-- 
2.14.3
