Received: from eggs.gnu.org ([2001:4830:134:3::10]:38940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ehd5q-0004dj-CD
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ehd5o-0003OP-VW
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:17:34 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ehd5o-0003NK-P6
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:17:32 -0500
Received: by mail-oi0-x243.google.com with SMTP id e15so6172083oiy.2
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 07:17:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFyWVaZvMRyGkFmfgXG_i_chJtNUm8fw9Q3XSuye9Fpy2dGyZw@mail.gmail.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
	<f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
	<CAHNT7NvcUU8D10jaq+y=B2odsD7-r0MnsZRsq2yheY_a-THSUA@mail.gmail.com>
	<14dcf85d-a8e0-fc21-df46-b94fe48d1067@linaro.org>
	<CAFyWVabFUocnxebZxTYrVr71gbyd6PgLYfqxiAHAqSaw0=6VgA@mail.gmail.com>
	<75ba8c40-803f-4652-93d9-852c97334aad@linaro.org>
	<CAFyWVaZvMRyGkFmfgXG_i_chJtNUm8fw9Q3XSuye9Fpy2dGyZw@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 1 Feb 2018 21:26:36 -0800
Message-ID: <CAHNT7NtvoWH-xF2np78h2LD=2f-Rhhg0NucSbbJNO8rAj8NpDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Mon, Jan 29, 2018 at 12:33 PM, Jim Wilson <jimw@sifive.com> wrote:

> On Wed, Jan 24, 2018 at 3:47 PM, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> > On 01/24/2018 10:58 AM, Jim Wilson wrote:
> >> Although, looking at this again, I see another statement in a
> >> different place that says:
> >>
> >> Except when otherwise stated, if the result of a floating-point
> operation is
> >> NaN, it is the canonical NaN. The canonical NaN has a positive sign and
> all
> >> significand bits clear except the MSB, a.k.a. the quiet bit. For
> >> single-precision floating-point, this corresponds to the pattern
> >> 0x7fc00000.
> > Yes, I had read this before as well.  I had assumed that your patch
> constituted
> > an intended change to this text.
> >
> >> This could take a little time to sort out.
> > Ok.  I don't see this as a blocking issue for merging.
>
> So after looking at this a bit more, I've come to the conclusion that
> my patch to remove the default/canonical nan support from RISC-V qemu
> was wrong.  We will have to fix this on the gcc/glibc side.
>
> Michael, please revert my change
>     https://github.com/riscv/riscv-qemu/commit/
> 4223d89b0c5c671332d66bcd649db5c6f46559f5


Done.
