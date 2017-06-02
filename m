Received: from eggs.gnu.org ([2001:4830:134:3::10]:39887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkp-0001uB-5D
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrko-0006Cd-D4
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:56:59 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:36307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrko-0006CM-8P
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:56:58 -0400
Received: by mail-oi0-x234.google.com with SMTP id h4so102669670oib.3
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:56:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:07 -0300
Message-Id: <20170602185630.5059-2-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/24] docker: let _copy_with_mkdir()
 sub_path argument be optional
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 8747f6a440..6ddc6e4c2a 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -52,7 +52,7 @@ def _guess_docker_command():
     raise Exception("Cannot find working docker command. Tried:\n%s" % \
                     commands_txt)
 
-def _copy_with_mkdir(src, root_dir, sub_path):
+def _copy_with_mkdir(src, root_dir, sub_path='.'):
     """Copy src into root_dir, creating sub_path as needed."""
     dest_dir = os.path.normpath("%s/%s" % (root_dir, sub_path))
     try:
-- 
2.11.0
