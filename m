Received: from eggs.gnu.org ([2001:4830:134:3::10]:44923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVCUm-0000GO-Ho
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVCUj-0008Vr-Be
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVCUi-0008UP-Do
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:55:36 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 12 Jul 2017 15:55:26 +0800
Message-Id: <20170712075528.22770-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Two small improvements for docker.py
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

The first one is a small simplification, the second one is an error handling
improvement.

Fam Zheng (2):
  docker.py: Drop infile parameter
  docker.py: Improve subprocess exit code handling

 tests/docker/docker.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.9.4
