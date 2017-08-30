Received: from eggs.gnu.org ([2001:4830:134:3::10]:52923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1Fp-0006sU-OD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1Fm-00081o-Fb
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dn1Fm-00081S-9N
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A8C07E43F
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 11:33:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 30 Aug 2017 13:33:19 +0200
Message-Id: <20170830113319.6749-3-quintela@redhat.com>
In-Reply-To: <20170830113319.6749-1-quintela@redhat.com>
References: <20170830113319.6749-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] tests: Make vmgenid test compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, pbonzini@redhat.com

Just make sure that nr_tables is size_t not int.

Suggested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Drop the s/g_new0/g_malloc0/ change.
---
 tests/vmgenid-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 3d5c1c3615..bcd3d7ec07 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(void)
     AcpiRsdpDescriptor rsdp_table;
     uint32_t rsdt;
     AcpiRsdtDescriptorRev1 rsdt_table;
-    int tables_nr;
+    size_t tables_nr;
     uint32_t *tables;
     AcpiTableHeader ssdt_table;
     VgidTable vgid_table;
--=20
2.13.5
