Received: from eggs.gnu.org ([209.51.188.92]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9Z-0000w9-Ke
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDS9X-0001lg-MU
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDS9W-0001ke-TK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:09:27 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  8 Apr 2019 13:09:17 +0200
Message-Id: <20190408110920.30119-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Fixes for libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jafar Abdi <cafer.abdi@gmail.com>, dgilbert@redhat.com

 Hi Peter,

the following changes since commit f55a585d1037e5de6088f25e75443c2776786e=
29:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-04-07 14:54:55 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git pull-request-2019-04-08

for you to fetch changes up to c19f2b711e15dac4c2cdbace2f8fb3a45fbed0d2:

  test qgraph.c: Fix segs due to out of scope default (2019-04-08 12:38:0=
7 +0200)

----------------------------------------------------------------
- Fix a crash in libqos with GCC 9
- Fix usage of wrong boolean types in libqos
----------------------------------------------------------------

Dr. David Alan Gilbert (1):
      test qgraph.c: Fix segs due to out of scope default

Jafar Abdi (2):
      tests/libqos: fix usage of bool in pci-pc.c
      tests/libqos: fix usage of bool in pci-spapr.c

 tests/libqos/pci-pc.c    | 2 +-
 tests/libqos/pci-spapr.c | 2 +-
 tests/libqos/qgraph.c    | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)
