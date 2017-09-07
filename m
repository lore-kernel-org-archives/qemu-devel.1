Received: from eggs.gnu.org ([2001:4830:134:3::10]:49319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpxYA-0007N7-Pg
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpxY6-00025D-6b
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:12:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpxY5-00024Y-Vl
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:12:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 22:12:43 +0800
Message-Id: <20170907141245.31946-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] docker: Update ubuntu and test-full for
 more coverage
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

v2: Exit if cd failed. [Eric]

Fam Zheng (2):
  docker: Update ubuntu image
  docker: Enable features explicitly in test-full

 tests/docker/dockerfiles/ubuntu.docker | 11 +++--
 tests/docker/test-full                 | 82 +++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 9 deletions(-)

-- 
2.13.5
