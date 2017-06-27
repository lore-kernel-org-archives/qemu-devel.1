Received: from eggs.gnu.org ([2001:4830:134:3::10]:37844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPuEf-0002aZ-BJ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPuEe-0005z6-Hb
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:25:09 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPuEe-0005xF-9J
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:25:08 -0400
Received: by mail-wm0-x22d.google.com with SMTP id i127so33974072wma.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 10:25:08 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 18:24:46 +0100
Message-ID: <CAFEAcA-wYgWeYdFRAcW-DhqsFRsy_iKF+WU6qt7UbUKZ+EK1eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Getting rid of xen_init_display() (and its dubious
 call into main_loop_wait())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>

So, there is exactly one caller of main_loop_wait() in the tree that
passes it 'true' as an argument. That caller is in xen_init_display()
in hw/dispaly/xenfb.c. The function was added in 2009 with the comment
"FIXME/TODO: Kill this. Temporary needed while DisplayState
reorganization is in flight."

I'd like to think that we've now completed whatever reorg that was,
8 years on, so can we now get rid of this function? It definitely
seems very dubious to have a display init function with a busy loop
and a call into main_loop_wait()...

thanks
-- PMM
