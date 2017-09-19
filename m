Received: from eggs.gnu.org ([2001:4830:134:3::10]:42414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOze-0005PL-Gh
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzd-0004lF-GQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOzd-0004ko-AC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:48 -0300
Message-Id: <20170919201850.14772-11-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/12] NUMA: Replace MAX_NODES with
 nb_numa_nodes in for loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

In QEMU, the number of the NUMA nodes is determined by parse_numa_opts().
Then, QEMU uses it for iteration, for example:
  for (i =3D 0; i < nb_numa_nodes; i++)

However, in memory_region_allocate_system_memory(), it uses MAX_NODES
not nb_numa_nodes.

So, replace MAX_NODES with nb_numa_nodes to keep code consistency and
reduce the loop times.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-Id: <1503387936-3483-1-git-send-email-douly.fnst@cn.fujitsu.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/numa.c b/numa.c
index fe066ad2f8..100a67febf 100644
--- a/numa.c
+++ b/numa.c
@@ -567,7 +567,7 @@ void memory_region_allocate_system_memory(MemoryRegio=
n *mr, Object *owner,
     }
=20
     memory_region_init(mr, owner, name, ram_size);
-    for (i =3D 0; i < MAX_NODES; i++) {
+    for (i =3D 0; i < nb_numa_nodes; i++) {
         uint64_t size =3D numa_info[i].node_mem;
         HostMemoryBackend *backend =3D numa_info[i].node_memdev;
         if (!backend) {
--=20
2.13.5
