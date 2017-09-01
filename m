Received: from eggs.gnu.org ([2001:4830:134:3::10]:46673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnnlv-0001Py-9K
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnnll-0002zw-Rn
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:22:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnnll-0002ze-LP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:22:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  1 Sep 2017 23:21:57 +0800
Message-Id: <20170901152200.5953-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kchamart@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, eblake@redhat.com

A few tweaks to the docker images and running commands allow us to run
qemu-iotests in the fedora container. This will be added to the patchew test
cases later.

v3: Add nbd, luks and limit to quick group.

v2: Add nettle-devel because a few iotest cases blindly assumes the support is
there.

Fam Zheng (3):
  docker: Use unconfined security profile
  docker: Add nettle-devel to fedora image
  docker: Add test-block

 tests/docker/Makefile.include          |  1 +
 tests/docker/dockerfiles/fedora.docker |  1 +
 tests/docker/test-block                | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100755 tests/docker/test-block

-- 
2.13.5
