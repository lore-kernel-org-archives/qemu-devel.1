Received: from eggs.gnu.org ([2001:4830:134:3::10]:54234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvQ-0001gZ-62
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvM-000326-H4
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvM-00031U-67
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:28 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:12 -0300
Message-Id: <20180625222524.382-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] x86 queue, 2018-06-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

The following changes since commit 35e238c9330669882487f9929e0aa979004318=
53:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180625-pull-r=
equest' into staging (2018-06-25 15:25:26 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 0b6e9aa89e02c8b213af019aad816e00ba8243f8:

  Merge branch 'master' of git://git.qemu.org/qemu into x86-next (2018-06=
-25 14:10:56 -0300)

----------------------------------------------------------------
x86 queue, 2018-06-25

* Add TOPOEXT feature to EPYC CPU model
* AMD's amd-ssbd and amd-no-ssbd CPUID features
* Removed unused CPUID flag names: ospke, osxsave
* Better formatting of '-cpu help'

----------------------------------------------------------------

Babu Moger (5):
  i386: Add support for CPUID_8000_001E for AMD
  i386: Allow TOPOEXT to be enabled on older kernels
  i386: Fix up the Node id for CPUID_8000_001E
  i386: Enable TOPOEXT feature on AMD EPYC CPU
  i386: Remove generic SMT thread check

Daniel P. Berrang=C3=A9 (3):
  i386: improve alignment of CPU model listing
  i386: improve sorting of CPU model names
  i386: display known CPUID features linewrapped, in alphabetical order

Eduardo Habkost (2):
  i386: Remove osxsave CPUID flag name
  i386: Remove ospke CPUID flag name

Konrad Rzeszutek Wilk (2):
  i386: define the AMD 'amd-ssbd' CPUID feature bit
  i386: Define AMD's no SSB mitigation needed.

 include/hw/i386/pc.h |  12 +++
 target/i386/cpu.c    | 203 +++++++++++++++++++++++++++++++++++--------
 target/i386/kvm.c    |   7 ++
 3 files changed, 188 insertions(+), 34 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
