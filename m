Received: from eggs.gnu.org ([209.51.188.92]:43388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hG9yG-0003zO-Rr
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hG9yE-0002fM-Vd
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:21:00 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e]:41430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hG9yC-0002dW-Uy
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 18:20:57 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id a13so4081255ybl.8
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 15:20:54 -0700 (PDT)
MIME-Version: 1.0
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 15 Apr 2019 15:20:42 -0700
Message-ID: <CAMo8BfLCON2wbQ36dkVQ92tcVPWoPdje12CqySFnJyoYDDOdDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] recent QEMU-w64 does not load multiboot kernels by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

Hello,

recent qemu-system-i386 for w64 (e.g. one installed from
https://qemu.weilnetz.de/w64/qemu-w64-setup-20190218.exe )
refuses to load multiboot kernel by default:

  "C:\Program Files\qemu\qemu-system-i386.exe" -kernel p:\tmp\kernel
  C:\Program Files\qemu\qemu-system-i386.exe: Error loading
uncompressed kernel without PVH ELF Note

Adding -M pc-i440fx-3.1 (as well as most other machines, but not
pc-i440fx-4.0) fixes that. On linux host the same kernel gets loaded
either way (with or without -M).

-- 
Thanks.
-- Max
