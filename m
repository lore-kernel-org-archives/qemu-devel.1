Received: from eggs.gnu.org ([2001:4830:134:3::10]:46519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyDFs-00031X-37
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyDFn-0002OG-5A
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eyDFm-0002N1-Ra
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Mar 2018 10:08:11 +0100
Message-Id: <20180320090813.852-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] M68k for 2.12 patches
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

The following changes since commit 55901900ec69d6fd6f332003d8ab81b2f8a38529:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.12-pull-request' into staging (2018-03-15 17:58:28 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to ecc207d2fc1d45fabb16c38742a6675a7ba56cbc:

  target/m68k: add a mechanism to automatically free TCGv (2018-03-20 09:38:58 +0100)

----------------------------------------------------------------
This series of patches is needed to fix a problem
in the m68k translator that can crash QEMU when translation
cache has too many instructions:

  qemu-m68k: tcg/tcg.c:883: tcg_temp_alloc: Assertion `n < 512' failed.
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

I have reproduced it in linux user mode, with "ghc", and in
system mode with the debian-installer for unstable distro
from debian-ports.
----------------------------------------------------------------

Laurent Vivier (2):
  target/m68k: add DisasContext parameter to gen_extend()
  target/m68k: add a mechanism to automatically free TCGv

 target/m68k/translate.c | 102 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 36 deletions(-)

-- 
2.14.3
