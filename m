Received: from eggs.gnu.org ([2001:4830:134:3::10]:45293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0uh2-0004Lz-0r
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0ugx-0005AC-5N
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:55:40 -0400
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0ugw-00059j-W8
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:55:35 -0400
Received: by mail-pl0-x234.google.com with SMTP id m22-v6so67050pls.5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 12:55:34 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 12:54:46 -0700
Message-Id: <1522180487-22899-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 0/1] RISC-V: Critical fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

This series includes changes that are considered release critical,
such as floating point register file corruption under SMP Linux.

Michael Clark (1):
  RISC-V: Workaround for critical mstatus.FS MTTCG bug

 target/riscv/op_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.7.0
