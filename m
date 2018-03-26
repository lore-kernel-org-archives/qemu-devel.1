Received: from eggs.gnu.org ([2001:4830:134:3::10]:60363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0VKd-0000p3-4I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0VKZ-0002D2-6K
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:50:51 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:39535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f0VKZ-0002Ck-08
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:50:47 -0400
Received: by mail-pg0-x243.google.com with SMTP id b9so339696pgf.6
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 09:50:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Mar 2018 00:50:29 +0800
Message-Id: <20180326165030.875-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL for-2.12 0/1] target/hppa: Fix for glibc 2.27
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

The following changes since commit 2ffd221d07a671f72354a063d3080f244ec80b20:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-03-26 11:02:50 +0100)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-hppa-20180327

for you to fetch changes up to ebd0e151149a6280ea9f4cd9638aea517bb3238b:

  target/hppa: Include priv level in user-only iaoq (2018-03-26 22:56:57 +0800)

----------------------------------------------------------------
Fix glibc 2.27 for hppa-linux-user

----------------------------------------------------------------
Richard Henderson (1):
      target/hppa: Include priv level in user-only iaoq

 target/hppa/cpu.h       |  4 ++--
 target/hppa/translate.c | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)
