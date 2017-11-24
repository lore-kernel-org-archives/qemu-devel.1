Received: from eggs.gnu.org ([2001:4830:134:3::10]:52169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8VI-0002y3-Jw
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8VE-0004mm-Me
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eI8VE-0004m9-Hk
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:24 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 24 Nov 2017 15:34:14 +0800
Message-Id: <20171124073417.4342-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] cpu: suffix cpu address spaces with
 indexes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com

v2:
- drop patch 1 since merged
- add last patch as suggested by Paolo

Please review, thanks.

Peter Xu (3):
  cpu: refactor cpu_address_space_init()
  cpu: suffix cpu address spaces with cpu index
  cpu: put AddressSpace into CPUAddressSpace

 cpus.c                  |  5 +----
 exec.c                  | 41 ++++++++++++++++++++++++++---------------
 include/exec/exec-all.h |  6 ++++--
 target/arm/cpu.c        | 13 +++----------
 target/i386/cpu.c       | 10 ++--------
 5 files changed, 36 insertions(+), 39 deletions(-)

-- 
2.14.3
