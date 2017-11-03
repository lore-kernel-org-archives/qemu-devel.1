Received: from eggs.gnu.org ([2001:4830:134:3::10]:38115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdyY-0007w2-Uc
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdyV-0000z5-RO
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAdyV-0000yd-K2
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:33:39 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Nov 2017 15:33:28 +0000
Message-Id: <20171103153333.6416-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/5] Various improvements/bugfixes to
 submodule handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>

This short series of patches improves the reliability of the submodule
handling to cope with various dev env scenarios that have since emerged

  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg06272.html

Changed in v3:

 - Avoid use of mktemp
 - Use '=' instead of '==' (bashism) in conditional tests
 - Fix problem with short-circuiting for empty submodule list
 - Ensure help message is displayed on all errors

Daniel P. Berrange (5):
  build: allow setting a custom GIT binary for transparent proxying
  build: don't create temporary files in source dir
  build: allow automatic git submodule updates to be disabled
  build: don't fail if given a git submodule which does not exist
  build: delay check for empty git submodule list

 Makefile                 | 15 ++++++++--
 configure                | 12 ++++++++
 scripts/git-submodule.sh | 72 ++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 16 deletions(-)

-- 
2.13.6
