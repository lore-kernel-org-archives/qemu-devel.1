Received: from eggs.gnu.org ([2001:4830:134:3::10]:47178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wonsange@gmail.com>) id 1fQkDZ-000558-BY
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 22:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wonsange@gmail.com>) id 1fQkDY-0004r6-GK
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 22:00:01 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:37323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wonsange@gmail.com>) id 1fQkDY-0004pE-8z
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 22:00:00 -0400
Received: by mail-io0-x22f.google.com with SMTP id s26-v6so9974488ioj.4
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 18:59:59 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?7Jyg7JuQ7IOB?= <wonsange@gmail.com>
Date: Thu, 7 Jun 2018 10:59:58 +0900
Message-ID: <CA+EEy5tzuVnfQRicNC9XA+GvA1bB4TuaS21b32_Y_oc9rxY3kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Enable the Multisampling with virglrenderer using SDL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,
This is Wonsang Ryu.

I'm developing the open embedded OS using QEMU with virglrenderer.
Our OS is very light, so it doesn't support multi resolution.
Our OS supports only 1920x1080.
So, we want to resize to 1280x720 the QEMU window for developers.
If QEMU window size is 1920x1080, it is clear.
But, in small window size, it does not clear.

So, we want to use multisampling(anti-aliasing) in QEMU.

I checked the virglrenderer has multisampling feature in code,
but QEMU does not use it.
Does multisampling support in QEMU with virglrenderer?
How can I enable the multisampling feature of GLES in QEMU?

Please help or advise me.
Thanks.
