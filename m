Received: from eggs.gnu.org ([2001:4830:134:3::10]:60494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheYH-0005il-KB
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheYG-00060j-JT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:23:17 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:34704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fheYG-00060R-3o
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:23:16 -0400
Received: by mail-pl0-x233.google.com with SMTP id f6-v6so510914plo.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 10:23:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 23 Jul 2018 10:23:10 -0700
Message-Id: <20180723172311.11316-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL for-3.0 0/1] tcg-next patches
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

One more tcg/i386 patch for 3.0, fixing a testcase
reported over the weekend.


r~


The following changes since commit e596be90393389405c96a5c9534c4c4e2e0b5675:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180723' into staging (2018-07-23 16:15:24 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20180723

for you to fetch changes up to 672189cd586ea38a2c1d8ab91eb1f9dcff5ceb05:

  tcg/i386: Mark xmm registers call-clobbered (2018-07-23 09:21:14 -0700)

----------------------------------------------------------------
Mark xmm registers call-clobbered.

----------------------------------------------------------------
Richard Henderson (1):
      tcg/i386: Mark xmm registers call-clobbered

 tcg/i386/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
