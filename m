Received: from eggs.gnu.org ([209.51.188.92]:49463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2K8J-00013I-Qv
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2K8I-0000Fz-VW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:22:11 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2K8I-0000FJ-OV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:22:10 -0500
Received: by mail-oi1-x242.google.com with SMTP id t206so16587423oib.3
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 10:22:10 -0800 (PST)
MIME-Version: 1.0
References: <1550029560-30530-1-git-send-email-sandra@codesourcery.com>
	<1550029560-30530-3-git-send-email-sandra@codesourcery.com>
	<CAFEAcA-Ocow8GzPCPO=346hnc4CZ6M02TwVp-e6G2EjY5-FESQ@mail.gmail.com>
	<7d4097aa-4888-82f6-3e4e-eeeb8de9f55b@codesourcery.com>
	<CAFEAcA92mHFcPoNtsHJqUTzfjxvXh4CpjEy_=irMYu9gEpg=2Q@mail.gmail.com>
	<bca405b0-1d08-5787-ddcc-d9205021689e@codesourcery.com>
In-Reply-To: <bca405b0-1d08-5787-ddcc-d9205021689e@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 18:21:58 +0000
Message-ID: <CAFEAcA9ZHj322qbY8BhdqFAqknc0nrfsFTUF3MN_49Ey_2OpiA@mail.gmail.com>
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

On Fri, 8 Mar 2019 at 17:01, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> On 3/8/19 9:04 AM, Peter Maydell wrote:
> > Thanks. So who "owns" this ABI (ie has the authority to change
> > it and should be the end documenting it)? How many projects or
> > bits of software are implementing either end of it?
>
> Going back in ancient history, I implemented the m68k version in
> libgloss in 2006 to support a hardware debug stub that CodeSourcery was
> also providing at that time.  We later moved the runtime side of it into
> target-agnostic code in an internal library, so when it came time to do
> a similar JTAG debug stub for bare-metal Nios II hardware testing in
> 2012, we re-used our existing code for both library and debug stub.
> Later Altera implemented the same protocol in some proprietary
> simulators they provided to us, and more recently we wrote these patches
> to add it to QEMU.  We've shifted away from hardware testing and no
> longer use the original debug stub now.
>
> > If we decide that QEMU owns the spec we can put the documentation
> > into docs/specs/.
>
> Making QEMU the "owner" of the ABI seems a little peculiar to me since
> it is only one client among several, and is a latecomer too.  I think
> libgloss would make a little more sense.  OTOH, I have no problem with
> making the documentation part of QEMU.

Thanks for the backstory. I agree that if QEMU is just one of
multiple implementations then it's not a great place to
hold the specification. Either libgloss, or I suppose in
theory Altera as the owner of the architecture could bless
the specification and host it...

-- PMM
