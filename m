Received: from eggs.gnu.org ([2001:4830:134:3::10]:35553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhuh-0008Kr-Uc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhue-0000zd-Bg
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fIhue-0000zF-5W
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 15 May 2018 18:54:29 -0300
Message-Id: <20180515215436.6457-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] x86 queue, 2018-05-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

The following changes since commit ad1b4ec39caa5b3f17cbd8160283a03a3dcfe2ae:

  Merge remote-tracking branch 'remotes/kraxel/tags/input-20180515-pull-request' into staging (2018-05-15 12:50:06 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to ab8f992e3e63e91be257e4e343d386dae7be4bcb:

  i386: Add new property to control cache info (2018-05-15 11:33:33 -0300)

----------------------------------------------------------------
x86 queue, 2018-05-15

* KnightsMill CPU model
* CLDEMOTE(Demote Cache Line) cpu feature
* pc-i440fx-2.13 and pc-q35-2.13 machine-types
* Add model-specific cache information to EPYC CPU model

----------------------------------------------------------------

Babu Moger (4):
  i386: Add cache information in X86CPUDefinition
  i386: Initialize cache information for EPYC family processors
  pc: add 2.13 machine types
  i386: Add new property to control cache info

Boqun Feng (1):
  i386: add KnightsMill cpu model

Eduardo Habkost (1):
  i386: Helpers to encode cache information consistently

Jingqi Liu (1):
  x86/cpu: Enable CLDEMOTE(Demote Cache Line) cpu feature

 include/hw/i386/pc.h |   8 +
 target/i386/cpu.h    |  66 ++++++
 hw/i386/pc_piix.c    |  15 +-
 hw/i386/pc_q35.c     |  13 +-
 target/i386/cpu.c    | 635 +++++++++++++++++++++++++++++++++++++++++----------
 5 files changed, 608 insertions(+), 129 deletions(-)

-- 
2.14.3
