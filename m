Received: from eggs.gnu.org ([2001:4830:134:3::10]:35901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpEPy-0008Of-HS
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpEPp-000313-BV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dpEPp-0002zt-6a
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:01:21 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Sep 2017 16:01:14 +0200
Message-Id: <20170905140116.28181-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] drop pixman submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

v2: also drop the pixman configure switches.

Gerd Hoffmann (2):
  pixman: drop submodule
  pixman: drop configure switches

 configure        | 44 ++++----------------------------------------
 Makefile         | 10 ----------
 ui/qemu-pixman.c |  4 ----
 .gitmodules      |  3 ---
 pixman           |  1 -
 5 files changed, 4 insertions(+), 58 deletions(-)
 delete mode 160000 pixman

-- 
2.9.3
