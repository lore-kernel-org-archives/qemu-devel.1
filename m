Received: from eggs.gnu.org ([209.51.188.92]:33819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1gnBob-00038T-OX
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1gnBoa-0003no-Lf
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:27:17 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:39293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1gnBoa-0003mG-Az
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:27:16 -0500
Received: by mail-it1-x144.google.com with SMTP id a6so12192679itl.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20190124040457.2546-1-doug16k@gmail.com>
	<CAFEAcA9fVkGEMPUaSapn6YOV0DR_rS17pWKZHTxQz0aCM+et3g@mail.gmail.com>
	<CAEfK_460635_tXwDLoKGhMQ7smz0Gy2OVLBMQpU8GrhxA02ywA@mail.gmail.com>
	<CAFEAcA9AhBLS4J+bsv_srq0qw1PXeUF346Y_J0cujgfH+tFOJg@mail.gmail.com>
In-Reply-To: <CAFEAcA9AhBLS4J+bsv_srq0qw1PXeUF346Y_J0cujgfH+tFOJg@mail.gmail.com>
From: Doug Gale <doug16k@gmail.com>
Date: Fri, 25 Jan 2019 20:57:02 -0330
Message-ID: <CAEfK_44+aLer5OoaE__XWmvyiPdRvxOt=FM4pTBApwEqUns4fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Fix i386/x86_64 machine
 description and add control registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 25, 2019 at 6:22 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

>
> Thanks for this explanation -- the patch makes a lot more sense with it.
> I'm confused though -- the XML we ship is basically what gdb itself
> ships and uses internally:
>
> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gdb/features/i386/i386.xml;h=beb1496d9773efcf0e0526dc540a5e206a2e21fc;hb=HEAD
>
> and that uses xi:include to pull in the other files.
> So it seems odd that gdb can't parse the XML it is using
> itself internally. Maybe QEMU is doing something else wrong
> somewhere?
>
>
I thought that too. I implemented gdbstub tracing a while ago and had it
enabled (-trace gdb*). The binary data it sends is exactly what I expect.
When I break into gdb, I checked the data and it looked correct. debug_xml
even prints out what it's going to parse. Looks fine. GDB calls into an XML
parser library, which I don't have built from source, so I didn't find
precisely where it fails, only the high level log showing unexpected
elements at nested feature.
