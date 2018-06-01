Received: from eggs.gnu.org ([2001:4830:134:3::10]:47064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOdYp-00065K-UW
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 02:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOdYp-0004z3-2N
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 02:29:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  1 Jun 2018 14:28:39 +0800
Message-Id: <20180601062849.28641-2-famz@redhat.com>
In-Reply-To: <20180601062849.28641-1-famz@redhat.com>
References: <20180601062849.28641-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v8 01/11] docker: Update fedora image to 28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
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
