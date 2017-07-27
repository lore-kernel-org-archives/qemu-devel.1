Received: from eggs.gnu.org ([2001:4830:134:3::10]:60352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1daZru-0001Kh-8g
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 23:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1daZrt-0007bx-F5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 23:53:46 -0400
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:37891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1daZrt-0007aJ-6i
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 23:53:45 -0400
Received: by mail-ua0-x235.google.com with SMTP id w45so131456048uac.5
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 20:53:43 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Thu, 27 Jul 2017 11:53:41 +0800
Message-ID: <CAB3eZfszxeKpkXHfm-EVtfeZCL1Spz0z2x2vS5KbVezLPjwfXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] why marking qcow2 img as corrupted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I tried take snapshots on a demo.qcow2 10 times.
cmd is below:

> qemu-img snapshots -c tag_1 demo.qcow2


when I take snapshots 7 times and console shows:

> mark image as corrupted and preventing from invalid write


and I can't take snapshots anymore then.
Can I avoid this situation or remove the limit?
