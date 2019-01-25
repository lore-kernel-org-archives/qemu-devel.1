Received: from eggs.gnu.org ([209.51.188.92]:53715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn27o-0008C4-HQ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn27m-0003Z7-Ev
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gn27i-0003WH-NT
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:23 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 25 Jan 2019 12:06:10 -0200
Message-Id: <20190125140610.7810-3-ehabkost@redhat.com>
In-Reply-To: <20190125140610.7810-1-ehabkost@redhat.com>
References: <20190125140610.7810-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] decodetree: re.fullmatch was added in 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Python 3 versions earlier than 3.4 do not have it, use the
same workaround that is in place for 3.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1548410602-16008-1-git-send-email-pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 0bc73b5990..e342d278b8 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -204,7 +204,7 @@ def output(*args):
         output_fd.write(a)
=20
=20
-if sys.version_info >=3D (3, 0):
+if sys.version_info >=3D (3, 4):
     re_fullmatch =3D re.fullmatch
 else:
     def re_fullmatch(pat, str):
--=20
2.18.0.rc1.1.g3f1ff2140
