Received: from eggs.gnu.org ([2001:4830:134:3::10]:42306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fxKut-000283-OX
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fxKuq-0007o8-Ds
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:39:27 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fxKup-0007m9-V7
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:39:24 -0400
Date: Tue, 4 Sep 2018 19:39:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180904233919.GA25010@flamenco>
References: <20180810173941.5301-1-cota@braap.org>
	<20180831222249.GA28489@flamenco>
	<CAKmqyKO2jK0YnJepSazMeCtMtFLpEMaY6UOeyHbGWKED0Z=CJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKO2jK0YnJepSazMeCtMtFLpEMaY6UOeyHbGWKED0Z=CJw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/riscv: use
 tcg_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>

On Tue, Sep 04, 2018 at 13:18:28 -0700, Alistair Francis wrote:
> On Fri, Aug 31, 2018 at 3:22 PM, Emilio G. Cota <cota@braap.org> wrote:
> > On Fri, Aug 10, 2018 at 13:39:38 -0400, Emilio G. Cota wrote:
> >> Changes wrt v1: changed patch 3 as suggested by Richard. Also
> >> added his R-b's.
> >>
> >> You can fetch this series from:
> >>   https://github.com/cota/qemu/tree/riscv-lookup_ptr-v2
> >
> > RISC-V maintainers: any plans of picking this up for 3.1?
> 
> Thanks for CCing me.
> 
> I think Michael must be really busy, I haven't seen any activity for
> awhile. I'm going to send a PR with everything that has been reviewed
> and applies cleanly.

Thanks!

Did patch 1 not apply cleanly? I see it's not part of the pullreq
you just sent.

I'd like the three patches to go in in the original order, since
the perf numbers in patch 3's commit log are laid out assuming
that is the case.

Cheers,
	
		Emilio
