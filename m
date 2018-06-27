Received: from eggs.gnu.org ([2001:4830:134:3::10]:38642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzz0-0006tz-2H
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzyu-0002BW-Uv
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXzyu-0002BF-Ox
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Jun 2018 23:14:19 -0300
Message-Id: <20180627021423.18404-3-ehabkost@redhat.com>
In-Reply-To: <20180627021423.18404-1-ehabkost@redhat.com>
References: <20180627021423.18404-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] docker: Always return int on run()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We'll add type annotations to the run() methods, so add 'return'
statements to all the functions so the type checker won't
complain.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/docker/docker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 0de7662146..e3bfa1cc9e 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -418,7 +418,7 @@ class ProbeCommand(SubCommand):
         except Exception:
             print("no")
 
-        return
+        return 0
 
 
 class CcCommand(SubCommand):
@@ -503,6 +503,7 @@ class CheckCommand(SubCommand):
                     print ("Image less than %d minutes old" % (args.olderthan))
                 return 0
 
+        return 0
 
 def main():
     parser = argparse.ArgumentParser(description="A Docker helper",
-- 
2.18.0.rc1.1.g3f1ff2140
