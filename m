Received: from eggs.gnu.org ([2001:4830:134:3::10]:51638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1z0-0001Vj-UL
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yx-0007VQ-SE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:27:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb1yx-0007V7-MA
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:27:11 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 10:26:16 +0000
Message-Id: <20180115102621.9183-9-berrange@redhat.com>
In-Reply-To: <20180115102621.9183-1-berrange@redhat.com>
References: <20180115102621.9183-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/13] scripts: ensure signrom treats data
 as bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/signrom.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/signrom.py b/scripts/signrom.py
index d1dabe0240..0497a1c32e 100644
--- a/scripts/signrom.py
+++ b/scripts/signrom.py
@@ -18,7 +18,7 @@ fin = open(sys.argv[1], 'rb')
 fout = open(sys.argv[2], 'wb')
 
 magic = fin.read(2)
-if magic != '\x55\xaa':
+if magic != b'\x55\xaa':
     sys.exit("%s: option ROM does not begin with magic 55 aa" % sys.argv[1])
 
 size_byte = ord(fin.read(1))
@@ -33,7 +33,7 @@ elif len(data) < size:
     # Add padding if necessary, rounding the whole input to a multiple of
     # 512 bytes according to the third byte of the input.
     # size-1 because a final byte is added below to store the checksum.
-    data = data.ljust(size-1, '\0')
+    data = data.ljust(size-1, b'\0')
 else:
     if ord(data[-1:]) != 0:
         sys.stderr.write('WARNING: ROM includes nonzero checksum\n')
-- 
2.14.3
