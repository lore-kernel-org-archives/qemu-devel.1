Received: from eggs.gnu.org ([2001:4830:134:3::10]:54039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEIK1-0000y0-RI
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEIK0-0005iD-TK
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:14:57 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:43446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEIK0-0005hi-NL
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:14:56 -0500
Received: by mail-wr0-x22e.google.com with SMTP id 4so15088506wrt.0
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:14:56 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 17:14:34 +0000
Message-ID: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow v1
 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

I have a qcow v1 file which I created by mistake (forgetting that
you need to tell qemu-img create 'qcow2' and not just 'qcow'),
which I want to convert to a v2 file so I can put snapshots into
it. But when I try to do this with qemu-img convert it creates a
v3 file instead:

$ file hda-old.qcow
hda-old.qcow: QEMU QCOW Image (v1), 5368709120 bytes
$ build/x86/qemu-img convert -O qcow2 hda-old.qcow hda.qcow2
$ file hda.qcow2
hda.qcow2: QEMU QCOW Image (v3), 5368709120 bytes

and if you then try to use that in QEMU it complains:

qemu-system-aarch64: -drive if=none,file=hda.qcow2,format=qcow,id=hd:
Unsupported qcow version 3

What am I missing here?

thanks
-- PMM
