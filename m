Received: from eggs.gnu.org ([2001:4830:134:3::10]:35146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddKbm-0006O8-9k
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddKbi-0003A2-Up
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:30 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddKbi-00038m-PB
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:12:26 -0400
Received: by mail-pf0-x241.google.com with SMTP id t83so2184083pfj.3
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 11:12:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 11:12:21 -0700
Message-Id: <20170803181224.21748-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-2.10 0/3] TCG misc patches
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

Two of these have been posted before.  The third I discovered in
testing on a Sparc host yesterday.


r~


The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519c8:

  Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170803

for you to fetch changes up to 13aaef678ed377b12b76dc7fb9e615b2f2f9047b:

  tcg: Increase minimum alignment from tcg_malloc to 8 (2017-08-03 11:00:30 -0700)

----------------------------------------------------------------
Queued misc tcg patches

----------------------------------------------------------------
Richard Henderson (3):
      tcg/arm: Fix runtime overalignment test
      target/s390x: Fix CSST for 16-byte store
      tcg: Increase minimum alignment from tcg_malloc to 8

 tcg/tcg.h                 | 5 ++++-
 target/s390x/mem_helper.c | 1 +
 tcg/arm/tcg-target.inc.c  | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)
