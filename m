Received: from eggs.gnu.org ([2001:4830:134:3::10]:35306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6d8t-0003fZ-FQ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6d8s-00028G-Lx
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:51:47 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:49821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6d8s-00027v-Eu
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:51:46 -0400
Received: by mail-wm0-x242.google.com with SMTP id b189so9630295wmd.4
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 06:51:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <64A6EC25-B7C7-460C-AB34-4BDF26AEEC4E@gmail.com>
References: <64A6EC25-B7C7-460C-AB34-4BDF26AEEC4E@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Oct 2017 14:51:24 +0100
Message-ID: <CAFEAcA_h_r5KdLuRLZYdm+mu1rAe+4C_nHrCSGPSwe7kUxxxsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu query ( support for new board)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fahad Butt <fahadbutt214@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 October 2017 at 12:57, Fahad Butt <fahadbutt214@gmail.com> wrote:
> 1- I want to know whether qemu can be cycle accurate or not? from
> my search i believe it is not cycle accurate. But is it possible?
> Cycle accuracy?

You're correct that QEMU is not cycle accurate. In general for
modern complex CPUs cycle accurate emulation is pretty much
impossible (except for approaches involving running the actual
RTL of the CPU), because the level of effort required to create
a cycle accurate model approaches the level of effort required
to create the CPU in the first place (and you need a lot of
information about the internals of the CPU which is not known
to anybody outside the company which designed that CPU), so it's
just impractical. For something simple like the Cortex-M4 it's
probably still possible at least in theory, but QEMU certainly
doesn't attempt it and I don't offhand know of any emulators that do.

> 2- I want to emulate my cortex m4 hardware using qemu. But this
> discovery board isnt directly supported by qemu. What needs to
> be done to support another cortex m4 discovery board for emulation?

You would need to write device models to emulate all the relevant
devices on the board, the SoC, etc. You should think of this as
about the same amount of work as it would be to write device
drivers for all those devices -- it's quite a lot of work.

For many cases, it doesn't actually matter what the exact
device and board hardware is, and you can use some other
board model that QEMU already implements. This does require
your guest RTOS/code to have support for that board, though.

> 3- is the Floating point unit and the DSP instructions supported by QEMU?

We definitely don't currently implement the FPU. I think we
do support the DSP instructions.

thanks
-- PMM
