Received: from eggs.gnu.org ([208.118.235.92]:50892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nesrine.zouari@enis.tn>) id 1ehdlA-0000P1-Al
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nesrine.zouari@enis.tn>) id 1ehdjy-0004T8-3T
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:00:16 -0500
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:35128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nesrine.zouari@enis.tn>)
	id 1ehdjx-0004Sm-Mo
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:59:01 -0500
Received: by mail-qk0-x235.google.com with SMTP id 69so11314675qkz.2
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 07:59:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202100843.GD13090@stefanha-x1.localdomain>
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
	<20180202100843.GD13090@stefanha-x1.localdomain>
From: Nesrine Zouari <nesrine.zouari@enis.tn>
Date: Fri, 2 Feb 2018 11:45:31 +0100
Message-ID: <CAPHFV4mveS_n1FyxwDut3S6q_jmMFBrMLn+HZ9a4SnZVG_rNPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu

Hello Mr. Stefan,

Thank you for your response. To answer your question : the trace solution
should be architecture independent.This is the best for us. We aim to test
it at least for ARM/ARM64 , x86 and x64 architectures. But even if  there
will be some differences , we can accept it.

Regards,

On Fri, Feb 2, 2018 at 11:08 AM, Stefan Hajnoczi <stefanha@redhat.com>
wrote:

> On Thu, Feb 01, 2018 at 04:30:10PM +0100, Nesrine Zouari wrote:
> > I am a computer engineering student and I am actually working on my
> > graduation project at Lauterbach company. The project is about Qemu Tra=
ce
> > and as a future I would like to contribute this work to the main line.
> >
> > My project is divided into two parts:
> >
> > 1/ Collecting the Guest trace data : The trace solution should be able =
to
> > provide:
> >
> >             a/ Instruction flow Trace
> >
> >             b/ Memory read/write access
> >
> >             c/ Time Stamps.
> >
> >             d/ For tracing rich operating systems that are using MMU, w=
e
> > additionally need to trace the task switches.
>
> Llu=C3=ACs has done the most instrumentation work in qemu.git and can exp=
lain
> the current status.
>
> The focus in QEMU is more on functional simulation than on low-level
> instrumentation.  Therefore the instrumentation facilities aren't very
> rich.  Code changes will be required to get the information you need.
> In order to be suitable for upstream they should not be too invasive or
> impact performance significantly.
>
> Which CPU architecture are you targeting?
>
> > 2/ Sending the collected data to a third party tool for analysis.
> >
> > My question is about the first part. I would like to know, which trace
> > backend that better fit my use case.
>
> LTTng UST has the highest performance tracing interface.  It uses shared
> memory to efficiently export trace data to a collector or analysis
> process.
>
> It is probably not necessary to invent your own tracer or interface for
> capturing trace data.  I suggest looking into LTTng UST and trying it
> out.
>
> The basic idea would be:
>
> 1. Add missing trace events to QEMU
> 2. Build with ./configure --enable-trace-backend=3Dust && make
> 3. Use LTTng tools or write your own collector using the LTTng libraries
> 4. Enable the trace events that you need for instruction flow, memory
>    access, and task switching.
>
> The QEMU code changes involved would be changes to trace-events and
> placing those trace events into TCG and/or memory API code to record the
> necessary information.
>
> Stefan
>



--=20
---------------------------------------------------------------------------=
--------------

Nesrine ZOUARI
Computer Engineering Student
Department of Computer Engineering and Applied Mathematics
National Engineering School of Sfax (ENIS)
University of Sfax-Tunisia
Tel: +216 52 620 475
