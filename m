Received: from eggs.gnu.org ([2001:4830:134:3::10]:40881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqhO0-0008WA-1e
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqh9n-0005ms-UY
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:59:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60258 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fqh9n-0005mj-QF
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:59:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 610AF401EF07
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 15:59:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Aug 2018 17:59:09 +0200
Message-Id: <20180817155910.5722-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] update-linux-headers.sh: add qemu_fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The fw_cfg header was added during 4.17 cycle.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/update-linux-headers.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-heade=
rs.sh
index feb75390aa..0a964fe240 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -165,7 +165,9 @@ EOF
=20
 rm -rf "$output/include/standard-headers/linux"
 mkdir -p "$output/include/standard-headers/linux"
-for i in "$tmpdir"/include/linux/*virtio*.h "$tmpdir/include/linux/input=
.h" \
+for i in "$tmpdir"/include/linux/*virtio*.h \
+         "$tmpdir/include/linux/qemu_fw_cfg.h" \
+         "$tmpdir/include/linux/input.h" \
          "$tmpdir/include/linux/input-event-codes.h" \
          "$tmpdir/include/linux/pci_regs.h" \
          "$tmpdir/include/linux/ethtool.h" "$tmpdir/include/linux/kernel=
.h" \
--=20
2.18.0.547.g1d89318c48
