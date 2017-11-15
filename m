Received: from eggs.gnu.org ([2001:4830:134:3::10]:34470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEwwa-0006r3-62
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEwwX-0006MH-1B
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:28 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eEwwW-0006M3-Q8
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:37:24 -0500
Received: by mail-wr0-x241.google.com with SMTP id u97so20381309wrc.1
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 04:37:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 15 Nov 2017 13:35:17 +0100
Message-Id: <20171115123520.7464-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-2.11 0/3] tcg: user-mode memory helper fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Fixes the issue that Peter found wrt javac on aarch64-linux-user.


r~


The following changes since commit 1fa0f627d03cd0d0755924247cafeb42969016bf:

  Update version for v2.11.0-rc1 release (2017-11-14 18:37:49 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20171115

for you to fetch changes up to 3c5f9c3f35dd3b6d1d1cd68c9d4d86fc3c59c397:

  target/arm: Fix GETPC usage in do_paired_cmpxchg64_l/be (2017-11-15 10:34:33 +0100)

----------------------------------------------------------------
User-mode memory helper fixes

----------------------------------------------------------------
Richard Henderson (3):
      tcg: Record code_gen_buffer address for user-only memory helpers
      target/arm: Use helper_retaddr in stxp helpers
      target/arm: Fix GETPC usage in do_paired_cmpxchg64_l/be

 accel/tcg/atomic_template.h               | 32 +++++++++++++----
 include/exec/cpu_ldst.h                   |  2 ++
 include/exec/cpu_ldst_useronly_template.h | 14 ++++++--
 accel/tcg/cputlb.c                        |  1 +
 accel/tcg/user-exec.c                     | 58 +++++++++++++++++++++++++------
 target/arm/helper-a64.c                   | 20 ++++++-----
 6 files changed, 99 insertions(+), 28 deletions(-)
