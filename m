Received: from eggs.gnu.org ([2001:4830:134:3::10]:46149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7tFB-0003kV-5x
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7tF6-0004OX-TV
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g7tF4-0004AQ-QY
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:19:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 Oct 2018 23:19:40 -0300
Message-Id: <20181004021943.22724-2-ehabkost@redhat.com>
In-Reply-To: <20181004021943.22724-1-ehabkost@redhat.com>
References: <20181004021943.22724-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] device-crash-test: No need for sys.path hack
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

The device-crash-test script is already inside the 'scripts'
directory, there's no need to add the directory manually to
sys.path.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180618225131.13113-2-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 7045594bd4..da0bc5edd0 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -35,7 +35,6 @@ import random
 import argparse
 from itertools import chain
=20
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'scripts')=
)
 from qemu import QEMUMachine
=20
 logger =3D logging.getLogger('device-crash-test')
--=20
2.18.0.rc1.1.g3f1ff2140
