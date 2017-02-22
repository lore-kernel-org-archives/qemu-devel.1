Received: from eggs.gnu.org ([2001:4830:134:3::10]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbp1-0007qK-8T
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgboy-00074d-3s
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgbox-00073S-UV
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:39:24 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Feb 2017 15:39:16 -0300
Message-Id: <20170222183919.11928-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] i386: Add "max" CPU model to TCG and KVM
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

Changes v1 -> v2:
* Fix build without CONFIG_KVM at lmce_supported()
* Rebased on top of my x86-next branch:
  https://github.com/ehabkost/qemu x86-next

Git branch for testing:
  https://github.com/ehabkost/qemu-hacks work/x86-cpu-max-tcg

libvirt code to use the new feature already exist, and were
submitted to libvir-list, at:
  https://www.mail-archive.com/libvir-list@redhat.com/msg142168.html

---

This is a replacement for the previous series that enabled the
"host" CPU model on TCG. Now a new "max" CPU is being added,
while keeping "host" KVM-specific.

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

Eduardo Habkost (3):
  i386: Create "max" CPU model
  i386: Make "max" model not use any host CPUID info on TCG
  i386: Don't set CPUClass::cpu_def on "max" model

 target/i386/cpu-qom.h |  4 ++-
 target/i386/cpu.c     | 98 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 64 insertions(+), 38 deletions(-)

-- 
2.11.0.259.g40922b1
