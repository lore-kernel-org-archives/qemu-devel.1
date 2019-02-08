Received: from eggs.gnu.org ([209.51.188.92]:60113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gsCaD-0001OL-8Y
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gsCaB-0000aw-QQ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:08 -0500
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:43674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1gsCa9-0007AN-KQ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:07 -0500
Received: by mail-vk1-xa44.google.com with SMTP id o130so1110806vke.10
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 12:12:46 -0800 (PST)
MIME-Version: 1.0
References: <CAFyWVaZ5tQq4eGaZiPBq7172PB_x3JCqV6c2xo=wSJdgbJakKQ@mail.gmail.com>
	<20190130025708.12811-1-jimw@sifive.com>
	<CAKmqyKMrCVqudmyJUPta9q6TJtDkeLV=FseAqQ7YhYMu3ak_NQ@mail.gmail.com>
	<CAFyWVaaS_4RY9YKXcgJ1F4Ep1TDWkExtBTEigJedZQCcXG+44Q@mail.gmail.com>
	<CAKmqyKOgnM0+6EByX-AWry-pkry_VQOa3SN5PWU75E0Q3_rbSw@mail.gmail.com>
In-Reply-To: <CAKmqyKOgnM0+6EByX-AWry-pkry_VQOa3SN5PWU75E0Q3_rbSw@mail.gmail.com>
From: Jim Wilson <jimw@sifive.com>
Date: Fri, 8 Feb 2019 11:08:55 -0800
Message-ID: <CAFyWVabDFOoC2QzcquL+taW58j42hN7C3Us98LPBFqQf4oUXzA@mail.gmail.com>
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:RISC-V" <qemu-riscv@nongnu.org>

On Fri, Feb 8, 2019 at 10:17 AM Alistair Francis <alistair23@gmail.com> wrote:
> Can we just write a wrapper function then that sets and unsets the variable?
> Something like this:
>
> riscv_csrrw_debug(...) {
>     #if !defined(CONFIG_USER_ONLY)
>             env->debugger = true;
>     #endif
>             result = riscv_csrrw(env, ...);
>     #if !defined(CONFIG_USER_ONLY)
>             env->debugger = false;
>     #endif
> }

Yes, that would work.  Do you want me to resubmit a fixed part 5 patch?

Jim
