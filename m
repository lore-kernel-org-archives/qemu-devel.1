Received: from eggs.gnu.org ([209.51.188.92]:55016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpT8-0002Qf-1t
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grpT6-0007Xw-71
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:36:18 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  7 Feb 2019 14:36:04 -0500
Message-Id: <20190207193605.25676-4-crosa@redhat.com>
In-Reply-To: <20190207193605.25676-1-crosa@redhat.com>
References: <20190207193605.25676-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] scripts/render_block_graph.py: add a
 missing import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The handle to QMP may be one of two classes, one implemented locally,
and the other one, which seems to be from "qmp.qmp", but of which an
import is missing.

CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/render_block_graph.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.p=
y
index ed7e581b4f..7686e30761 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -24,6 +24,7 @@ import subprocess
 import json
 from graphviz import Digraph
 from qemu import MonitorResponseError
+from qmp.qmp import QEMUMonitorProtocol
=20
=20
 def perm(arr):
--=20
2.20.1
