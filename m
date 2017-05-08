Received: from eggs.gnu.org ([2001:4830:134:3::10]:36549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qz3-0008P2-JP
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qz0-0006rX-EQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:25 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qz0-0006qa-Ab
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:22 -0400
Received: by mail-qt0-x241.google.com with SMTP id a46so11471910qte.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 15:18:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 19:17:42 -0300
Message-Id: <20170508221759.15616-5-f4bug@amsat.org>
In-Reply-To: <20170508221759.15616-1-f4bug@amsat.org>
References: <20170508221759.15616-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/21] docker: install ca-certificates
 package in base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Resolve SSL verification issue at shippable container's git_sync stage:

shippable logs:
--------------
git_sync
- ssh-agent bash -c 'ssh-add /tmp/ssh/01_deploy; git clone https://github.com/philmd/qemu.git /root/src/github.com/philmd/qemu'
Identity added: /tmp/ssh/01_deploy (rsa w/o comment)
Cloning into '/root/src/github.com/philmd/qemu'...
fatal: unable to access 'https://github.com/philmd/qemu.git/': Problem with the SSL CA cert (path? access rights?)
retrying 1 of 3 times...

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 52bd79938e..d08def6a8d 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -11,7 +11,7 @@ FROM debian:stable-slim
 
 # Setup some basic tools we need
 RUN apt update
-RUN apt install -yy curl aptitude
+RUN apt install -yy aptitude ca-certificates curl
 
 # Setup Emdebian
 RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
-- 
2.11.0
