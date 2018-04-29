Received: from eggs.gnu.org ([2001:4830:134:3::10]:43939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fCvLw-0005PG-NQ
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fCvLv-0007qV-Cj
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:03:32 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:38288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fCvLv-0007q7-5Y
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:03:31 -0400
Received: by mail-oi0-x232.google.com with SMTP id k17-v6so6049830oih.5
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 16:03:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <45076b60-a2d2-281a-3c85-6c21d87a49ff@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-6-richard.henderson@linaro.org>
	<CAHNT7NujtwKtCtsxG91DtgriDd2sjVZwyqKhAp03LR=eJjdMtQ@mail.gmail.com>
	<45076b60-a2d2-281a-3c85-6c21d87a49ff@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 30 Apr 2018 11:03:29 +1200
Message-ID: <CAHNT7NtDL2v8svSR3YvT14quz3MOJB-=_3CuTc8HfDkfMHMhBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/9] target/riscv: Use new atomic min/max
 expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Emilio G. Cota" <cota@braap.org>

On Sat, Apr 28, 2018 at 5:53 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 04/26/2018 09:24 PM, Michael Clark wrote:
> >
> >
> > On Fri, Apr 27, 2018 at 12:26 PM, Richard Henderson
> > <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>>
> wrote:
> >
> >     Cc: Michael Clark <mjc@sifive.com <mailto:mjc@sifive.com>>
> >     Cc: Palmer Dabbelt <palmer@sifive.com <mailto:palmer@sifive.com>>
> >     Cc: Sagar Karandikar <sagark@eecs.berkeley.edu
> >     <mailto:sagark@eecs.berkeley.edu>>
> >     Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de
> >     <mailto:kbastian@mail.uni-paderborn.de>>
> >     Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> >     <mailto:richard.henderson@linaro.org>>
> >
> >
> > Reviewed-by: Michael Clark <mjc@sifive.com <mailto:mjc@sifive.com>>
> >
> > If you give me a remote I can pull into my local workspace and test. The
> change
> > looks pretty straight-forward. There are tests for amos in riscv-tests
> but no
> > parallel tests (i.e. contended case).
>
> git://github.com/rth7680/qemu.git tgt-arm-atomic-2


I just did a fetch and only saw tgt-arm-atomic. Maybe you haven't pushed
tgt-arm-atomic-2.

In any case the tgt-arm-atomic branch passes riscv-tests.

Michael.
