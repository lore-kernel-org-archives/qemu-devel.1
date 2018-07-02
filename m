Received: from eggs.gnu.org ([2001:4830:134:3::10]:59300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AF-0007kN-DS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AB-0003yu-Gy
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:58:59 -0400
Received: from mail-db5eur01on0127.outbound.protection.outlook.com
	([104.47.2.127]:4928
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fa2AA-0003xU-TG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:58:55 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 19:58:36 +0300
Message-Id: <20180702165842.11423-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/6] hyperv: refactor HvSintRoute management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liran Alon <liran.alon@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>

This series modifies the management of HvSintRoute, which is an
important building block in Hyper-V emulation infrastructure, to make it
easier to maintain and enhance, and paves the way to the more complete
Synthetic Interrupt Controller (SynIC) emulation.

This series applies on top of "[PATCH 0/2] hyperv: ensure VP index equal
to QEMU cpu_index" series (message-id:
<20180702134156.13404-1-rkagan@virtuozzo.com>).

Roman Kagan (6):
  hyperv_testdev: refactor for better maintainability
  hyperv: cosmetic: g_malloc -> g_new
  hyperv: synic: only setup ack notifier if there's a callback
  hyperv: allow passing arbitrary data to sint ack callback
  hyperv: address HvSintRoute by X86CPU pointer
  hyperv: make HvSintRoute reference-counted

---
For the reference, all of the Hyper-V / VMBus stuff can be found at
https://src.openvz.org/scm/up/qemu

 target/i386/hyperv.h     |  20 ++-----
 hw/misc/hyperv_testdev.c | 116 +++++++++++++++++++--------------------
 target/i386/hyperv.c     |  78 +++++++++++++++++++-------
 3 files changed, 120 insertions(+), 94 deletions(-)

-- 
2.17.1
