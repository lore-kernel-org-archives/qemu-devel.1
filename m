Received: from eggs.gnu.org ([2001:4830:134:3::10]:43428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKssA-0005lq-5b
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKss6-0000fO-BU
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fKss6-0000ez-6E
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 21 May 2018 19:01:30 -0300
Message-Id: <20180521220133.17445-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Speculative store buffer bypass mitigation
 (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

This provides the QEMU part of the mitigations for the speculative
store buffer bypass vulnerabilities on the x86 platform[1], and is
the companion of the kernel patches merged in:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D3b78ce4a34b761c7fe13520de822984019ff1a8f

[1] https://bugs.chromium.org/p/project-zero/issues/detail?id=3D1528
    https://access.redhat.com/security/vulnerabilities/ssbd

The following changes since commit 9802316ed6c19fd45b4c498523df02ca370d05=
86:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' i=
nto staging (2018-05-21 10:50:32 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 403503b162ffc33fb64cfefdf7b880acf41772cd:

  i386: define the AMD 'virt-ssbd' CPUID feature bit (CVE-2018-3639) (201=
8-05-21 18:59:08 -0300)

----------------------------------------------------------------
Speculative store buffer bypass mitigation (CVE-2018-3639)

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (1):
  i386: define the 'ssbd' CPUID feature bit (CVE-2018-3639)

Konrad Rzeszutek Wilk (2):
  i386: Define the Virt SSBD MSR and handling of it (CVE-2018-3639)
  i386: define the AMD 'virt-ssbd' CPUID feature bit (CVE-2018-3639)

 target/i386/cpu.h     |  3 +++
 target/i386/cpu.c     |  4 ++--
 target/i386/kvm.c     | 16 ++++++++++++++--
 target/i386/machine.c | 20 ++++++++++++++++++++
 4 files changed, 39 insertions(+), 4 deletions(-)

--=20
2.14.3
