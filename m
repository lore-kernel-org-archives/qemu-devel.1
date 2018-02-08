Received: from eggs.gnu.org ([2001:4830:134:3::10]:32824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejtLx-0001D6-Hz
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejtLw-0005yo-DF
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:03:33 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ejtLw-0005yF-7I
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:03:32 -0500
Received: by mail-oi0-x242.google.com with SMTP id k15so4527814oib.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 13:03:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <36012021-2859-8690-002d-aaef6b3b8bae@linaro.org>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-7-git-send-email-mjc@sifive.com>
	<36012021-2859-8690-002d-aaef6b3b8bae@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 9 Feb 2018 10:03:31 +1300
Message-ID: <CAHNT7NvjnUz0RHdYpRoaK1rM_6tWJZcK8uhpj90-WRmh_Q4Ayw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 06/23] Softfloat support for IEEE
 754-201x minimumNumber/maximumNumber
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, Feb 9, 2018 at 3:35 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 02/07/2018 05:28 PM, Michael Clark wrote:
> > QEMU currently implements IEEE 754-2008 minNum/maxNum. This patch adds
> > support for IEEE 754-201x minimumNumber/maximumNumber which is required
> > by the RISC-V port.
> >
> > minNum(x, y) is defined as
> > - min(x, y) if neither is NaN
> > - if one of x and y is a number and one is qNaN, return the number
> > - if both are qNaN, or either is sNaN, return NaN
> >
> > minimumNumber(x, y) is defined as
> > - min(x, y) if neither is NaN
> > - if one of x and y is a number and one is qNaN or sNaN, return the
> number
> > - if both are NaN, return the number
> >
> > Both functions signal the invalid exception on sNaN inputs.
> >
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
>
> Thanks for the description of the function.  We've got a reorg of softfloat
> pending at the moment; I'd want to defer this patch until that set has
> landed.
>

Noted.

We should also add a mention of minimumNumber/maximumNumber to the
preceeding comment, which isn't in the current version of the patch. e.g.

 * minimumnumber() and maximumnumber() functions correspond to
minimumNumber()
 * and maximumNumber() from the IEEE-754 201x specification.
