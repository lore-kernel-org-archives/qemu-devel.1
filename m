Received: from eggs.gnu.org ([2001:4830:134:3::10]:51277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG6p-0008GH-1s
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG6l-0005DK-Uo
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:28:55 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:47267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG6l-0005DB-R0
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:28:51 -0500
Received: by mail-qt0-x243.google.com with SMTP id z50so1619108qtj.4
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 18:28:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  7 Nov 2017 23:28:22 -0300
Message-Id: <20171108022828.7242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/6] generic way to deprecate machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

This series intends to provide a simple and common way to deprecate
machines between releases. It may be extended to deprecate devices.

I started with the machines list from:

  https://wiki.qemu.org/Features/LegacyRemoval#Deprecated_machines

Comment welcomed :)

Regards,

Phil.

Alistair Francis (1):
  hw/arm: deprecate the EP108 board

Philippe Mathieu-Daudé (5):
  machine: add a deprecated_reason property
  hw/arm: deprecate the Gumstix boards
  hw/ppc: deprecate the PReP machine
  hw/i386: deprecate the pc-0.10 and pc-0.11 machines
  hw/i386: deprecate the "isapc" machine

 include/hw/boards.h  | 1 +
 hw/arm/gumstix.c     | 2 ++
 hw/arm/xlnx-zcu102.c | 6 +++++-
 hw/i386/pc_piix.c    | 3 +++
 hw/ppc/prep.c        | 1 +
 vl.c                 | 7 +++++++
 6 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.15.0
