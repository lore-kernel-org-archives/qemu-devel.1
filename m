Received: from eggs.gnu.org ([2001:4830:134:3::10]:38627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eHnjX-0002CC-ST
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eHnjU-0005xT-7V
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eHnjU-0005wM-2O
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:23:44 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 23 Nov 2017 17:23:30 +0800
Message-Id: <20171123092333.16085-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] cpu: suffix cpu address spaces with indexes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Richard Henderson <rth@twiddle.net>, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

I picked up Alexey's patch to fix pci address space names (which is
possibly lost on the list), and refactored cpu address spaces a bit
more.  Now most of the address spaces (I believe some corner cases are
there) should have a valid and good name.  I think this is pretty safe
even for 2.11, but I'm fine too to delay this to 2.12.

Please review, thanks.

Alexey Kardashevskiy (1):
  pci: Initialize pci_dev->name before use

Peter Xu (2):
  cpu: refactor cpu_address_space_init()
  cpu: suffix cpu address spaces with cpu index

 cpus.c                  |  5 +----
 exec.c                  | 10 +++++++++-
 hw/pci/pci.c            |  2 +-
 include/exec/exec-all.h |  6 ++++--
 target/arm/cpu.c        | 13 +++----------
 target/i386/cpu.c       | 10 ++--------
 6 files changed, 20 insertions(+), 26 deletions(-)

--=20
2.14.3
