Received: from eggs.gnu.org ([2001:4830:134:3::10]:52267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbS92-00052N-N2
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbS91-0004Zg-Py
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:55:36 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbS91-0004ZP-Ji
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:55:35 -0400
Received: by mail-oi0-x242.google.com with SMTP id k81-v6so23980008oib.4
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 07:55:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705222115.17013-3-jusual@mail.ru>
References: <20180705222115.17013-1-jusual@mail.ru>
	<20180705222115.17013-3-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 15:55:14 +0100
Message-ID: <CAFEAcA8TPN=05ncaSp8k7gAvwF7cmSoykTcG5YdLvByvhgasHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v3 2/2] tests: Add ARMv6-M reserved register
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 5 July 2018 at 23:21, Julia Suvorova <jusual@mail.ru> wrote:
> Check that reserved SCS registers return 0 at read,
> and writes are ignored.
>
> Based-on: <20180627143815.1829-1-joel@jms.id.au>
> Based-on: <20180630091343.14391-1-stefanha@redhat.com>
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> Test will work if Joel's patches will use ARMv6-M.
>
>  tests/Makefile.include            |  2 ++
>  tests/tcg/arm/test-reserved-reg.c | 60 +++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 tests/tcg/arm/test-reserved-reg.c

Is this in the wrong place? It doesn't look like a
tests/tcg test -- those directories are for test
programs which need to be compiled with a cross compiler
for the guest CPU and then run on it.

I tried running 'make check' and I got this error:

  CC      tests/tcg/arm/test-reserved-reg.o
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/tcg/arm/test-reserved-reg.c:60:1:
fatal error: opening dependency file
tests/tcg/arm/test-reserved-reg.d: No such file or directory
 }
 ^

which is a bit weird.

thanks
-- PMM
