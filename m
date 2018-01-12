Received: from eggs.gnu.org ([2001:4830:134:3::10]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZymp-0005Iy-5x
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZymn-0007Mb-Ug
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:19 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:46715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZymn-0007M1-Om
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:17 -0500
Received: by mail-qk0-x244.google.com with SMTP id l64so8413078qke.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:50:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 Jan 2018 09:49:57 -0300
Message-Id: <20180112125000.27256-5-f4bug@amsat.org>
In-Reply-To: <20180112125000.27256-1-f4bug@amsat.org>
References: <20180112125000.27256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/7] docker: do not use Trusty APT source in
 Xenial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

probably missed in 7fc581c29518

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/ubuntu.docker | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index dabbf2a8a4..686d90ae8c 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -1,6 +1,4 @@
 FROM ubuntu:16.04
-RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> \
-    /etc/apt/sources.list
 RUN apt-get update
 ENV PACKAGES flex bison \
     libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
-- 
2.15.1
