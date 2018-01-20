Received: from eggs.gnu.org ([2001:4830:134:3::10]:41207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ed2gQ-0002S6-3U
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 18:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ed2gM-00034U-Vv
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 18:36:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ed2gM-00033L-Pr
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 18:36:18 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
	(Peter Maydell's message of "Fri, 19 Jan 2018 17:01:52 +0000")
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
	<CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Sun, 21 Jan 2018 00:36:10 +0100
Message-ID: <87h8rg2jdh.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, Philippe =?utf-8?Q?Mathie?= =?utf-8?Q?u-Daud=C3=A9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 January 2018 at 16:43, Alexey Perevalov <a.perevalov@samsung.com> wrote:
>> As I remember, I tested build in QEMU's docker build system,
>> but now I checked it on i386 Ubuntu, and yes linker says about unresolved
>> atomic symbols. Next week, I'll have a time to investigate it deeper.
>
> This sounds like exactly the problem I pointed out in a previous
> round of this patchset :-(
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg02103.html
>
> Ignoring comments and sending patches anyway makes me grumpy,
> especially when the result is exactly "fails obscurely on
> some architectures only"...

It compiles for me.  F25 i686 gcc.  I did change it to use intptr_t
instead of uint64_t.  So, I don't know what is going on here.

Then, I have a report that clang -m32 didn't work (Mat).  I haven't been
able yet to reproduce.  I don't have 32bits libraries installed on my
x86_64 systems.  clang compiles for me on both 64 bits (f27) and 32bits
native (f25, it is a long history that it is not f27).

So, I can agree that we have to fix anything that don't work, but I
can't agree that I didn't care about comments, at least I tried to fix
the problems you pointed me to.

What I don't have is an easier way of compiling on arm and ppc32, but I
will search a way to do that for my pull requsets.

Sorry about the inconveniences.

Later, Juan.
