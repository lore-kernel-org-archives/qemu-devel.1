Received: from eggs.gnu.org ([2001:4830:134:3::10]:47011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeeG-0000Nk-Cw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeeB-0006S4-Ce
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHeeB-0006RV-4q
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:11 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:45:43 -0300
Message-Id: <20181031004550.15410-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] x86 queue, 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Sorry for submitting this at the last minute.

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9=
cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1=
-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to c4fc3c4d9b456a145e8f3fd75496e1dacb578473:

  i386: Add PKU on Skylake-Server CPU model (2018-10-30 21:14:43 -0300)

----------------------------------------------------------------
x86 queue, 2018-10-30

* MSR-based feature support for
  MSR_IA32_ARCH_CAPABILITIES bits (Robert Hoo)
* Cascadelake-Server CPU model (Tao Xu)
* Add PKU on Skylake-Server CPU model (Tao Xu)
* Correct cpu_x86_cpuid(0xd) (Sebastian Andrzej Siewior)
* Remove dead code (Peter Maydell)

----------------------------------------------------------------

Peter Maydell (1):
  target/i386: Remove #ifdeffed-out icebp debugging hack

Robert Hoo (3):
  kvm: Add support to KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS
    system ioctl
  x86: Data structure changes to support MSR based features
  x86: define a new MSR based feature word --
    FEATURE_WORDS_ARCH_CAPABILITIES

Sebastian Andrzej Siewior (1):
  i386: correct cpu_x86_cpuid(0xd)

Tao Xu (2):
  i386: Add new model of Cascadelake-Server
  i386: Add PKU on Skylake-Server CPU model

 include/hw/i386/pc.h    |  10 +-
 include/sysemu/kvm.h    |   2 +
 target/i386/cpu.h       |   8 ++
 target/i386/cpu.c       | 279 ++++++++++++++++++++++++++++++++--------
 target/i386/kvm.c       |  91 +++++++++++++
 target/i386/translate.c |   6 -
 6 files changed, 333 insertions(+), 63 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
