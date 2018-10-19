Received: from eggs.gnu.org ([2001:4830:134:3::10]:38508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gDSjs-0005Pf-96
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gDSjo-0007jH-8c
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:14:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gDSjo-0007gv-0x
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:14:40 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 19 Oct 2018 13:14:30 +0200
Message-Id: <20181019111432.5040-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] i386/kvm: add support for Hyper-V
 Enlightened VMCS
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

Hyper-V Enlightened VMCS feature was merged to KVM, enable it in Qemu.

The feature gives us a significant performance boost for Hyper-V on KVM
deployments.

The first patch of the series is posted for completeness only.

Vitaly Kuznetsov (2):
  linux-headers: update
  x86: hv_evmcs CPU flag support

 linux-headers/asm-powerpc/kvm.h |  1 +
 linux-headers/asm-x86/kvm.h     |  8 ++++++--
 linux-headers/linux/kvm.h       | 16 ++++++++++++++--
 target/i386/cpu.c               |  1 +
 target/i386/cpu.h               |  1 +
 target/i386/hyperv-proto.h      |  3 +++
 target/i386/kvm.c               | 22 +++++++++++++++++++---
 7 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.17.2
