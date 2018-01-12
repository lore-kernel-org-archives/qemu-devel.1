Received: from eggs.gnu.org ([2001:4830:134:3::10]:35223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxFZ-0006LN-WD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxFW-00040n-Op
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:11:53 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:40058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxFW-0003zc-IQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:11:50 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v123so1888047wmd.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:11:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:11:43 +0100
Message-Id: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: change Fedora base image to fedora:27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Using "fedora:latest" makes behavior different depending on when you
actually pulled the image from the docker repository.  In my case,
the supposedly "latest" image was a Fedora 25 download from 8 months
ago, and the new "test-debug" test was failing.

Use "27" to improve reproducibility and make it clear when the image
is obsolete.

Cc: Fam Zheng <famz@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 32de731..714adad 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:latest
+FROM fedora:27
 ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostname \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
-- 
1.8.3.1
