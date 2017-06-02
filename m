Received: from eggs.gnu.org ([2001:4830:134:3::10]:39954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkv-0001yV-RK
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrku-0006Fk-L8
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:05 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:36361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrku-0006FF-GV
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:04 -0400
Received: by mail-oi0-x22e.google.com with SMTP id h4so102672648oib.3
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:57:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:11 -0300
Message-Id: <20170602185630.5059-6-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 05/24] docker: install ca-certificates
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
