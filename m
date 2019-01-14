Received: from eggs.gnu.org ([209.51.188.92]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3RJ-0006sx-B6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3RD-0002OC-Rj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:42:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj3RD-0002Nw-ML
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:42:03 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Jan 2019 12:34:27 -0200
Message-Id: <20190114143432.4771-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] x86 queue, 2019-01-14
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

The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b=
16:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-=
part2' into staging (2019-01-14 11:41:43 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to abd5fc4c862d033a989552914149f01c9476bb16:

  i386/kvm: add a comment explaining why .feat_names are commented out fo=
r Hyper-V feature bits (2019-01-14 12:28:44 -0200)

----------------------------------------------------------------
x86 queue, 2019-01-14

* Reenable RDTSCP support on Opteron_G[345] CPU models CPU models
  (Borislav Petkov)
* host-phys-bits-limit option for better control of 5-level EPT
  (Eduardo Habkost)
* Disable MPX support on named CPU models (Paolo Bonzini)
* expose HV_CPUID_ENLIGHTMENT_INFO.EAX and HV_CPUID_NESTED_FEATURES.EAX
  as feature words (Vitaly Kuznetsov)

----------------------------------------------------------------

Borislav Petkov (1):
  target-i386: Reenable RDTSCP support on Opteron_G[345] CPU models CPU
    models

Eduardo Habkost (1):
  x86: host-phys-bits-limit option

Paolo Bonzini (1):
  target/i386: Disable MPX support on named CPU models

Vitaly Kuznetsov (2):
  i386/kvm: expose HV_CPUID_ENLIGHTMENT_INFO.EAX and
    HV_CPUID_NESTED_FEATURES.EAX as feature words
  i386/kvm: add a comment explaining why .feat_names are commented out
    for Hyper-V feature bits

 target/i386/cpu.h |  5 +++
 hw/i386/pc.c      | 10 ++++++
 target/i386/cpu.c | 67 +++++++++++++++++++++++++++++--------
 target/i386/kvm.c | 85 +++++++++++++++++++++++++----------------------
 qemu-doc.texi     | 13 ++++++++
 5 files changed, 126 insertions(+), 54 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
