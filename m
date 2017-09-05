Received: from eggs.gnu.org ([2001:4830:134:3::10]:50080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42O-0004sK-2G
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42J-0003HP-4L
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp42I-0003GQ-Ue
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:23 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 10:56:08 +0800
Message-Id: <20170905025614.579-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/6] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, kchamart@redhat.com, eblake@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Based-on: 20170905021201.25684-1-famz@redhat.com
([PATCH v6 00/12] tests: Add VM based build tests (for non-x86_64 and/or
non-Linux))

A few tweaks to the docker images and running commands allow us to run
qemu-iotests in the fedora container. This will be added to the patchew test
cases later.

v4: Don't use 'set -e'. [Eric]
    Add Kashyap's rev-by to unchanged patches.

v3: Add nbd, luks and limit to quick group.

v2: Add nettle-devel because a few iotest cases blindly assumes the support is
there.

Fam Zheng (6):
  docker: Fix return code of build_qemu()
  docker: Add test_fail and prep_fail
  docker: Use unconfined security profile
  docker: Add nettle-devel to fedora image
  docker: Add test-block
  docker: Drop 'set -e' from run script

 tests/docker/Makefile.include          |  1 +
 tests/docker/common.rc                 | 15 +++++++++++++--
 tests/docker/dockerfiles/fedora.docker |  1 +
 tests/docker/run                       |  8 +++-----
 tests/docker/test-block                | 22 ++++++++++++++++++++++
 5 files changed, 40 insertions(+), 7 deletions(-)
 create mode 100755 tests/docker/test-block

-- 
2.13.5
