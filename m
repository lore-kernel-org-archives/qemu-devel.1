Received: from eggs.gnu.org ([2001:4830:134:3::10]:58903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ddYna-0000bu-OA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ddYnX-00083C-Fj
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1ddYnX-00081y-7Z
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:21:35 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri,  4 Aug 2017 11:14:00 +0200
Message-Id: <20170804091403.13478-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] i386/kvm: advertise Hyper-V frequency MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rkrcmar@redhat.com

This is the QEMU part of the changes required for nested Hyper-V to read
timestamps with RDTSC + TSC page. Without exposing the frequency MSRs,
Windows with the Hyper-V role enabled use the much slower
HV_X64_MSR_TIME_REF_COUNT (0x40000020) RDMSR to read timestamps.

The new registers are exposed only if the TSC frequency is stable across
migration and known, as suggested by Paolo.

Ladi Prosek (3):
  i386/kvm: use a switch statement for MSR detection
  i386/kvm: set tsc_khz before configuring Hyper-V CPUID
  i386/kvm: advertise Hyper-V frequency MSRs

 target/i386/kvm.c | 130 +++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 64 deletions(-)

-- 
2.9.3
