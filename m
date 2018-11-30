Received: from eggs.gnu.org ([2001:4830:134:3::10]:52468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqi4-0007qB-4n
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqi0-00068a-VE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:28 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:44623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSqi0-00063z-Nh
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:24 -0500
Received: by mail-pg1-x533.google.com with SMTP id t13so3035959pgr.11
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 13:52:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 13:52:05 -0800
Message-Id: <20181130215221.20554-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/16] tcg: Assorted cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

In review of v2, Alex asked for patch 3 to be broken apart.
Here, patches 3-16 are that breakup.  I've omitted the rest
of the v2 patchset for now; I have yet to make substantive
changes to those.


r~


Richard Henderson (16):
  tcg/i386: Always use %ebp for TCG_AREG0
  tcg/i386: Move TCG_REG_CALL_STACK from define to enum
  tcg/aarch64: Remove reloc_pc26_atomic
  tcg/aarch64: Fold away "noaddr" branch routines
  tcg/arm: Remove reloc_pc24_atomic
  tcg/arm: Fold away "noaddr" branch routines
  tcg/ppc: Fold away "noaddr" branch routines
  tcg/s390: Remove retranslation code
  tcg/sparc: Remove retranslation code
  tcg/mips: Remove retranslation code
  tcg: Return success from patch_reloc
  tcg/i386: Return false on failure from patch_reloc
  tcg/aarch64: Return false on failure from patch_reloc
  tcg/arm: Return false on failure from patch_reloc
  tcg/ppc: Return false on failure from patch_reloc
  tcg/s390x: Return false on failure from patch_reloc

 tcg/i386/tcg-target.h        | 10 ++----
 tcg/aarch64/tcg-target.inc.c | 69 ++++++++++++------------------------
 tcg/arm/tcg-target.inc.c     | 55 +++++++++++-----------------
 tcg/i386/tcg-target.inc.c    |  7 ++--
 tcg/mips/tcg-target.inc.c    | 10 ++----
 tcg/ppc/tcg-target.inc.c     | 60 +++++++++++++++----------------
 tcg/s390/tcg-target.inc.c    | 45 +++++++++++++----------
 tcg/sparc/tcg-target.inc.c   | 13 +++----
 tcg/tcg.c                    |  8 +++--
 tcg/tci/tcg-target.inc.c     |  3 +-
 10 files changed, 122 insertions(+), 158 deletions(-)

-- 
2.17.2
