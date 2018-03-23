Received: from eggs.gnu.org ([2001:4830:134:3::10]:43498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ezMH1-0002df-2t
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ezMGy-00016n-0U
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:58:23 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 23 Mar 2018 15:58:06 +0300
Message-Id: <20180323125808.4479-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.12 0/2] i386/hyperv: fully control
 Hyper-V features in CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-stable@nongnu.org

In order to guarantee compatibility on migration, QEMU should have
complete control over the features it announces to the guest via CPUID.

However, a number of Hyper-V-related features happen to depend on the
support in the underlying KVM, with no regard to QEMU configuration.

Make QEMU regain control over what Hyper-V features it announces to the
guest.

Note: the patches are also being proposed for stable-2.11, even though
one of them introduces a new cpu property.  This is done to minimize the
number of published QEMU releases where the behavior of the features is
unpredictable, with potentially fatal consequences for the guest.

Note #2: there are other problems in the surrounding code, like ugly
error reporting or inconsistent population of MSRs.  I think this can be
put off to post-2.12.

Roman Kagan (2):
  i386/hyperv: add hv-frequencies cpu property
  i386/hyperv: error out if features requested but unsupported

Cc: qemu-stable@nongnu.org

 target/i386/cpu.h |  1 +
 target/i386/cpu.c |  1 +
 target/i386/kvm.c | 37 +++++++++++++++++++++++++++++--------
 3 files changed, 31 insertions(+), 8 deletions(-)

-- 
2.14.3
