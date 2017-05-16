Received: from eggs.gnu.org ([2001:4830:134:3::10]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlTn-0007y2-Nr
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlTm-0002dZ-VR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:11 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dAlTm-0002cz-PP
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:10 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 17 May 2017 01:01:55 +0200
Message-Id: <20170516230159.4195-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] target/arm, cris,
 mips: optimize "swap bytes within words"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

This patchset optimizes the "swap bytes within words" instructions on the
arm, cris and mips targets. It all started with the patchset from Philippe
Mathieu-Daudé optimizing TCG code by using the extract op. Looking at the
patch I have found that the aarch64 rev16 function can be optimized even
more. Richard Henderson then suggested an even more optimized version.

Aurelien Jarno (4):
  target/arm: optimize aarch32 rev16
  target/arm: simplify and optimize aarch64 rev16
  target/cris: optimize swap
  target/mips: optimize WSBH, DSBH and DSHD

 target/arm/translate-a64.c | 24 ++++++------------------
 target/arm/translate.c     |  6 ++++--
 target/cris/translate.c    | 15 +++++++--------
 target/mips/translate.c    | 18 ++++++++++++------
 4 files changed, 29 insertions(+), 34 deletions(-)

-- 
2.11.0
