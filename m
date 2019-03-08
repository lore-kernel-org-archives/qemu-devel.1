Received: from eggs.gnu.org ([209.51.188.92]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Hzb-0004s1-NG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Hza-0005MW-4W
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:05:03 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2HzY-0005KT-KM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:05:02 -0500
Received: by mail-ot1-x342.google.com with SMTP id i12so17769525otp.12
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 08:05:00 -0800 (PST)
MIME-Version: 1.0
References: <1550029560-30530-1-git-send-email-sandra@codesourcery.com>
	<1550029560-30530-3-git-send-email-sandra@codesourcery.com>
	<CAFEAcA-Ocow8GzPCPO=346hnc4CZ6M02TwVp-e6G2EjY5-FESQ@mail.gmail.com>
	<7d4097aa-4888-82f6-3e4e-eeeb8de9f55b@codesourcery.com>
In-Reply-To: <7d4097aa-4888-82f6-3e4e-eeeb8de9f55b@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 16:04:46 +0000
Message-ID: <CAFEAcA92mHFcPoNtsHJqUTzfjxvXh4CpjEy_=irMYu9gEpg=2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>

On Fri, 8 Mar 2019 at 03:13, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> On 3/7/19 7:58 AM, Peter Maydell wrote:
> > On Wed, 13 Feb 2019 at 04:02, Sandra Loosemore <sandra@codesourcery.com> wrote:
> >>
> >> This patch adds support for libgloss semihosting to Nios II bare-metal
> >> emulation.
> >>
> >> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> >> Signed-off-by: Julian Brown <julian@codesourcery.com>
> >
> > Do you have a link to the spec that defines this semihosting
> > ABI, please ?
>
> Well, I just wrote some derived from the comments in the libgloss
> sources; see the attachment.  :-)

Thanks. So who "owns" this ABI (ie has the authority to change
it and should be the end documenting it)? How many projects or
bits of software are implementing either end of it?

If we decide that QEMU owns the spec we can put the documentation
into docs/specs/.

> FWIW this is pretty much a direct copy of the m68k semihosting protocol,
> which CodeSourcery contributed ages ago to both libgloss and qemu.

Yeah, and that seems to be undocumented too :-(  I'm not a huge
fan of "this is just some random thing that's private to QEMU
and libgloss".

thanks
-- PMM
