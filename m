Received: from eggs.gnu.org ([2001:4830:134:3::10]:41782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1dv0R3-0008MF-PM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1dv0Qy-0000u6-AM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1dv0Qy-0000tU-4T
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:18:24 -0400
Message-Id: <20170921120341.590850215@redhat.com>
Date: Thu, 21 Sep 2017 09:03:41 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [Qemu-devel] [patch 0/2] support RT_PRIO_HC hypercall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org

Add the following CPU options:

allow-rt-prio-hc: allow guest to execute hypercall to change vcpu
thread priority.

rt-prio: SCHED_FIFO priority to be used when that hypercall is invoked.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
