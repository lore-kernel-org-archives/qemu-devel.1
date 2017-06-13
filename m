Received: from eggs.gnu.org ([2001:4830:134:3::10]:38277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKlBU-00025E-C0
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKlBT-0007EF-Jn
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:44:36 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKlBT-0007E4-Cb
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:44:35 -0400
Received: by mail-wr0-x230.google.com with SMTP id v104so135321863wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 05:44:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABUdOL7gP=h8deWfuxz01eER2DkUFkFLZSdQcGhDJFzcmzGyZw@mail.gmail.com>
References: <CABUdOL7gP=h8deWfuxz01eER2DkUFkFLZSdQcGhDJFzcmzGyZw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 13:44:11 +0100
Message-ID: <CAFEAcA-7MMVi-ubFGi9882WMgYUWMcbLiF9MVOT+cg-1A20cgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Emulation without RWX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antonio Groza <antoniogroza@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 June 2017 at 12:54, Antonio Groza <antoniogroza@gmail.com> wrote:
> Hello, i am trying to emulate x86 on a platform that won't allow me to map
> memory pages as RWX(Apple's iOS) and i was wondering if there was any way
> of running qemu without doing that. I've had a brief look at your
> documentation and it looks like you are transpiling between 2 different
> instruction sets and i don't know how that would be possible without a rwx
> page.

It's certainly possible in theory -- you'd just need to be more
careful than we are currently about mapping the memory RW when
writing or patching code and then R-X when executing. (Now we're
multithreaded this is probably trickier than when we only had
a single thread, though.) But we don't do it currently and it
would require (possibly complicated) code changes to do it.

thanks
-- PMM
