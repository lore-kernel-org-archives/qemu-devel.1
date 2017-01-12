Received: from eggs.gnu.org ([2001:4830:134:3::10]:48056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3U-0001Gc-8b
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3R-0002dB-3m
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cRk3Q-0002d6-UI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:53 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 285978123A
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 18:24:53 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 12 Jan 2017 19:24:43 +0100
Message-Id: <20170112182446.9600-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v6 wave 2 0/3] q35: add negotiable broadcast SMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Previous version (v5):
http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg01902.html

Changes in v6 (see the individual patches for details):
- pick up feedback tags
- rename "smi_broadcast" to "x-smi-broadcast" [Eduardo]

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Thanks!
Laszlo

Laszlo Ersek (3):
  hw/isa/lpc_ich9: add SMI feature negotiation via fw_cfg
  hw/isa/lpc_ich9: add broadcast SMI feature
  hw/isa/lpc_ich9: negotiate SMI broadcast on pc-q35-2.9+ machine types

 include/hw/i386/ich9.h | 13 ++++++++
 include/hw/i386/pc.h   |  5 +++
 hw/isa/lpc_ich9.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 108 insertions(+), 1 deletion(-)

-- 
2.9.3
