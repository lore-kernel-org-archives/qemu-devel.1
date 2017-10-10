Received: from eggs.gnu.org ([2001:4830:134:3::10]:37482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1e1opu-0007DX-Sp
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1e1opo-0004WX-OH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:20:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1e1opo-0004Tg-5j
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 03:20:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id q124so23992303wmb.5
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 00:20:10 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <88c14424-9813-5e68-0aa7-38f3cde0a491@tuxfamily.org>
Date: Tue, 10 Oct 2017 09:20:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-system-nios2 hangs when emulator is quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

 Hi Chris, hi Marek,

I recently noticed that when I start qemu-system-nios2 (build from the
very latest git master branch) and then type "quit" at the monitor (or
simply try to close the GTK window), QEMU does not shut down right and
hangs somewhere in pause_all_vcpus() forever.
Do you have any idea what might be wrong here?

 Thanks,
  Thomas
