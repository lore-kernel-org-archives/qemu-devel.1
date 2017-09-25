Received: from eggs.gnu.org ([2001:4830:134:3::10]:57840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwbgR-0006SB-2O
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwbgM-0006Tf-Vj
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:16:59 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:49513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwbgM-0006TS-Mu
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:16:54 -0400
Received: by mail-pf0-x230.google.com with SMTP id l188so4522357pfc.6
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 15:16:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 25 Sep 2017 15:16:49 -0700
Message-Id: <20170925221650.2190-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] tcg patch queue
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

Just one patch, but should make stable 2.10.1 this week.


r~


The following changes since commit 460b6c8e581aa06b86f59eebd9e52edfe7adf417:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-09-23 12:55:40 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170925

for you to fetch changes up to 8b81253332b5a3f3c67b6462f39caef47a00dd29:

  accel/tcg/cputlb: avoid recursive BQL (fixes #1706296) (2017-09-25 11:23:30 -0700)

----------------------------------------------------------------
BQL bug fix

----------------------------------------------------------------
Alex Bennée (1):
      accel/tcg/cputlb: avoid recursive BQL (fixes #1706296)

 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
