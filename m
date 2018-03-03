Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1es7p5-0004Di-AF
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1es7p4-0002jN-B3
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:07:39 -0500
MIME-Version: 1.0
In-Reply-To: <efe4a642-a220-5a40-b1e0-769a4216389d@twiddle.net>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
	<CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
	<efe4a642-a220-5a40-b1e0-769a4216389d@twiddle.net>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sat, 3 Mar 2018 17:07:37 +0300
Message-ID: <CAE5jQCcCA=3kkVa=5eMZs-BGAM_p4fZG+GPu1SmQMg7_sPAH5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] tci: eliminate UB due to unaligned
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org

Can rewriting TCI in such a way that every operation is aligned at 4- or
even 8-byte boundary fix the situation or are there some more serious
problems?

2018-03-03 16:57 GMT+03:00 Richard Henderson <rth@twiddle.net>:

> On 03/03/2018 12:54 AM, Anatoly Trosinenko wrote:
> > Ping.
> > Patchwork link: http://patchwork.ozlabs.org/patch/866732/
> > <http://patchwork.ozlabs.org/patch/866732/>
> > Patchew link:
> > http://patchew.org/QEMU/20180127134908.24095-1-
> anatoly.trosinenko@gmail.com/
> > <http://patchew.org/QEMU/20180127134908.24095-1-
> anatoly.trosinenko@gmail.com/>
> >
> > The code in tcg/tci.c reads some data from TCI bytecode through
> > pointer dereferencing. As far as I know unaligned reads in such a way a=
re
> > undefined behavior and compiling with -fsanitize=3Dundefined enumerated
> > them as such at run-time.
>
> This is exactly one of the reasons why I have urged for TCI to be
> abandoned.
>
> While your patch works, it is *enormously* inefficient for hosts that
> require it.
>
>
> r~
>



--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BD=D0=B0=D1=82=D0=BE=D0=BB=D0=B8=D0=B9 =D0=A2=D1=80=D0=BE=D1=81=
=D0=B8=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE
e-mail: anatoly.trosinenko@gmail.com
