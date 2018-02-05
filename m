Received: from eggs.gnu.org ([2001:4830:134:3::10]:36557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eij76-0005p7-DY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eij75-0002if-3k
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:55:24 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:43450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eij74-0002e3-Fb
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:55:22 -0500
Received: by mail-ot0-x22a.google.com with SMTP id q12so9977355otg.10
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 07:55:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205155108.GF28241@stefanha-x1.localdomain>
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
	<20180202100843.GD13090@stefanha-x1.localdomain>
	<CAFEAcA-5PwhJw9epXh+0_oe3E-vsVKkQDX3s1Go-FBzO=FA3zA@mail.gmail.com>
	<20180205155108.GF28241@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Feb 2018 15:55:01 +0000
Message-ID: <CAFEAcA-vd3vEJ0i=2LtaR-NQjHoJVYWCNDHOmh3iREPcQsqR4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nesrine Zouari <nesrine.zouari@enis.tn>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>

On 5 February 2018 at 15:51, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The point of the instrumentation plugin API is for online analysis
> (stuff that cannot be post-processed offline) with the ability for the
> plugin to control QEMU (e.g. affect translation during a run).  That is
> not necessary for Nesrine's use case.

...but it hugely overlaps, because the most interesting
reason for having a trace plugin is to be able to do things
like tracing instruction flow, memory access and so on.

> I see two main requirements in Nesrine's use case:
>
> 1. Instruction flow, memory access, and task switch trace.  This doesn't
> exist today and requires adding new trace events.
>
> 2. An external interface for processing traces.  There seems to be a
> requirement for doing it online and not by post-processing trace files.
> Therefore I suggested looking into LTTng UST, which has an efficient
> interface and libraries for tracing processes.  I think no QEMU changes
> are necessary here.

...and "online processing of traces" is pretty much exactly
what an instrumentation plugin API is for.

It would also let you put the logic of "how do we know what a
guest OS task switch is anyway" somewhere other than QEMU,
which is nice because that's very guest-OS specific.

thanks
-- PMM
