Received: from eggs.gnu.org ([209.51.188.92]:48735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gsD21-0005aA-8e
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gsD20-0007Zv-Ch
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:45:53 -0500
MIME-Version: 1.0
References: <CAFyWVaZ5tQq4eGaZiPBq7172PB_x3JCqV6c2xo=wSJdgbJakKQ@mail.gmail.com>
	<20190130025708.12811-1-jimw@sifive.com>
	<CAKmqyKMrCVqudmyJUPta9q6TJtDkeLV=FseAqQ7YhYMu3ak_NQ@mail.gmail.com>
	<CAFyWVaaS_4RY9YKXcgJ1F4Ep1TDWkExtBTEigJedZQCcXG+44Q@mail.gmail.com>
	<CAKmqyKOgnM0+6EByX-AWry-pkry_VQOa3SN5PWU75E0Q3_rbSw@mail.gmail.com>
	<CAFyWVabDFOoC2QzcquL+taW58j42hN7C3Us98LPBFqQf4oUXzA@mail.gmail.com>
In-Reply-To: <CAFyWVabDFOoC2QzcquL+taW58j42hN7C3Us98LPBFqQf4oUXzA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 8 Feb 2019 11:28:48 -0800
Message-ID: <CAKmqyKOr5eX1hQXURdz6Y7qDgygGOwYyFeKKZCH83UuuRkuR9w@mail.gmail.com>
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
To: Jim Wilson <jimw@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:RISC-V" <qemu-riscv@nongnu.org>

On Fri, Feb 8, 2019 at 11:09 AM Jim Wilson <jimw@sifive.com> wrote:
>
> On Fri, Feb 8, 2019 at 10:17 AM Alistair Francis <alistair23@gmail.com> wrote:
> > Can we just write a wrapper function then that sets and unsets the variable?
> > Something like this:
> >
> > riscv_csrrw_debug(...) {
> >     #if !defined(CONFIG_USER_ONLY)
> >             env->debugger = true;
> >     #endif
> >             result = riscv_csrrw(env, ...);
> >     #if !defined(CONFIG_USER_ONLY)
> >             env->debugger = false;
> >     #endif
> > }
>
> Yes, that would work.  Do you want me to resubmit a fixed part 5 patch?

It's probably best to send out a new version of the whole series.
Include all the Reviewed-by tags and then that should be the last
version and Palmer can apply that series directly.

Alistair

>
> Jim
