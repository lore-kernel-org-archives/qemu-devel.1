Received: from eggs.gnu.org ([2001:4830:134:3::10]:44179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d4qDj-0006Um-5D
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d4qDi-0006cS-G6
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:46994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d4qDi-0006bs-AU
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 30 Apr 2017 16:52:51 +0200
Message-Id: <20170430145254.25616-1-aurelien@aurel32.net>
In-Reply-To: <20170427120006.20564-1-rth@twiddle.net>
References: <20170427120006.20564-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5++] TCG cross-tb optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Aurelien Jarno <aurelien@aurel32.net>

Please find patches to support cross-tb optimizations on MIPS hosts
and to implement cross-tb optimizations for MIPS target.

Aurelien Jarno (3):
  tcg/mips: implement goto_ptr
  target/mips: optimize cross-page direct jumps in softmmu
  target/mips: optimize indirect branches

 target/mips/translate.c   |  4 ++--
 tcg/mips/tcg-target.h     |  2 +-
 tcg/mips/tcg-target.inc.c | 13 +++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.11.0
