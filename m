Received: from eggs.gnu.org ([2001:4830:134:3::10]:43195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpen-0001sf-QA
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpek-00043Y-Of
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:57 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edpek-00042i-GX
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:54 -0500
Received: by mail-pg0-x244.google.com with SMTP id q67so8762741pga.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:53:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 19:53:44 -0800
Message-Id: <20180123035349.24538-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/5] target/arm: Preparatory work for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Based on PMM's target-arm.next branch, which now has most of v2.

While looking again at ZCR_ELx, I think that there's an existing
bug in the FPCR/FPSR system registers, wherein we do not have an
access function for when the FPU is disabled.


r~


Richard Henderson (5):
  target/arm: Expand vector registers for SVE
  target/arm: Add predicate registers for SVE
  target/arm: Add SVE to migration state
  target/arm: Add ZCR_ELx
  target/arm: Add SVE state to TB->FLAGS

 target/arm/cpu.h           |  84 ++++++++++++++++++------
 target/arm/translate.h     |   2 +
 target/arm/helper.c        | 156 ++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/machine.c       |  88 ++++++++++++++++++++++++-
 target/arm/translate-a64.c |  10 +--
 target/arm/translate.c     |   7 +-
 6 files changed, 318 insertions(+), 29 deletions(-)

-- 
2.14.3
