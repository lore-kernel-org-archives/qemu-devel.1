Received: from eggs.gnu.org ([2001:4830:134:3::10]:41454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fPjdz-0006W1-UR
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fPjdw-0003KJ-5V
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:11:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fPjdw-0003K2-1L
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:11:04 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  4 Jun 2018 15:10:50 +0800
Message-Id: <20180604071050.12492-3-famz@redhat.com>
In-Reply-To: <20180604071050.12492-1-famz@redhat.com>
References: <20180604071050.12492-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] docker: Update fedora image to 28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180601023557.9770-1-famz@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index b706f42405..65d7761cf5 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:27
+FROM fedora:28
 ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
     gcc gcc-c++ llvm clang make perl which bc findutils glib2-devel \
-- 
2.17.0
