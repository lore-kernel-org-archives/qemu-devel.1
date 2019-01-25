Received: from eggs.gnu.org ([209.51.188.92]:59524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn9cA-0004vp-G9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn9c9-0006Eb-Q8
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gn9c5-00069H-PH
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:15 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 25 Jan 2019 20:06:04 -0200
Message-Id: <20190125220606.4864-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] i386: arch_capabilities fixes +
 migratability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Tao Xu <tao5.xu@intel.com>

This series works around KVM bugs that affect the arch_capabilities
feature.  One bug made the feature be enabled incorrect on AMD hosts,
and another one made the feature unsafe to enable on most Intel hosts.
With the work around, we can finally make arch_capabilities a migratable
feature.

Unfortunately, the work around has the side effect of making
arch_capabilities unavailable on hosts without hardware support for the
feature until one of the KVM bugs is fixed.

Eduardo Habkost (2):
  i386: kvm: Disable arch_capabilities if MSR can't be set
  i386: Make arch_capabilities migratable

 target/i386/cpu.c | 1 -
 target/i386/kvm.c | 9 +++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.18.0.rc1.1.g3f1ff2140
