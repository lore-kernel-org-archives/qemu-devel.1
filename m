Received: from eggs.gnu.org ([209.51.188.92]:40887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCk0-0000pR-Ug
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCjz-0002ag-5x
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1goCjy-0002Yb-T2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:43 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 28 Jan 2019 17:38:32 -0200
Message-Id: <20190128193834.3823-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] x86 queue, 2019-01-28
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

The following changes since commit 5f39a91dbd9a186edb999afd4d17524f4b1da14f:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-01-28 12:54:06 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 9fe8b7be17eaac4cfde4083000cc96747d7cf4f8:

  i386: Enable NPT and NRIPSAVE for AMD CPUs (2019-01-28 15:51:54 -0200)

----------------------------------------------------------------
x86 queue, 2019-01-28

Two small CPU model updates:
* Enable NPT and NRIPSAVE on AMD CPUs
* Update stepping of Cascadelake-Server

----------------------------------------------------------------

Tao Xu (1):
  i386: Update stepping of Cascadelake-Server

Vitaly Kuznetsov (1):
  i386: Enable NPT and NRIPSAVE for AMD CPUs

 hw/i386/pc.c      |  9 +++++++++
 target/i386/cpu.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.18.0.rc1.1.g3f1ff2140
