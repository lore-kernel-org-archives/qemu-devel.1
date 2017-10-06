Received: from eggs.gnu.org ([2001:4830:134:3::10]:41905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYA-0003pX-TX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aY6-0001T3-2Y
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0aY5-0001RY-SN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:52:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BB0A883B8
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 21:52:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  6 Oct 2017 18:52:37 -0300
Message-Id: <20171006215244.27104-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] x86: Rework KVM-defaults compat code,
 enable kvm_pv_unhalt by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

This series enables kvm_pv_unhalt by default on pc-*-2.11 and
newer.

To do that, I first reworked the existing
x86_cpu_change_kvm_default() logic to use compat_props instead,
so we don't need to make the chain of pc_compat_*() functions
grow.

Based-on: 20171006132502.9191-1-ehabkost@redhat.com
(Subject: [PATCH] isapc: Remove unnecessary migration compatibility code)

Eduardo Habkost (7):
  qemu-doc: Document minimum kernel version for KVM in x86_64
  target/i386: x86_cpu_expand_feature() helper
  target/i386: Use global variables to control KVM defaults
  kvm: Define KVM_FEAT_* even if CONFIG_KVM is not defined
  target/i386: Handle kvm_auto_* compat in x86_cpu_expand_features()
  pc: Use compat_props to control KVM defaults compatibility
  target/i386: Enable kvm_pv_unhalt by default

 include/hw/i386/pc.h   | 12 +++++++
 target/i386/cpu.h      | 22 +++++++------
 target/i386/kvm_i386.h |  9 ++++++
 hw/i386/pc_piix.c      |  7 ++--
 target/i386/cpu.c      | 88 +++++++++++++++++++++++++++++++++-----------------
 qemu-doc.texi          |  9 ++++++
 6 files changed, 105 insertions(+), 42 deletions(-)

-- 
2.13.6
