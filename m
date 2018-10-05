Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8SYC-0003f9-UW
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8SY8-0001eW-7w
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8SY6-0001bV-6w
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:01:54 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 18:01:45 +0200
Message-Id: <20181005160147.892-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] two little bochs-display patches.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



Gerd Hoffmann (2):
  display: add separate config option for bochs-display
  bochs-display: wire up edid support

 hw/display/bochs-display.c | 13 +++++++++++++
 default-configs/pci.mak    |  1 +
 hw/display/Makefile.objs   |  3 ++-
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.9.3
