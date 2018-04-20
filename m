Received: from eggs.gnu.org ([2001:4830:134:3::10]:37727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aeh-0005Bg-Vp
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9aeh-00077q-6O
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9aeg-000762-Vi
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:32 -0300
Message-Id: <20180420181951.7252-6-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 05/24] avocado_qemu: Increase the login timeout
 to 60s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

The 10s login is quite short, let's use 60s and see whether it fits.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_q=
emu/test.py
index fb16785a20..e99c7e9e8d 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -97,7 +97,7 @@ def _get_qemu_bin(arch):
     return qemu_binary
=20
=20
-def _handle_prompts(session, username, password, prompt, timeout=3D10,
+def _handle_prompts(session, username, password, prompt, timeout=3D60,
                     debug=3DFalse):
     """
     Connect to a remote host (guest) using SSH or Telnet or else.
--=20
2.14.3
