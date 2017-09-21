Received: from eggs.gnu.org ([2001:4830:134:3::10]:39139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dv4rn-0004fg-Bm
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dv4rh-0001S5-H3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dv4rh-0001Qt-BS
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:02:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 21 Sep 2017 14:02:09 -0300
Message-Id: <20170921170209.9101-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Fix subsystem name for "Build and
 test automation"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The subsystem name for the "Build test automation" section is
"-------------------------", because an actual subsystem name
line is missing:

  $ ./scripts/get_maintainer.pl -f tests/docker/docker.py
  "Alex Benn=C3=A9e" <alex.bennee@linaro.org> (maintainer:---------------=
--...)
  Fam Zheng <famz@redhat.com> (maintainer:-----------------...)
  "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (reviewer:-------------=
----...)
  qemu-devel@nongnu.org (open list:-----------------...)

Fix the issue by inserting a subsystem name line where
get_maintainer.pl expects it.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e511ba780f..13c1ac65b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1896,6 +1896,7 @@ F: docs/block-replication.txt
=20
 Build and test automation
 -------------------------
+Build and test automation
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 M: Fam Zheng <famz@redhat.com>
 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
--=20
2.13.5
