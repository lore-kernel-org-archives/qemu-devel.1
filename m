Received: from eggs.gnu.org ([2001:4830:134:3::10]:52233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1er0IW-00029B-1B
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1er0IV-00085p-2d
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:53:24 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:39580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1er0IU-00085a-MW
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:53:22 -0500
Received: by mail-oi0-x229.google.com with SMTP id t185so1536328oif.6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 03:53:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
	<CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2018 11:53:01 +0000
Message-ID: <CAFEAcA-kUW+cKPiwzkhLm=+3f-HnkeOCURR73JkFNtd9LE-ABA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Stef O'Rear <sorear2@gmail.com>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 28 February 2018 at 00:09, Michael Clark <mjc@sifive.com> wrote:
> I've just talked to SiFive about this. They have agreed that we can remove
> the sifive_e300 and sifive_u500 boards from the patch series that we are
> going to submit upstream again later this week or early next week. These
> machines and their devices are pretty easy for us to maintain in the riscv
> or a sifive repo. This trims the number of machines from 5 to 3 and lets us
> remove the SiFiveUART and SiFivePRCI from the next patch series we are
> going to submit. e.g. v8

Models of boards which people actively want and are using are fine
(though indeed you can save them for a later round of patches if you
like). And it sounds like the 1.9.1 stuff is genuinely wanted, so
thanks for the clarification there. What I want to avoid is boards
going into QEMU just because you happened to have them already. Once
a board model goes into QEMU it's a commitment to supporting it for
the long term, and getting rid of it again is hard.

> However I'm inclined to leave it as it is, at this point. It is not
> something that we can't change in the future once the code is in-tree.

With my 'upstream dev' hat on, I tend to be suspicious of this
line of argument, because in a lot of cases what tends to happen
is that the code for some new target or device goes in-tree, and
then the people who worked on submitting it disappear, or never
actually do get round to refactoring[*]. You get more leeway for
making this argument the longer you've been around and participating
in QEMU development, because then you have a track record of
following up on things.

[*] in fact we're currently discussing deleting support for
a couple of target architectures that were basically "once the
code went into mainline nothing further was ever done to it except
global-refactorings and other tree wide maintenance by other
QEMU developers".

thanks
-- PMM
