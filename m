Received: from eggs.gnu.org ([2001:4830:134:3::10]:44748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1vHp-0007nx-5v
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1vHj-0001dr-Nk
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1vHj-0001co-IM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:27 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 16:13:20 +0200
Message-Id: <20171010141323.14049-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] vga: handle cirrus vbe mode wraparounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: d@vidbuchanan.co.uk, Gerd Hoffmann <kraxel@redhat.com>

Fix for CVE-2017-13672 (3d90c6254863693a6b13d918d2b8682e08bbc681) was
incomplete, here are the missing bits.

v3: add fix for issue reported by Coverity

Gerd Hoffmann (3):
  vga: drop line_offset variable
  vga: handle cirrus vbe mode wraparounds.
  vga: add ram_addr_t cast

 hw/display/vga.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

-- 
2.9.3
