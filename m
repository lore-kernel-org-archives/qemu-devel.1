Received: from eggs.gnu.org ([209.51.188.92]:42604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1rz1-0006I4-LV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1rz0-0001NU-T1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1rz0-0001NB-ND
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:42 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu,  7 Mar 2019 12:18:37 +0000
Message-Id: <20190307121838.6345-2-berrange@redhat.com>
In-Reply-To: <20190307121838.6345-1-berrange@redhat.com>
References: <20190307121838.6345-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] docs: clarify that spec-ctrl is only
 needed for Spectre v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The docs currently say that the spec-ctrl feature is needed for both
Spectre variants, but it is only used to address Spectre v2. Also
remove the note about retpolines. The guest OS is usually treated
as a blackbox from host mgmt pov, so it won't have knowledge about
use of retpolines and thus should unconditionally expose spec-ctrl,
allowing the guest to decide whether to use it or not.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 docs/qemu-cpu-models.texi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
index 1b72584161..0ce528806d 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/qemu-cpu-models.texi
@@ -158,8 +158,7 @@ support this feature.
=20
 @item @code{spec-ctrl}
=20
-Required to enable the Spectre (CVE-2017-5753 and CVE-2017-5715) fix,
-in cases where retpolines are not sufficient.
+Required to enable the Spectre v2 (CVE-2017-5715) fix.
=20
 Included by default in Intel CPU models with -IBRS suffix.
=20
@@ -249,8 +248,7 @@ included if using "Host passthrough" or "Host model".
=20
 @item @code{ibpb}
=20
-Required to enable the Spectre (CVE-2017-5753 and CVE-2017-5715) fix,
-in cases where retpolines are not sufficient.
+Required to enable the Spectre v2 (CVE-2017-5715) fix.
=20
 Included by default in AMD CPU models with -IBPB suffix.
=20
--=20
2.20.1
