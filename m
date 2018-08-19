Received: from eggs.gnu.org ([2001:4830:134:3::10]:60471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1frNEE-00034b-7r
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 08:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkschreder.uk@googlemail.com>) id 1frNED-0000uu-LM
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 08:54:46 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a]:36950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mkschreder.uk@googlemail.com>)
	id 1frNED-0000tQ-GU
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 08:54:45 -0400
Received: by mail-ua1-x92a.google.com with SMTP id y10-v6so8263776uao.4
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 05:54:45 -0700 (PDT)
MIME-Version: 1.0
From: Martin Schroeder <mkschreder.uk@googlemail.com>
Date: Sun, 19 Aug 2018 14:54:33 +0200
Message-ID: <CAGmj6qti3t3dBp6OT1H_UrkUi5OvXrb1nhEyozonz6uZm2P95A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Simulating a composite machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is it possible to instantiate multiple CPUs of different architectures
and simuate them with different images at the same time? Some examples
include ARM socs with m3/m4 coprocessor core but also boards with
multiple processors where it is desirable to connect the chips over
for example virtual SPI or UART and then simulate the composite system
as a single machine where each of the cores runs a separate firmware.

Is something like this easy to implement given current processor
objects or does this require substantial changes to how qemu works?
One area I do not fully understand is native code generator and
whether it would be able to cope with two cores of *different*
architectures at the same time.
