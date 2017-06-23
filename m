Received: from eggs.gnu.org ([2001:4830:134:3::10]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORin-0007Zt-AM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORik-0002BD-8u
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:46:13 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:33650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORik-0002Ah-4r
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:46:10 -0400
Received: by mail-qt0-x231.google.com with SMTP id u12so38806110qth.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:46:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 23 Jun 2017 13:45:54 -0300
Message-Id: <20170623164557.11636-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] hw/core: minor fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Sorry to spam so many people, there is no entries in MAINTAINERS for
hw/core/loader.c and hw/core/qdev.c, any volunters?

Philippe Mathieu-Daudé (3):
  elf-loader: warn about invalid endianess
  hw/core: fix missing return value in load_image_targphys_as()
  hw/core: report an error if invalid gpio is used

 hw/core/loader.c | 5 ++++-
 hw/core/qdev.c   | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.13.1
