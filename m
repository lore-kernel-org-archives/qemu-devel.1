Received: from eggs.gnu.org ([2001:4830:134:3::10]:59458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRB5-0003uQ-Ml
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRB2-0003ke-Ji
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1daRB2-0003jx-E3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:36:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 26 Jul 2017 15:36:43 -0300
Message-Id: <20170726183646.14088-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] x86 bug fix for -rc1
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

The following changes since commit 522fd24ca030c27c591dafedd65c1dfd51e40450:

  Update version for v2.10.0-rc0 release (2017-07-25 17:13:09 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-pull-request

for you to fetch changes up to bd1820227ecc0c77cc2aeba7c7c25b2d0a72ff3c:

  target/i386: Don't use x86_cpu_load_def() on "max" CPU model (2017-07-26 14:55:12 -0300)

----------------------------------------------------------------
x86 bug fix for -rc1

Fix for a bug in "-cpu max" that breaks libvirt usage of
query-cpu-model-expansion.

----------------------------------------------------------------

Eduardo Habkost (3):
  target/i386: Use host_vendor_fms() in max_x86_cpu_initfn()
  target/i386: Define CPUID_MODEL_ID_SZ macro
  target/i386: Don't use x86_cpu_load_def() on "max" CPU model

 target/i386/cpu.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
2.9.4
