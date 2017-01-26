Received: from eggs.gnu.org ([2001:4830:134:3::10]:48062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWZ6x-0000Sn-T1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWZ6t-0007rH-1q
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:44:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWZ6s-0007r9-SR
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:44:22 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB92C3DBCF
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 01:44:22 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 26 Jan 2017 02:44:13 +0100
Message-Id: <20170126014416.11211-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v7 wave 2 0/3] q35: add negotiable broadcast SMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi Paolo,

I'm sending v7 with no functional changes; I've only picked up Igor's
R-b's from v6 so you don't have to, and while rebasing to current
master, I resolved a conflict in patch #3 against recent commit
abc62c89f319 ("pc.h: move x-mach-use-reliable-get-clock compat entry to
PC_COMPAT_2_8", 2017-01-18).

The series is fully reviewed and is mergeable as-is.

v6 wave 2 was at
<http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02424.html>.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Thanks
Laszlo

Laszlo Ersek (3):
  hw/isa/lpc_ich9: add SMI feature negotiation via fw_cfg
  hw/isa/lpc_ich9: add broadcast SMI feature
  hw/isa/lpc_ich9: negotiate SMI broadcast on pc-q35-2.9+ machine types

 include/hw/i386/ich9.h | 13 ++++++++
 include/hw/i386/pc.h   |  6 ++++
 hw/isa/lpc_ich9.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 1 deletion(-)

-- 
2.9.3
