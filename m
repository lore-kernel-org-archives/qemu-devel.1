Received: from eggs.gnu.org ([2001:4830:134:3::10]:59498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1es8cw-0005si-S0
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1es8cv-0001sM-W3
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 09:59:10 -0500
MIME-Version: 1.0
In-Reply-To: <a9fb7f08-9eeb-4120-620e-1f05715ee329@twiddle.net>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
	<CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
	<efe4a642-a220-5a40-b1e0-769a4216389d@twiddle.net>
	<CAE5jQCcCA=3kkVa=5eMZs-BGAM_p4fZG+GPu1SmQMg7_sPAH5Q@mail.gmail.com>
	<a9fb7f08-9eeb-4120-620e-1f05715ee329@twiddle.net>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sat, 3 Mar 2018 17:59:08 +0300
Message-ID: <CAE5jQCcZxx5dZaqAxMFBjrAKyfZnnLx1ARQXStBrYBvPgU5d6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

> So.  Why do you want to use TCI instead of a native TCG backend?

Frankly speaking, personally I just have a strange experiment on porting
QEMU to JavaScript. :) I used the TCI bytecode as some intermediate
patchable form for rarely executing BBs and for (re)generating asm.js from
it when required. I used a Python script to generate wrappers with exactly
10 arguments around helper functions. In fact, it may be worth for me to
create WebAssembly TCG backend and interpret **that** bytecode if required.

TCI may still be useful for someone else running QEMU on unsupported host,
though.

2018-03-03 17:13 GMT+03:00 Richard Henderson <rth@twiddle.net>:

> On 03/03/2018 06:07 AM, Anatoly Trosinenko wrote:
> > Can rewriting TCI in such a way that every operation is aligned at 4- or
> even
> > 8-byte boundary fix the situation or are there some more serious
> problems?
>
> With the current TCI, there are also problems with calls to helper
> functions.
> The only portable way to do this is to use a library such as libffi.
>
> I once rewrote TCI completely in order to address both problems, but that
> only
> brought questions as to why TCI is useful at all.
>
> So.  Why do you want to use TCI instead of a native TCG backend?
>
>
> r~
>

--
Best regards,
Anatoly
