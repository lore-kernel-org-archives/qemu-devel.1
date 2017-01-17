Received: from eggs.gnu.org ([2001:4830:134:3::10]:58775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTcmy-0000j1-TT
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTcmv-0003GW-1H
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:40 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTcmu-0003Fz-QH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:36 -0500
Received: by mail-pf0-x242.google.com with SMTP id y143so17083102pfb.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 15:03:36 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 17 Jan 2017 15:03:30 -0800
Message-Id: <20170117230332.16279-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 0/2] Fixes for x86 host
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

Fixing a regression reported by Eduardo.


r~


The following changes since commit 23eb9e6b6d5315171cc15969bbc755f258004df0:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-01-16' into staging (2017-01-17 13:53:50 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170117

for you to fetch changes up to 39f099ec9d6d420b6fe6f7f4f8ed80ae29c65ff2:

  tcg/i386: Always use TZCNT when available (2017-01-17 12:02:08 -0800)

----------------------------------------------------------------
tcg/i386 fixes

----------------------------------------------------------------
Richard Henderson (2):
      Revert "tcg/i386: Rely on undefined/undocumented behaviour of BSF/BSR"
      tcg/i386: Always use TZCNT when available

 tcg/i386/tcg-target.inc.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)
