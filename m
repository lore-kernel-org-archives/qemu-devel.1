Received: from eggs.gnu.org ([2001:4830:134:3::10]:39234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEFz6-0004SM-2M
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEFz5-0003DT-7Q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:17:28 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu,  3 May 2018 17:17:13 +0200
Message-Id: <1525360636-18229-1-git-send-email-frederic.konrad@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V2 0/3] riscv: some little fix.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: mjc@sifive.com, kbastian@mail.uni-paderborn.de, f4bug@amsat.org, peter.maydell@linaro.org, frederic.konrad@adacore.com

Hi all,

Here are some fixes for RISCV.

The two firsts allow to map the HTIF @0x00000000.
The third one requires fdt to be present on the build machine so the buil=
d
doesn't end with a linker error.

Thanks,
Fred

KONRAD Frederic (3):
  riscv: spike: allow base =3D=3D 0
  riscv: htif: increase the priority of the htif subregion
  riscv: requires libfdt

 configure             |  2 +-
 hw/riscv/riscv_htif.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

--=20
1.8.3.1
