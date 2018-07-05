Received: from eggs.gnu.org ([2001:4830:134:3::10]:44852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxzh-0006Zy-OM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxzf-0007Bf-KQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:43:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  5 Jul 2018 08:43:46 +0200
Message-Id: <20180705064348.3162-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] vga: make stdvga the global default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Sebastian Bauer <mail@sebastianbauer.info>, Gerd Hoffmann <kraxel@redhat.com>



Gerd Hoffmann (2):
  vga: set default_display for all machines using cirrus.
  vga: don't pick cirrus by default

 hw/alpha/dp264.c     | 1 +
 hw/i386/pc_piix.c    | 2 +-
 hw/mips/mips_malta.c | 1 +
 hw/mips/mips_r4k.c   | 1 +
 vl.c                 | 2 --
 5 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.9.3
