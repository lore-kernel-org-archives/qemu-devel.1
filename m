Received: from eggs.gnu.org ([2001:4830:134:3::10]:38394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gTpd9-0003Md-5n
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gTpd6-00051Y-1P
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:55:27 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gTpd5-00050O-QU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:55:23 -0500
Received: by mail-wr1-x442.google.com with SMTP id z5so12485555wrt.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:55:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 15:55:19 +0100
Message-Id: <1543848919-31931-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: centos7: upgrade to SDL2-devel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, fam@euphon.net

All CentOS 7 builds on Patchew are showing this warning:

   WARNING: Use of SDL 1.2 is deprecated and will be removed in
   WARNING: future releases. Please switch to using SDL 2.0

Update the packages so that the warning goes away and the more
interesting SDL2 code is compiled instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index e0f18f5..12a61fe 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -24,7 +24,7 @@ ENV PACKAGES \
     nettle-devel \
     perl-Test-Harness \
     pixman-devel \
-    SDL-devel \
+    SDL2-devel \
     spice-glib-devel \
     spice-server-devel \
     tar \
-- 
1.8.3.1
