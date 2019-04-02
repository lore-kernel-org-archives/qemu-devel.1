Received: from eggs.gnu.org ([209.51.188.92]:50306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBIGl-0001qk-EC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBIGk-0007Ir-Fa
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:11:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59626 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hBIGk-0007H7-6h
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:11:58 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue,  2 Apr 2019 14:11:48 +0200
Message-Id: <1554207110-9113-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 0/2] target/mips: Adjusting the results when
 dividing by zero in MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

The behaviour when executing DIV_<U|S>.<B|H|W|D> and MOD_<U|S>.<B|H|W|D>
differs on a referent hardware (FPGA MIPS 64 r6, little endian) and on
QEMU, when the divisor is equal to zero. That is not a real bug, because
the behaviour in that case is unpredictable (references in commit
messages).

v2:
 - Add consistency in DIV_U.df and DIV_S.df helper implementation
 - Adjust the commit messages and the cover letter, making them
   clearer and more understandable
 - Correct the spelling in the commit messages and in the cover
   letter

Mateja Marjanovic (2):
  target/mips: Make the results of DIV_<U|S>.<B|H|W|D> the same as on
    hardware
  target/mips: Make the results of MOD_<U|S>.<B|H|W|D> the same as on
    hardware

 target/mips/msa_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.7.4
