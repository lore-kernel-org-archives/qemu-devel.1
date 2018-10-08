Received: from eggs.gnu.org ([2001:4830:134:3::10]:42095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9ThH-0007ON-SG
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9ThC-0004ur-SQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1g9ThC-0004uW-M1
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:27:30 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Mon,  8 Oct 2018 13:27:24 +0200
Message-Id: <20181008112726.16140-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] i386/kvm: enable Hyper-V PV IPI mechanism
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Hyper-V PV IPI enlightenment was merged to KVM (kvm/queue currently).
Support the feature enablement in Qemu.

Vitaly Kuznetsov (2):
  linux-headers: update to pre-4.20 (kvm/queue)
  i386/kvm: add support for Hyper-V IPI send

 linux-headers/linux/kvm.h  |  7 +++++--
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          | 14 +++++++++++++-
 5 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.17.1
