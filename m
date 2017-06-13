Received: from eggs.gnu.org ([2001:4830:134:3::10]:55373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antoniogroza@gmail.com>) id 1dKkPM-00012u-T5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antoniogroza@gmail.com>) id 1dKkPM-0007hY-7F
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:54:52 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antoniogroza@gmail.com>)
	id 1dKkPM-0007gs-0C
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:54:52 -0400
Received: by mail-wr0-x231.google.com with SMTP id 36so17639926wry.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 04:54:50 -0700 (PDT)
MIME-Version: 1.0
From: Antonio Groza <antoniogroza@gmail.com>
Date: Tue, 13 Jun 2017 11:54:38 +0000
Message-ID: <CABUdOL7gP=h8deWfuxz01eER2DkUFkFLZSdQcGhDJFzcmzGyZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Emulation without RWX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello, i am trying to emulate x86 on a platform that won't allow me to map
memory pages as RWX(Apple's iOS) and i was wondering if there was any way
of running qemu without doing that. I've had a brief look at your
documentation and it looks like you are transpiling between 2 different
instruction sets and i don't know how that would be possible without a rwx
page.

Sorry for wasting your time with stupid questions,
-Antonio
