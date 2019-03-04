Received: from eggs.gnu.org ([209.51.188.92]:55183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1h0kqj-000519-Np
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1h0kqi-0003ga-VC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:29:33 -0500
Received: from mail-eopbgr810053.outbound.protection.outlook.com
	([40.107.81.53]:45711
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1h0kqi-0003Z0-GB
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:29:32 -0500
Date: Mon, 4 Mar 2019 11:29:12 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20190304102912.GC6010@toto>
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
	<CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
	<fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
	<CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
	<63b980a2-6b28-d5e2-891c-6245ddb1e851@redhat.com>
	<CAFEAcA8L1qKaNwpr8sMZC8jQXbaLtCctaV8ecTFxXTVy0sWjVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8L1qKaNwpr8sMZC8jQXbaLtCctaV8ecTFxXTVy0sWjVw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Damien Hedde <damien.hedde@greensocs.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Damien and others,

A few questions from my side.

We sometimes see that wires from generic GPIO blocks get connected to reset inputs.
This happens both to off-chip perihperals but we also see it on-chip.

To avoid having GPIO modules know that some of their outputs are being used as
reset signals it would be nice to have a reset proxy that allows any qemu_irq to
drive resets for a given device. Perhaps even with built-in options for both interpreting
"active-low" and "active-high". I think it would even be useful to have this
in qdev but that may be pushing it too far. Any thoughts on that?

Have you thought about what happens if someone does an MMIO access to a device while
its reset is active? Were you planning to have some "default" SysBus level handling to
block MMIO while in reset or anything like that? Or would that be handled individually
by each device model?

Another question is regarding reset of CPUs. It would be nice to be able to expose
similar interfaces and have some defined behaviour for CPUs that are in reset. E.g,
if reset is active the CPU does not execute etc.

Cheers,
Edgar
