Received: from eggs.gnu.org ([2001:4830:134:3::10]:58016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgMe3-0007Zk-As
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgMdz-0000jU-Bj
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:03:55 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:38587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgMdz-0000jG-35
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:03:51 -0400
Received: by mail-pl0-x229.google.com with SMTP id b1-v6so4573948pls.5
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 21:03:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Jul 2018 21:03:36 -0700
Message-Id: <20180720040337.21426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.0 0/1] tcg-next pull
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

Just one patch for rc2, fixing a bug with an aarch64 host
emulating sve instructions.


r~


The following changes since commit e1ea55668ffe6ce558a063f3a9621b761738e1f2:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-07-19 15:38:06 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20180719

for you to fetch changes up to e65a5f227d77a5dbae7a7123c3ee915ee4bd80cf:

  tcg/aarch64: limit mul_vec size (2018-07-19 09:07:31 -0700)

----------------------------------------------------------------
Fix aarch64 host vector mul

----------------------------------------------------------------
Alex Bennée (1):
      tcg/aarch64: limit mul_vec size

 tcg/aarch64/tcg-target.inc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
