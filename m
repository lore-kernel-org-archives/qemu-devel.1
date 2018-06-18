Received: from eggs.gnu.org ([2001:4830:134:3::10]:52449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUtsM-0005yF-Ns
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUtsL-0002fM-G1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:18 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:51656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fUtsL-0002er-8D
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:17 -0400
Received: by mail-wm0-x244.google.com with SMTP id r15-v6so13954626wmc.1
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 06:07:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 18 Jun 2018 14:07:06 +0100
Message-Id: <20180618130709.19730-6-alex.bennee@linaro.org>
In-Reply-To: <20180618130709.19730-1-alex.bennee@linaro.org>
References: <20180618130709.19730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 5/8] docker: docker.py use "ps" to probe
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The "images" command is a fairly heavyweight command to run as it
involves searching the whole docker file-system inventory. On a
machine with a lot of images this makes start-up fairly expensive.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index c83fd89985..3072bf4a31 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -49,7 +49,7 @@ def _guess_docker_command():
     commands = [["docker"], ["sudo", "-n", "docker"]]
     for cmd in commands:
         try:
-            if subprocess.call(cmd + ["images"],
+            if subprocess.call(cmd + ["ps"],
                                stdout=DEVNULL, stderr=DEVNULL) == 0:
                 return cmd
         except OSError:
-- 
2.17.1
