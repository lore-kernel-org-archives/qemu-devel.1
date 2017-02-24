Received: from eggs.gnu.org ([2001:4830:134:3::10]:44323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QU-0008Kb-3f
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QR-0000Fq-0n
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ch9QQ-0000Fl-RQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:18 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Feb 2017 14:32:04 +0800
Message-Id: <20170224063205.2537-5-famz@redhat.com>
In-Reply-To: <20170224063205.2537-1-famz@redhat.com>
References: <20170224063205.2537-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] MAINTAINERS: merge Build and test
 automation with Docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

The docker framework is really just another piece in the build
automation puzzle so lets merge it together. For added bonus I've also
included the Travis and Patchew status links. The Shippable links will
be added later once mainline tests have been configured and setup.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170220105139.21581-5-alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6740467..be79f68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1800,10 +1800,14 @@ F: docs/block-replication.txt
 Build and test automation
 -------------------------
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
+M: Fam Zheng <famz@redhat.com>
 L: qemu-devel@nongnu.org
-S: Supported
+S: Maintained
 F: .travis.yml
 F: .shippable.yml
+F: tests/docker/
+W: https://travis-ci.org/qemu/qemu
+W: http://patchew.org/QEMU/
=20
 Documentation
 -------------
@@ -1812,9 +1816,3 @@ M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: docs/build-system.txt
=20
-Docker testing
---------------
-Docker based testing framework and cases
-M: Fam Zheng <famz@redhat.com>
-S: Maintained
-F: tests/docker/
--=20
2.9.3
