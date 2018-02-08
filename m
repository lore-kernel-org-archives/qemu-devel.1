Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1ejj6S-0007CG-0d
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1ejj6M-0000TV-Dw
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:06:51 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:41031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ramysameh26@gmail.com>)
	id 1ejj6M-0000TA-6w
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:06:46 -0500
Received: by mail-ot0-x22a.google.com with SMTP id r23so3787651ote.8
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 02:06:45 -0800 (PST)
MIME-Version: 1.0
From: Ramy Sameh <ramysameh26@gmail.com>
Date: Thu, 8 Feb 2018 12:06:44 +0200
Message-ID: <CAF6HrYx6fKVAACMN1TFV_9xKU42RP1yULQpwjvV9jtDExZq8JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Questions regarding how QEMU initializes virtual
 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Mona Safar <Mona.Safar@eng.asu.edu.eg>, Watheq <watheq@gmail.com>, Ahmed Aly <ahmedaly50@gmail.com>

Hello all,

I am working with QEMU to simulate VersatilePB board.

I am trying to understand how QEMU initialize the virtual peripherals (e.g.
UART, vectored Interrupt controller .. etc).

When I traced the code, I found a function called "object_init_with_type"
in object.c, in which the function pointer "ti->instance_init(obj)" seems
to call the peripherals initialization functions.

*I have couple of questions here:*
1.) Some peripheral initialization functions are called multiple times such
as pl011_init, why is that ?
2.) Where is the entry point for the whole initialization functionalities
(that will eventually call "object_init_with_type")

Thank you.

-- 
Best Regards,
Ramy Sameh
Embedded Software Engineer
