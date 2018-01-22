Received: from eggs.gnu.org ([2001:4830:134:3::10]:44638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edgzY-0001f3-Hu
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edgzU-0006mI-FE
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:38:48 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edgzU-0006lv-8h
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:38:44 -0500
Received: by mail-wr0-x243.google.com with SMTP id d9so9778134wre.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 10:38:44 -0800 (PST)
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
	<CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
	<87h8rg2jdh.fsf@secure.laptop>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87h8rg2jdh.fsf@secure.laptop>
Date: Mon, 22 Jan 2018 18:38:41 +0000
Message-ID: <87h8rdkaby.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Perevalov <a.perevalov@samsung.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>


Juan Quintela <quintela@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 19 January 2018 at 16:43, Alexey Perevalov <a.perevalov@samsung.com> =
wrote:
>>> As I remember, I tested build in QEMU's docker build system,
>>> but now I checked it on i386 Ubuntu, and yes linker says about unresolv=
ed
>>> atomic symbols. Next week, I'll have a time to investigate it deeper.
>>
>> This sounds like exactly the problem I pointed out in a previous
>> round of this patchset :-(
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg02103.html
>>
>> Ignoring comments and sending patches anyway makes me grumpy,
>> especially when the result is exactly "fails obscurely on
>> some architectures only"...
>
> It compiles for me.  F25 i686 gcc.  I did change it to use intptr_t
> instead of uint64_t.  So, I don't know what is going on here.
>
> Then, I have a report that clang -m32 didn't work (Mat).  I haven't been
> able yet to reproduce.  I don't have 32bits libraries installed on my
> x86_64 systems.  clang compiles for me on both 64 bits (f27) and 32bits
> native (f25, it is a long history that it is not f27).
>
> So, I can agree that we have to fix anything that don't work, but I
> can't agree that I didn't care about comments, at least I tried to fix
> the problems you pointed me to.
>
> What I don't have is an easier way of compiling on arm and ppc32, but I
> will search a way to do that for my pull requsets.

  make docker-test-build@debian-armhf-cross
  make docker-test-build@debian-powerpc-cross

Assuming you have docker setup and working.

>
> Sorry about the inconveniences.
>
> Later, Juan.


--
Alex Benn=C3=A9e
