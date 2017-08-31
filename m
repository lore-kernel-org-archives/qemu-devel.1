Received: from eggs.gnu.org ([2001:4830:134:3::10]:54613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnNYE-0004kW-V8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnNYA-0006OA-0t
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnNY9-0006O2-RF
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:17 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 31 Aug 2017 19:22:07 +0800
Message-Id: <20170831112210.19921-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A few tweaks to the docker images and running commands allow us to run
qemu-iotests in the fedora container. This will be added to the patchew test
cases later.

v2: Add nettle-devel because a few iotest cases blindly assumes the support is
there.

Fam Zheng (3):
  docker: Use unconfined security profile
  docker: Add nettle-devel to fedora image
  docker: Add test-block

 tests/docker/Makefile.include          |  1 +
 tests/docker/dockerfiles/fedora.docker |  1 +
 tests/docker/test-block                | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100755 tests/docker/test-block

-- 
2.13.5
