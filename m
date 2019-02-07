Received: from eggs.gnu.org ([209.51.188.92]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1grZ4b-0001UY-18
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 21:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1grZ4Z-0006Pb-Vg
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 21:05:52 -0500
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:45768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1grZ4P-0006Kz-2U
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 21:05:45 -0500
Received: by mail-vs1-xe43.google.com with SMTP id x28so5744760vsh.12
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 18:05:21 -0800 (PST)
MIME-Version: 1.0
References: <CAFyWVaZ5tQq4eGaZiPBq7172PB_x3JCqV6c2xo=wSJdgbJakKQ@mail.gmail.com>
	<20190130025708.12811-1-jimw@sifive.com>
	<CAKmqyKMrCVqudmyJUPta9q6TJtDkeLV=FseAqQ7YhYMu3ak_NQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMrCVqudmyJUPta9q6TJtDkeLV=FseAqQ7YhYMu3ak_NQ@mail.gmail.com>
From: Jim Wilson <jimw@sifive.com>
Date: Wed, 6 Feb 2019 18:05:09 -0800
Message-ID: <CAFyWVaaS_4RY9YKXcgJ1F4Ep1TDWkExtBTEigJedZQCcXG+44Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/5 v3] RISC-V: Add hooks to use the gdb
 xml files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Wed, Feb 6, 2019 at 4:04 PM Alistair Francis <alistair23@gmail.com> wrote:
> Would it not be easier to add an extra argument to the functions
> intstead of setting and unsetting this?
>
> That's what you had in the earlier version of this set.

The csr support was rewritten, and is now a table of functions.  If I
change the type signature for one function in a table column I have to
change them all.  This means I have to change the type signature of
about 50 functions, the vast majority of which will never use the new
argument.  I was hoping to avoid that, so I added a variable into the
cpu state instead.  In the old patch, before the csr rewrite, I only
had to change the type signature of a couple of functions, most of
which did use the new argument, so that was reasonable at the time.

If I do need to change a lot of type signatures, what about attribute
((unused))?  I see that there is a ATTRIBUTE_UNUSED in the disas dir
but it is apparently not used outside there, and only defined in
include/disas/bfd.h.  I see a few scattered uses of
attribute((unused)) but that seems unwise for portability reasons.
Maybe qemu doesn't care about unused arguments/parameters?

Jim
