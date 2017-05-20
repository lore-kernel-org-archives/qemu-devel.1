Received: from eggs.gnu.org ([2001:4830:134:3::10]:57956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.svk@gmail.com>) id 1dBz3p-0005b3-MT
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.svk@gmail.com>) id 1dBz3o-0007BA-U7
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:44:25 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:34507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alexander.svk@gmail.com>)
	id 1dBz3o-0007Az-Op
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:44:24 -0400
Received: by mail-oi0-x22e.google.com with SMTP id b204so115639121oii.1
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 00:44:24 -0700 (PDT)
MIME-Version: 1.0
From: Alexander Syvak <alexander.svk@gmail.com>
Date: Sat, 20 May 2017 10:44:23 +0300
Message-ID: <CA+9O3V3G8CqDuKWMP3wT2j+e7GB0B9Xe1ps22MT9eViSFEC3zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to pass intercepted mouse move x and y from host
 to a virtual machine running in Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, guys!

There exists a manually written virtual USB device registered as Qemu type.

It reads 5 bytes

- x and y of a mouse move, x and y of scrolling, and buttons state -

from mouse.fifo but there is no code in the implementation file which would
actually parse those bytes.

First where does Qemu actually parse those bytes?

And the most important - can I actually pass double value for a mouse move?

I use libinput in order to intercept host input events.
