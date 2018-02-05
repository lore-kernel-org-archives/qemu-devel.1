Received: from eggs.gnu.org ([2001:4830:134:3::10]:59307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipt2-0001gJ-Mo
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipt1-00075A-V5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipt1-000748-Ow
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:19 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:48 -0200
Message-Id: <20180205230900.11344-10-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/21] scripts: ensure signrom treats data as
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180116134217.8725-10-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/signrom.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/signrom.py b/scripts/signrom.py
index d1dabe0240..0497a1c32e 100644
--- a/scripts/signrom.py
+++ b/scripts/signrom.py
@@ -18,7 +18,7 @@ fin =3D open(sys.argv[1], 'rb')
 fout =3D open(sys.argv[2], 'wb')
=20
 magic =3D fin.read(2)
-if magic !=3D '\x55\xaa':
+if magic !=3D b'\x55\xaa':
     sys.exit("%s: option ROM does not begin with magic 55 aa" % sys.argv=
[1])
=20
 size_byte =3D ord(fin.read(1))
@@ -33,7 +33,7 @@ elif len(data) < size:
     # Add padding if necessary, rounding the whole input to a multiple o=
f
     # 512 bytes according to the third byte of the input.
     # size-1 because a final byte is added below to store the checksum.
-    data =3D data.ljust(size-1, '\0')
+    data =3D data.ljust(size-1, b'\0')
 else:
     if ord(data[-1:]) !=3D 0:
         sys.stderr.write('WARNING: ROM includes nonzero checksum\n')
--=20
2.14.3
