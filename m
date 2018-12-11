Received: from eggs.gnu.org ([2001:4830:134:3::10]:39689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2U-00043p-AP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2O-0001fW-2U
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:53:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWp2N-0001eL-Sr
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:53:52 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 18:53:42 -0200
Message-Id: <20181211205346.11118-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] x86 queue, 2018-12-11
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

The following changes since commit 32a1a94dd324d33578dca1dc96d7896a0244d7=
68:

  Update version for v3.1.0 release (2018-12-11 17:18:37 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 0e8916582991b9fd0b94850a8444b8b80d0a0955:

  i386: Add "stibp" flag name (2018-12-11 18:50:48 -0200)

----------------------------------------------------------------
x86 queue, 2018-12-11

* New CPU features: MOVDIRI, MOVDIR64B (Liu Jingqi);
  STIBP (Eduardo Habkost)
* Fix clang build warning (Peter Maydell)

----------------------------------------------------------------

Eduardo Habkost (1):
  i386: Add "stibp" flag name

Liu Jingqi (2):
  x86/cpu: Enable MOVDIRI cpu feature
  x86/cpu: Enable MOVDIR64B cpu feature

Peter Maydell (1):
  target/i386/kvm.c: Don't mark cpuid_data as QEMU_PACKED

 target/i386/cpu.h |  2 ++
 target/i386/cpu.c |  6 +++---
 target/i386/kvm.c | 10 +++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
