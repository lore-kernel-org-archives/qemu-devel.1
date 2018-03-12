Received: from eggs.gnu.org ([208.118.235.92]:51035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPsF-0004vc-9d
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPsE-0000l4-F6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1evPsE-0000ki-6K
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 12 Mar 2018 16:00:13 +0000
Message-Id: <20180312160014.6804-5-stefanha@redhat.com>
In-Reply-To: <20180312160014.6804-1-stefanha@redhat.com>
References: <20180312160014.6804-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] trace: remove use of QEMU specific types
 from trace probes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Any compound structs / unions / etc, should always be declared as
'void *' pointers, since it cannot be assumed that trace backends
are able to resolve QEMU typedefs.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180308155524.5082-2-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/trace-events b/trace-events
index 89fcad0fd1..855b0ab240 100644
--- a/trace-events
+++ b/trace-events
@@ -68,9 +68,9 @@ memory_region_tb_read(int cpu_index, uint64_t addr, uin=
t64_t value, unsigned siz
 memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, uns=
igned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, ui=
nt64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, u=
int64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PR=
Ix64" size %u"
-flatview_new(FlatView *view, MemoryRegion *root) "%p (root %p)"
-flatview_destroy(FlatView *view, MemoryRegion *root) "%p (root %p)"
-flatview_destroy_rcu(FlatView *view, MemoryRegion *root) "%p (root %p)"
+flatview_new(void *view, void *root) "%p (root %p)"
+flatview_destroy(void *view, void *root) "%p (root %p)"
+flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
=20
 # gdbstub.c
 gdbstub_op_start(const char *device) "Starting gdbstub using device %s"
--=20
2.14.3
