Received: from eggs.gnu.org ([2001:4830:134:3::10]:42308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVKNu-0001x4-29
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVKNq-0004C6-A3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVKNq-0004Az-3a
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:21:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 12 Jul 2017 13:20:54 -0300
Message-Id: <20170712162058.10538-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Fix SVM and KVM features reported on "max"
 CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

This series cleans up some of the CPU model initialization code
and fixes one of the causes of the following bug:

  https://bugzilla.redhat.com/show_bug.cgi?id=1467599
  ("Unable to start domain: the CPU is incompatible with host
  CPU: Host CPU does not provide required features: svm")

Eduardo Habkost (4):
  target/i386: Use simple static property for "model-id"
  target/i386: Use host_vendor_fms() in max_x86_cpu_initfn()
  target/i386: Define CPUID_MODEL_ID_SZ macro
  target/i386: Don't use x86_cpu_load_def() on "max" CPU model

 target/i386/cpu.h |  2 +-
 target/i386/cpu.c | 96 ++++++++++++++++++++++++-------------------------------
 2 files changed, 42 insertions(+), 56 deletions(-)

-- 
2.9.4
