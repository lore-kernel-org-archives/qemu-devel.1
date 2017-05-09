Received: from eggs.gnu.org ([2001:4830:134:3::10]:58219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85B6-0002hG-9p
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85B1-00081l-AP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d85B1-00080Q-3W
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:43 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  9 May 2017 14:27:34 +0100
Message-Id: <20170509132736.10071-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] Support CPUID signature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This enables report of a signature in CPUID for the TCG
interpretor.

Changed in v4:

 - Report 0x40000001 in EAX for 0x40000000 index (Eduardo)
 - Report all zeros for 0x40000001 index (Eduardo)
 - Make code style consistent when checking limits (Eduardo)

Changed in v3:

 - Simplify CPU limit code still further (Eduardo)

Changed in v2:

 - Rewrite the way we bounds check / cap the CPUID index
   to use a flat switch, instead of nested ifs (Eduardo)
 - Add a 'tcg-cpuid' property to allow it to be hidden
   (Eduardo)
 - Hide the TCG signature for old machine types
 - Force code to a no-op if tcg_enabled() is false (Eduardo)


NB, I did not introduce a general 'hypervisor-cpuid' property
to obsolete the existing 'kvm=off|on' -cpu property, since it
appears impossible to get the back compat semantics right,
as described in a previous reply.

Daniel P. Berrange (2):
  i386: rewrite way CPUID index is validated
  i386: expose "TCGTCGTCGTCG" in the 0x40000000 CPUID leaf

 include/hw/i386/pc.h |  5 ++++
 target/i386/cpu.c    | 65 +++++++++++++++++++++++++++++++++++-----------------
 target/i386/cpu.h    |  1 +
 3 files changed, 50 insertions(+), 21 deletions(-)

-- 
2.9.3
