Received: from eggs.gnu.org ([2001:4830:134:3::10]:41965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVwZ-0005UR-Ql
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVwV-0000Hr-Q1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:47:07 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ciVwV-0000Hd-LT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:47:03 -0500
Received: by mail-qk0-x244.google.com with SMTP id r90so21174954qki.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:47:03 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 28 Feb 2017 11:46:50 +1100
Message-Id: <20170228004651.20674-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL] Enable MTTCG for target/alpha
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

Thanks to Alex for the heroics getting the patch set in.
This is a tiny follow-up to enable it for Alpha.


r~


The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe51:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-02-27-1' into staging (2017-02-27 15:33:21 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-axp-20170228

for you to fetch changes up to 5ee4f3c2c750ce55f825116610beb3340daedeca:

  target/alpha: Enable MTTCG by default (2017-02-28 11:41:46 +1100)

----------------------------------------------------------------
Enable MTTCG for Alpha guest

----------------------------------------------------------------
Richard Henderson (1):
      target/alpha: Enable MTTCG by default

 configure          | 1 +
 target/alpha/cpu.h | 3 +++
 2 files changed, 4 insertions(+)
