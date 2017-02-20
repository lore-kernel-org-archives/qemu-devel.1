Received: from eggs.gnu.org ([2001:4830:134:3::10]:53384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cflZD-0006iE-Hl
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cflZC-0006Lp-9E
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:39 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cflZC-0006LI-3n
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:38 -0500
Received: by mail-wr0-x236.google.com with SMTP id 35so21321085wrw.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 02:51:37 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 20 Feb 2017 10:51:39 +0000
Message-Id: <20170220105139.21581-5-alex.bennee@linaro.org>
In-Reply-To: <20170220105139.21581-1-alex.bennee@linaro.org>
References: <20170220105139.21581-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 4/4] MAINTAINERS: merge Build and test
 automation with Docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The docker framework is really just another piece in the build
automation puzzle so lets merge it together. For added bonus I've also
included the Travis and Patchew status links. The Shippable links will
be added later once mainline tests have been configured and setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v4
  - fix merge fail (.shippable.yml)
---
 MAINTAINERS | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcbebf072..d3782691dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1801,10 +1801,14 @@ F: docs/block-replication.txt
 Build and test automation
 -------------------------
 M: Alex Bennée <alex.bennee@linaro.org>
+M: Fam Zheng <famz@redhat.com>
 L: qemu-devel@nongnu.org
-S: Supported
+S: Maintained
 F: .travis.yml
 F: .shippable.yml
+F: tests/docker/
+W: https://travis-ci.org/qemu/qemu
+W: http://patchew.org/QEMU/
 
 Documentation
 -------------
@@ -1813,9 +1817,3 @@ M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: docs/build-system.txt
 
-Docker testing
---------------
-Docker based testing framework and cases
-M: Fam Zheng <famz@redhat.com>
-S: Maintained
-F: tests/docker/
-- 
2.11.0
