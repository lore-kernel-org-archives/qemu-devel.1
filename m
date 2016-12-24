Received: from eggs.gnu.org ([2001:4830:134:3::10]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdHB-0001Nm-4t
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdH9-00052e-NI
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:45:41 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdH9-00052O-CV
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:45:39 -0500
Received: by mail-pg0-x244.google.com with SMTP id n5so2449656pgh.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 19:45:39 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:45:18 -0800
Message-Id: <20161224034536.12028-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/2] tcg/s390 improvements
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

One bug fix, one cleanup.


r~



The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20161223

for you to fetch changes up to e45d4ef6e345831c8d67a5bffe0d057efc20f4ff:

  tcg/s390: Remove 'R' constraint (2016-12-23 19:38:27 -0800)

----------------------------------------------------------------
queued s390 host fixes

----------------------------------------------------------------
Richard Henderson (2):
      tcg/s390: Fix setcond expansion
      tcg/s390: Remove 'R' constraint

 tcg/s390/tcg-target.inc.c | 75 +++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 35 deletions(-)
