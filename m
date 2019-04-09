Received: from eggs.gnu.org ([209.51.188.92]:49317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmV3-00044C-07
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmV2-0002u0-3a
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:00 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  9 Apr 2019 10:52:42 +0200
Message-Id: <20190409085245.31548-3-thuth@redhat.com>
In-Reply-To: <20190409085245.31548-1-thuth@redhat.com>
References: <20190409085245.31548-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 2/5] tests/megasas: Make test
 independent of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Hannes Reinecke <hare@suse.com>

The test uses memwrite() and thus relies on global_qtest. Let's replace i=
t
with qtest_memwrite(), so that we are independent from global_qtest here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/megasas-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/megasas-test.c b/tests/megasas-test.c
index 33aa97042c..1111d331d3 100644
--- a/tests/megasas-test.c
+++ b/tests/megasas-test.c
@@ -66,7 +66,7 @@ static void megasas_pd_get_info_fuzz(void *obj, void *d=
ata, QGuestAllocator *all
     context[7] =3D cpu_to_le32(0);
=20
     context_pa =3D guest_alloc(alloc, sizeof(context));
-    memwrite(context_pa, context, sizeof(context));
+    qtest_memwrite(dev->bus->qts, context_pa, context, sizeof(context));
     qpci_io_writel(dev, bar, 0x40, context_pa);
 }
=20
--=20
2.21.0
