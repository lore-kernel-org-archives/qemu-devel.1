Received: from eggs.gnu.org ([2001:4830:134:3::10]:56633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmPYH-0005dJ-Kp
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmPYE-00063H-FB
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cmPYE-00062E-8Y
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:06 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 10 Mar 2017 15:45:49 -0300
Message-Id: <20170310184552.1481-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] x86: Haswell TSX blacklist fix for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

The following changes since commit dd4d2578215cd380f40a38028a9904e15b135ef3:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170309-1' into staging (2017-03-09 13:16:05 +0000)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-pull-request

for you to fetch changes up to ec56a4a7b07e2943f49da273a31e3195083b1f2e:

  i386: Change stepping of Haswell to non-blacklisted value (2017-03-10 15:01:09 -0300)

----------------------------------------------------------------
x86: Haswell TSX blacklist fix for 2.9

----------------------------------------------------------------

Eduardo Habkost (3):
  i386: host_vendor_fms() helper function
  i386/kvm: Blacklist TSX on known broken hosts
  i386: Change stepping of Haswell to non-blacklisted value

 include/hw/i386/pc.h |  5 +++++
 target/i386/cpu.h    |  1 +
 target/i386/cpu.c    | 21 ++++++++++++++++++++-
 target/i386/kvm.c    | 17 +++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.11.0.259.g40922b1
