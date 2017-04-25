Received: from eggs.gnu.org ([2001:4830:134:3::10]:44379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2uKW-0003vK-Oj
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2uKT-0006Fh-OX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:08 -0400
Received: from 4.mo7.mail-out.ovh.net ([178.32.122.254]:58652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d2uKT-0006Et-Hk
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:05 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 25F744DAC8
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:52:04 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 25 Apr 2017 08:51:40 +0200
Message-Id: <1493103101-25165-2-git-send-email-clg@kaod.org>
In-Reply-To: <1493103101-25165-1-git-send-email-clg@kaod.org>
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] tests: add IPMI tests for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 579ec07cce03..8ff22ccfbdde 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -287,6 +287,8 @@ check-qtest-ppc64-y +=3D tests/pnv-xscom-test$(EXESUF=
)
 check-qtest-ppc64-y +=3D tests/drive_del-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/postcopy-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/boot-serial-test$(EXESUF)
+check-qtest-ppc64-y +=3D tests/ipmi-kcs-test$(EXESUF)
+check-qtest-ppc64-y +=3D tests/ipmi-bt-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/rtas-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/pxe-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/usb-hcd-ohci-test$(EXESUF)
--=20
2.7.4
