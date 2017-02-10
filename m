Received: from eggs.gnu.org ([2001:4830:134:3::10]:50166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccE3m-0007l5-4M
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccE3l-0004Qq-Bc
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:28:34 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccE3l-0004QV-5J
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:28:33 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 16:28:22 +0000
Message-Id: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] qemu-img: fix coverity nits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Coverity points out a couple of nits in qemu-img:
 * misuse of strtoul()
 * variable set but not used

These patches fix the issues.

Peter Maydell (2):
  qemu-img: Use qemu_strtoul() rather than raw strtoul()
  qemu-img: Avoid setting ret to unused value in img_convert()

 qemu-img.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

-- 
2.7.4
