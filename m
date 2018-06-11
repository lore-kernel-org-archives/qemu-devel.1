Received: from eggs.gnu.org ([2001:4830:134:3::10]:60698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqU-00021m-KL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqS-0000Kd-NT
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqS-0000KP-Hc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:41 -0300
Message-Id: <20180611174243.31070-12-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/13] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

All of the supported build platforms documented in qemu-doc.texi
should already support Python 2.7.

Removing support for Python 2.6 will allow us to remove some
compatibility modules we carry in the QEMU tree:

* scripts/argparse.py
* scripts/ordereddict.py

Python 2.6 is also not receiving bug fixes upstream and is not
supported by pylint, which makes it harder to keep the code
compatible with both Python 2 and Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608143026.20167-1-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 14b11130a7..a8c4094c87 100755
--- a/configure
+++ b/configure
@@ -1651,8 +1651,8 @@ fi
=20
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6))'; then
-  error_exit "Cannot use '$python', Python 2 >=3D 2.6 or Python 3 is req=
uired." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
+  error_exit "Cannot use '$python', Python 2 >=3D 2.7 or Python 3 is req=
uired." \
       "Use --python=3D/path/to/python to specify a supported Python."
 fi
=20
--=20
2.18.0.rc1.1.g3f1ff2140
