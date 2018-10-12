Received: from eggs.gnu.org ([2001:4830:134:3::10]:40742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAtq8-0007R9-Li
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAtq6-0007CG-ON
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:34:36 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAtq5-0007B8-GR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:34:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id a203-v6so9400153oib.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 02:34:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NvSYFtnKyFjPZqbHL=QM82zgRq5oU+mJW9vm7=QO9yTEg@mail.gmail.com>
References: <CAFEAcA_fmoBRTk0VKEjuu82eb7piCkq588+v7RT7r6f=_4=OVw@mail.gmail.com>
	<mhng-e2fff6d4-8420-48c5-92d9-cc03e16dfa48@palmer-si-x1c4>
	<CAHNT7NvSYFtnKyFjPZqbHL=QM82zgRq5oU+mJW9vm7=QO9yTEg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 10:34:12 +0100
Message-ID: <CAFEAcA8o8ozyh6DxFOaymvxwn-6v1G8tmkFKcU=vktQ3QkfTYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair23@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Richard Henderson <richard.henderson@linaro.org>, Karsten Merker <merker@debian.org>, Stefan O'Rear <sorear2@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>

On 11 October 2018 at 21:52, Michael Clark <mjc@sifive.com> wrote:
> Peter, I have to pull in your remote wholesale. I don't cherry-pick from
> your tree. I think this is truly dumb. This might serve the needs of some
> folk running Linux but we have emulation fidelity fixes for the RISC-V
> community as a whole. Alastair is the only person not submitting his patches
> via the (sub)maintainer tree. BTW Who is the RISC-V port maintainer?
> Puzzled.

I don't particularly mind who among you RISC-V folk does the QEMU
submaintainer work. But I would like to see somebody doing it,
and sitting on all your patches indefinitely in an out-of-tree
fork is not doing that job. There is no obligation to work
with upstream on a RISC-V QEMU, of course. But your last
pull request was back in May, so it's not surprising if
other people offer to step into that gap.

If you have emulation fidelity fixes, then the best approach
is to work on getting them upstream.

If you have downstream consumers for whom you want to maintain
a validated definitely-works tree, that's great. How you
manage that downstream tree (when you rebase it, what you
put in it, whether you make it have formal "releases", etc)
is up to you. I would suggest that trying to make it be the
same thing as your development tree for pushing work upstream
is not likely to serve either purpose well, though.

The expected patch flow for QEMU is:
 * original patch author posts patch to qemu-devel
   (this applies also if the author happens to be the
   submaintainer)
 * patch gets reviewed on this mailing list, by you or
   anybody else
 * patches relevant to risc-v get collected up by the
   submaintainer
 * submaintainer submits those patches via pull request
   (with a frequency usually about every two weeks, more
   often if volume of patches merits it)

> Here is the pull queue. But I'm not ready to make a PR until we have the CI
> running the regression.

This phrasing suggests you might be thinking about making a
large batch pull request all at once close to the
freeze deadline. That would be a bad idea -- it did not
work well last release either. Patches are best dribbled
into upstream at a steady pace as they are written.
(Note also that pull requests should not contain patches
which have not already been posted to qemu-devel and
reviewed here.)

thanks
-- PMM
