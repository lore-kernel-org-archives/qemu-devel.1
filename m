Received: from eggs.gnu.org ([2001:4830:134:3::10]:34895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtB-0004dt-Op
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJt8-0001Aw-A8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:04:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUJt8-0001AA-3e
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:04:54 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 19 Jan 2017 19:04:43 -0200
Message-Id: <20170119210449.11991-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] i386: Add "max" CPU model to TCG and KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

This is v2 of the previous series that enabled the "host" CPU
model on TCG. Now a new "max" CPU is being added, while keeping
"host" KVM-specific.

In addition to simply adding "max" as a copy of the existing
"host" CPU model, additional patches change it to not use any
host CPUID information when in TCG mode.

---
Cc: "Richard W.M. Jones" <rjones@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Eduardo Habkost (6):
  i386: Unset cannot_destroy_with_object_finalize_yet on "host" model
  i386: Add ordering field to CPUClass
  i386: Rename X86CPU::host_features to X86CPU::max_features
  i386: Create "max" CPU model
  i386: Make "max" model not use any host CPUID info on TCG
  i386: Don't set CPUClass::cpu_def on "max" model

 target/i386/cpu-qom.h |   6 ++-
 target/i386/cpu.h     |   2 +-
 target/i386/cpu.c     | 110 +++++++++++++++++++++++++++++---------------------
 3 files changed, 71 insertions(+), 47 deletions(-)

-- 
2.11.0.259.g40922b1
