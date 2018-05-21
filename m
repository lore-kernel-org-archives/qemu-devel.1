Received: from eggs.gnu.org ([2001:4830:134:3::10]:41766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKslF-00024w-Bc
	for qemu-devel@nongnu.org; Mon, 21 May 2018 17:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKslA-0005zA-JZ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 17:54:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fKslA-0005ya-Ez
	for qemu-devel@nongnu.org; Mon, 21 May 2018 17:54:28 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 21 May 2018 22:54:21 +0100
Message-Id: <20180521215424.13520-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] i386: speculative store buffer bypass
 mitigation (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This provides the QEMU part of the mitigations for the speculative
store buffer bypass vulnerabilities on the x86 platform[1], and is
the companion of the kernel patches merged in:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D3b78ce4a34b761c7fe13520de822984019ff1a8f

[1] https://bugs.chromium.org/p/project-zero/issues/detail?id=3D1528
    https://access.redhat.com/security/vulnerabilities/ssbd

Daniel P. Berrang=C3=A9 (1):
  i386: define the 'ssbd' CPUID feature bit (CVE-2018-3639)

Konrad Rzeszutek Wilk (2):
  i386: define the AMD 'virt-ssbd' CPUID feature bit (CVE-2018-3639)
  i386: Define the Virt SSBD MSR and handling of it (CVE-2018-3639)

 target/i386/cpu.c     |  4 ++--
 target/i386/cpu.h     |  3 +++
 target/i386/kvm.c     | 16 ++++++++++++++--
 target/i386/machine.c | 20 ++++++++++++++++++++
 4 files changed, 39 insertions(+), 4 deletions(-)

--=20
2.17.0
