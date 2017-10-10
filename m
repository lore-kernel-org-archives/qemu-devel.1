Received: from eggs.gnu.org ([2001:4830:134:3::10]:44176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1sSw-0005Rv-7k
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1sSr-0002gq-AF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1sSr-0002fj-4q
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:12:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 13:12:38 +0200
Message-Id: <20171010111240.27607-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] vga: handle cirrus vbe mode wraparounds
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

Gerd Hoffmann (2):
  vga: drop line_offset variable
  vga: handle cirrus vbe mode wraparounds.

 hw/display/vga.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

-- 
2.9.3
