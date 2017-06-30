Received: from eggs.gnu.org ([2001:4830:134:3::10]:33267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4d-000803-HU
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQv4a-0005tJ-Cr
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:30:59 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQv4a-0005qf-15
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:30:56 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 30 Jun 2017 14:30:43 +0200
Message-Id: <20170630123050.19834-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] M68k for 2.10 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The following changes since commit 4c8c1cc544dbd5e2564868e61c5037258e393832:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-22 19:01:58 +0100)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.10-pull-request

for you to fetch changes up to a1e58ddcb3eed7ec4a158512b9dae46f90492c1b:

  target/m68k: add fmovem (2017-06-29 20:29:57 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (7):
  target/m68k: add fscc.
  target/m68k: add fmovecr
  target/m68k: add explicit single and double precision operations
  softfloat: define floatx80_round()
  target/m68k: add fsglmul and fsgldiv
  target/m68k: add explicit single and double precision operations (part
    2)
  target/m68k: add fmovem

 fpu/softfloat.c          |  16 ++
 include/fpu/softfloat.h  |   1 +
 target/m68k/fpu_helper.c | 310 ++++++++++++++++++++++++++++++++++++-
 target/m68k/helper.h     |  27 +++-
 target/m68k/translate.c  | 388 ++++++++++++++++++++++++++++++++---------------
 5 files changed, 619 insertions(+), 123 deletions(-)

-- 
2.9.4
