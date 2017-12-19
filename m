Received: from eggs.gnu.org ([2001:4830:134:3::10]:60177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnJ-0001HH-73
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnE-0000Vr-Gl
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:09 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnE-0000Vc-Ck
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:04 -0500
Received: by mail-qk0-x241.google.com with SMTP id x7so6079451qkb.0
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 09:35:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:18 -0300
Message-Id: <20171219173425.8113-3-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
References: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/9] qmp.py: encode JSON unicode as byte
 strings for python3 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Nir Soffer <nirsof@gmail.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

the socket API expects byte strings.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qmp/qmp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 07c9632e9e..1080195e04 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -166,7 +166,7 @@ class QEMUMonitorProtocol(object):
         """
         self.logger.debug(">>> %s", qmp_cmd)
         try:
-            self.__sock.sendall(json.dumps(qmp_cmd))
+            self.__sock.sendall(json.dumps(qmp_cmd).encode())
         except socket.error as err:
             if err[0] == errno.EPIPE:
                 return
-- 
2.15.1
