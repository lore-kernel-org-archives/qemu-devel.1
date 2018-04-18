Received: from eggs.gnu.org ([2001:4830:134:3::10]:37612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f8k9W-0000Vr-PK
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f8k9S-0003tM-RJ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:26 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:50328
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1f8k9S-0003ry-JK
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:22 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Wed, 18 Apr 2018 12:16:46 +0200
Message-Id: <1524046608-12906-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH v1 0/2] riscv: htif fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: frederic.konrad@adacore.com, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de

Hi all,
 
Here are some fixes for the HTIF device.

I saw some changing behavior since I use qemu upstream instead of the RISC-V
fork because the htif can't be based to 0 anymore. The first patch address
that issue.

The second patch fixes the priority of the htif subregion as I don't think we
guarantee which region get accessed when two subregions have the same
priority.

Thanks,
Fred

KONRAD Frederic (2):
  riscv: spike: allow base == 0
  riscv: htif: increase the priority of the htif subregion

 hw/riscv/riscv_htif.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
1.8.3.1
