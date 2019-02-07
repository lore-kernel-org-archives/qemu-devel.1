Received: from eggs.gnu.org ([209.51.188.92]:55050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpTE-0002VI-0Z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpTC-0007ba-59
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:23 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  7 Feb 2019 14:36:05 -0500
Message-Id: <20190207193605.25676-5-crosa@redhat.com>
In-Reply-To: <20190207193605.25676-1-crosa@redhat.com>
References: <20190207193605.25676-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] tests/migration/guestperf/engine.py:
 remove unused import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/migration/guestperf/engine.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestp=
erf/engine.py
index 398e3f2706..1daf09c6f2 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -26,7 +26,6 @@ import time
=20
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', '..'=
, 'scripts'))
 import qemu
-import qmp.qmp
 from guestperf.progress import Progress, ProgressStats
 from guestperf.report import Report
 from guestperf.timings import TimingRecord, Timings
--=20
2.20.1
