Received: from eggs.gnu.org ([2001:4830:134:3::10]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gG8qu-00075A-RW
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gG8qp-0001yR-RM
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:37:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49537 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gG8qp-0001az-Jl
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 16:36:59 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 26 Oct 2018 22:35:45 +0200
Message-Id: <1540586148-11285-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/3] target/mips: Rename MMI-related code
 elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, juergenurban@gmx.de, noring@nocrew.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series renames MMI-related code elements so that they do not
contain TX79 substring. Tx79 is one of CPUs that support MMI ASE.
Opcodes and other code elements should be as generic as possible,
and should not contain CPU name if they are supported by multiple
CPUs. In cases when there is a single-CPU-specific opcode, an
anoter special convention should apply, like, for example,
MMI_OPC__TX79_XXX or MMI_OPC__R5900_YYY. So far these cases were
not identified, but there will be some in the future. But overall,
the great MMI opcodes are shared (stay the same) between different
CPUs that support MMI.

Aleksandar Markovic (3):
  target/mips: Rename MMI-related masks
  target/mips: Rename MMI-related opcodes
  target/mips: Rename MMI-related functions

 target/mips/translate.c | 518 ++++++++++++++++++++++++------------------------
 1 file changed, 259 insertions(+), 259 deletions(-)

-- 
2.7.4
