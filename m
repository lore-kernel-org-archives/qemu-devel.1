Received: from eggs.gnu.org ([2001:4830:134:3::10]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dSmpB-0005gc-H4
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dSmpA-0004zo-L3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:45 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dSmpA-0004zA-E1
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:06:44 -0400
Received: by mail-wm0-x231.google.com with SMTP id f67so117970649wmh.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 09:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<CAK4993hiFSozkL-5B0gud-nPVFqcvP2mgBR1Rk1vQSmhts3fGQ@mail.gmail.com>
	<7103e7ca-1504-58b0-1f32-aabba7f45792@twiddle.net>
	<CAK4993j5SEAqySt4VQhXCwAkbU09+4YUfiaw8zypvW3803GJ_A@mail.gmail.com>
	<517fcd97-6664-025d-dc03-114bc5b49dff@twiddle.net>
In-Reply-To: <517fcd97-6664-025d-dc03-114bc5b49dff@twiddle.net>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 05 Jul 2017 16:06:32 +0000
Message-ID: <CAK4993i8TtWvyZw2-fcPJD3KU2mNKgi47HUmDOGYv7MnMhsYXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v19 00/13] QEMU AVR 8 bit cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anichang <anichang@protonmail.ch>

No, I can't. I did not build any peripherals. I expect other people to join
for this task.

On Wed, Jul 5, 2017, 6:59 PM Richard Henderson <rth@twiddle.net> wrote:

> On 07/04/2017 08:34 PM, Michael Rolnik wrote:
> > Hi Richard.
> >
> > Thank you for finding a bug.
> > As for the testing
> > 1. I have a small program that calculates fibonacci numbers. I use it to
> test
> > mainly stack operations for different CPU flavors (1, 2 or 3 bytes PC).
> > 2. I manually verified that I can debug with gdb, that includes
> >      a. stepping
> >      b. running
> >      c. stopping
> >      d. breakpoints
> >      e. backtrace shows correct stack
> > 3. I manually verified that I can save and load vm states
> > 4. `make check` passes
> >
> > If you please point me to a doc that explains how automatic unit tests
> can be
> > added to a QEMU target, I will happily add them.
>
> Can you boot an AVR kernel?
>
> How about the environment that newlib builds with libgloss?  With that
> you'd be
> able to run the gcc testsuite, which would be extremely helpful.
>
>
> r~
>
