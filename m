Received: from eggs.gnu.org ([209.51.188.92]:53448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hAy64-0004SR-56
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hAy62-0003e9-9V
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:39:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44900 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hAy60-0002ps-C4
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:39:33 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  1 Apr 2019 16:38:19 +0200
Message-Id: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/2] target/mips: Integer division by zero in
 MSA insturctions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Integer division by zero in MSA insturctions results in unpredictable
behaviour, but according to the hardware, it depends on the sign of
the dividend, or always returns the same value.

Mateja Marjanovic (2):
  target/mips: DIV_<U|S>.<B|H|W|D> MSA insturctions fixed
  target/mips: MOD_<U|S>.<B|H|W|D> MSA insturctions fixed

 target/mips/msa_helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.7.4
