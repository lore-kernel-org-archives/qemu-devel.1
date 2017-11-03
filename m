Received: from eggs.gnu.org ([2001:4830:134:3::10]:35364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAfNb-0008Cd-Ce
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAfNa-0007ro-Lu
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:03:39 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:57291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAfNa-0007qL-G5
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 13:03:38 -0400
Received: by mail-wr0-x236.google.com with SMTP id r79so3061541wrb.13
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 10:03:38 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 17:03:16 +0000
Message-ID: <CAFEAcA_P6=6B6mxmmueTWr0bUcHOjPZYKe7NGV62Pjsqt8r5hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] capstone ARM disassembly doesn't include hex of the
 input insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>

Debug disassembly used to look like this:

0x40801a48:  e1a0000d      mov  r0, sp

but now it looks like this:


0x40801a40:  ldr          sl, [pc, #0x94]

Can we have the hex output of the insn bytes back, please?

thanks
-- PMM
