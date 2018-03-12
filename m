Received: from eggs.gnu.org ([2001:4830:134:3::10]:37131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evTcT-0008FZ-Bf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evTcP-0000xm-0b
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evTcO-0000wc-JB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:00:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 17:00:19 -0300
Message-Id: <20180312200022.9760-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] x86 queue, 2018-03-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

The following changes since commit b16a54da0696efc5d91b6c3597a37a317abb5d=
e7:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180312-pull-requ=
est' into staging (2018-03-12 14:06:23 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to b77146e9a129bcdb60edc23639211679ae846a92:

  i386: Add support to get/set/migrate Intel Processor Trace feature (201=
8-03-12 15:59:46 -0300)

----------------------------------------------------------------
x86 queue, 2018-03-12

* Intel Processor Trace support
* KVM_HINTS_DEDICATED

----------------------------------------------------------------

Chao Peng (2):
  i386: Add Intel Processor Trace feature support
  i386: Add support to get/set/migrate Intel Processor Trace feature

Wanpeng Li (1):
  target-i386: add KVM_HINTS_DEDICATED performance hint

 target/i386/cpu.h     | 26 +++++++++++++++
 target/i386/cpu.c     | 92 +++++++++++++++++++++++++++++++++++++++++++++=
++++--
 target/i386/kvm.c     | 78 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 38 +++++++++++++++++++++
 4 files changed, 232 insertions(+), 2 deletions(-)

--=20
2.14.3
