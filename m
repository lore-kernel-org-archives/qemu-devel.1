Received: from eggs.gnu.org ([2001:4830:134:3::10]:54043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1eihC2-0006JT-Ji
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1eihC1-0004MI-71
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:52:22 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1eihC1-0004LN-18
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:52:21 -0500
Received: by mail-oi0-x243.google.com with SMTP id c8so21194911oiy.9
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:52:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Mon, 5 Feb 2018 16:52:19 +0300
Message-ID: <CAE5jQCcDUmaTc0xM6RLppL7xfOmqkAkcirXNAgyTukBFHMaXTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/1] Fix unaligned reads in the tcg/tci.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, Richard Henderson <rth@twiddle.net>

Ping.
Patchwork link: http://patchwork.ozlabs.org/patch/866732/
Patchew link:
http://patchew.org/QEMU/20180127134908.24095-1-anatoly.trosinenko@gmail.com/

(Initially forgot to add Richard Henderson to CC.)

2018-01-27 16:49 GMT+03:00 Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
:

> The code in tcg/tci.c reads some data from TCI bytecode through
> pointer dereferencing. As far as I know unaligned reads in such a way are
> undefined behavior and compiling with -fsanitize=undefined enumerated
> them as such at run-time.
>
> I have replaced such reads with invocations of ld{l,q}_he_p.
> A comment in include/qemu/bswap.h:310 suggests they should be properly
> translated by the compiler. I didn't added signed/unsigned casts
> since bswap.h does contain separate signed/unsigned versions
> for 16-bit integers but does not for 32- and 64-bit ones, so I supposed
> the developers of the bswap.h already arranged everything so
> integer promotions don't mess things up. I can add casts in case I'm
> not right about it.
>
> Anatoly Trosinenko (1):
>   tci: eliminate UB due to unaligned reads
>
>  tcg/tci.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> --
> 2.14.1
>
>


-- 
Best regards,
Anatoly Trosinenko
