Received: from eggs.gnu.org ([2001:4830:134:3::10]:51148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mc-0006xi-03
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mb-0008L0-5J
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7ma-0008Kt-W2
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:53 -0400
Date: Tue, 20 Mar 2018 05:17:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-35-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 34/50] migration/ram:
 ramblock_recv_bitmap_test_byte_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Utility for testing the map when you already know the offset
in the RAMBlock.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/ram.h | 1 +
 migration/ram.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.h b/migration/ram.h
index 53f0021..5030be1 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -60,6 +60,7 @@ int ram_postcopy_incoming_init(MigrationIncomingState *=
mis);
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
=20
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
+bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_o=
ffset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_=
t nr);
=20
diff --git a/migration/ram.c b/migration/ram.c
index 7266351..6ce7770 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -169,6 +169,11 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *ho=
st_addr)
                     rb->receivedmap);
 }
=20
+bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_o=
ffset)
+{
+    return test_bit(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
+}
+
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr)
 {
     set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->recei=
vedmap);
--=20
MST
