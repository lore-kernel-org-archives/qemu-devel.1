Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e84Sw-0003TN-Ql
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e84Sr-0006KJ-NS
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e84Sr-0006Gq-1G
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:14:21 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 27 Oct 2017 14:14:08 +0100
Message-Id: <20171027131412.18830-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] Various improvements to submodule
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

I've sent a variety of improvements to submodule handling as separate patches
and its getting slightly confusing. So here is a series with all patches added
together. I've also included a fix that helps us go backwards in time across
the introduction of a submodule.

Daniel P. Berrange (4):
  build: allow setting a custom GIT binary for transparent proxying
  build: don't create temporary files in source dir
  build: allow automatic git submodule updates to be disabled
  build: don't fail if given a git submodule which does not exist

 Makefile                 | 15 ++++++++++--
 configure                | 14 +++++++++++-
 scripts/git-submodule.sh | 59 ++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 76 insertions(+), 12 deletions(-)

-- 
2.13.6
