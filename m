Received: from eggs.gnu.org ([2001:4830:134:3::10]:60062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLn6-00018m-Pm
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLn5-0000RO-Tp
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:34:56 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLn5-0000R3-Pq
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:34:55 -0500
Received: by mail-qk0-x242.google.com with SMTP id 143so8759363qki.2
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 09:34:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:17 -0300
Message-Id: <20171219173425.8113-2-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
References: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/9] qemu.py: replace iteritems() by items()
 for python3 compatibility
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9bfdf6d37d..5e12ac7c8c 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -247,7 +247,7 @@ class QEMUMachine(object):
     def qmp(self, cmd, conv_keys=True, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args = dict()
-        for key, value in args.iteritems():
+        for key, value in args.items():
             if conv_keys:
                 qmp_args[key.replace('_', '-')] = value
             else:
-- 
2.15.1
