Received: from eggs.gnu.org ([2001:4830:134:3::10]:51137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpgd-0005me-Hb
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpgc-0000KZ-SI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:07 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cjpgc-0000Jj-Lh
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:04:06 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Mar 2017 15:50:27 +0000
Message-Id: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 0/6] disas: Fix various coverity nits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>

This patchset fixes all the coverity issues for disas/:
 * dead ?: code in hppa
 * a NULL pointer deref following an internal-error case
   in i386
 * unintended sign extension after shift of unsigned char
   in m68k, microblaze, cris, arm

The hppa, i386, and arm changes won't have a visible effect
as they're either "never happens" cases or the code doesn't
care. I think m68k, microblaze and cris are genuinely
bug fixes.

Disclaimer: generally compile tested only.

thanks
-- PMM

Peter Maydell (6):
  disas/hppa: Remove dead code
  disas/i386: Avoid NULL pointer dereference in error case
  disas/m68k: Avoid unintended sign extension in get_field()
  disas/microblaze: Avoid unintended sign extension
  disas/cris: Avoid unintended sign extension
  disas/arm: Avoid unintended sign extension

 disas/arm.c        | 4 ++--
 disas/cris.c       | 4 ++--
 disas/hppa.c       | 3 +--
 disas/i386.c       | 2 +-
 disas/m68k.c       | 5 +++--
 disas/microblaze.c | 6 ++++--
 6 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.7.4
