Received: from eggs.gnu.org ([2001:4830:134:3::10]:48597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9rlH-0002bP-W9
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9rl9-0006jB-G7
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1g9rl4-0006QD-QH
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:09:09 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Tue,  9 Oct 2018 15:08:51 +0200
Message-Id: <20181009130853.6412-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] i386/kvm: enable Hyper-V PV IPI
 mechanism
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

Changes since v1 [Roman Kagan]:
- Strip kvm.h with 'make headers_install' before putting to Qemu.
- Add Reviewed-by: to PATCH2

Vitaly Kuznetsov (2):
  linux-headers: update to pre-4.20 (kvm/queue)
  i386/kvm: add support for Hyper-V IPI send

 linux-headers/linux/kvm.h  |  3 +++
 target/i386/cpu.c          |  1 +
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          | 14 +++++++++++++-
 5 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.17.1
