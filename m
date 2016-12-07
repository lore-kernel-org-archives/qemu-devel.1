Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEgeI-00035R-BV
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEgeF-0005SS-7d
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:08:58 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cEgeF-0005M3-34
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:08:55 -0500
Received: by mail-qt0-f194.google.com with SMTP id m48so45630249qta.2
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 10:08:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  7 Dec 2016 10:07:25 -0800
Message-Id: <20161207180727.6286-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/2] tcg/aarch64 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org

Both of these were identified by Alex and his risu testsuite, and diagnosed
by Peter.  I believe that both bugs are my fault, originally.

The risu testsuite, as posted, now passes with an aarch64 host.


r~


Richard Henderson (2):
  tcg/aarch64: Fix addsub2 for 0+C
  tcg/aarch64: Fix tcg_out_movi

 tcg/aarch64/tcg-target.inc.c | 66 ++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

-- 
2.9.3
