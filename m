Received: from eggs.gnu.org ([2001:4830:134:3::10]:41614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zk-00045y-DF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zg-0008Qf-1U
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:56 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:36464)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1db4zf-0008P0-SI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:07:51 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 28 Jul 2017 14:07:43 +0100
Message-ID: <1501247265-22367-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 871a0f7ad2b9560c5f7d640125c5be95ca23ca=
7f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170728' into =
staging (2017-07-28 10:35:02 +0100)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170728

for you to fetch changes up to 665df9010aa40d1e028d6ad5d3bdb4d9b0a3294c:

  Revert "elf-loader: warn about invalid endianness" (2017-07-28 13:32:32=
 +0100)

----------------------------------------------------------------
MIPS patches 2017-07-28

Changes:
* Improve ths MIPS board kernel load error reporting
* Revert unnecessary warning messages

----------------------------------------------------------------

Alexey Kardashevskiy (1):
  Revert "elf-loader: warn about invalid endianness"

Aurelien Jarno (1):
  hw/mips: load_elf_strerror to report kernel loading failure

 hw/core/loader.c        |  1 -
 hw/mips/mips_fulong2e.c | 15 +++++++++------
 hw/mips/mips_malta.c    | 14 ++++++++------
 hw/mips/mips_mipssim.c  |  5 +++--
 hw/mips/mips_r4k.c      |  6 ++++--
 5 files changed, 24 insertions(+), 17 deletions(-)

--=20
2.7.4
