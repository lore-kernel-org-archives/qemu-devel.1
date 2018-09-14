Received: from eggs.gnu.org ([2001:4830:134:3::10]:41058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g0c8T-0004Ye-CQ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 20:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g0c8Q-0004YW-47
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 20:39:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1g0c8P-0004Un-Pw
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 20:38:58 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Fri, 14 Sep 2018 03:38:25 +0300
Message-Id: <20180914003827.124570-1-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 0/2]: KVM: i386: Add support for save and
 restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, jmattson@google.com, idan.brown@oracle.com

Hi,

This series aims to add support for QEMU to be able to migrate VMs that
are running nested hypervisors. In order to do so, it utilizes the new
IOCTLs introduced in KVM commit 8fcc4b5923af ("kvm: nVMX: Introduce
KVM_CAP_NESTED_STATE") which were created for this purpose.

1st patch is not really related to the goal of the patch series. It just
makes CPUX86State->xsave_buf to be compiled only when needed (When
compiling with KVM or HVF CPU accelerator).

2nd patch adds the support to migrate VMs that are running nested
hypervisors.

Regards,
-Liran
