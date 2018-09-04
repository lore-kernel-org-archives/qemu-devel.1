Received: from eggs.gnu.org ([2001:4830:134:3::10]:44192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxKyQ-00047L-Gr
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxKyP-0003pH-BQ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:43:06 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fxKyO-0003ms-Sf
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:43:05 -0400
Received: by mail-lf1-x141.google.com with SMTP id q13-v6so4444094lfc.2
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 16:43:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180904233919.GA25010@flamenco>
References: <20180810173941.5301-1-cota@braap.org>
	<20180831222249.GA28489@flamenco>
	<CAKmqyKO2jK0YnJepSazMeCtMtFLpEMaY6UOeyHbGWKED0Z=CJw@mail.gmail.com>
	<20180904233919.GA25010@flamenco>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Sep 2018 16:42:32 -0700
Message-ID: <CAKmqyKPoAhQnOMcTbCxR4g-vW2CBJJLO0EJt+ioXoTf0drSRCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>

On Tue, Sep 4, 2018 at 4:39 PM, Emilio G. Cota <cota@braap.org> wrote:
> On Tue, Sep 04, 2018 at 13:18:28 -0700, Alistair Francis wrote:
>> On Fri, Aug 31, 2018 at 3:22 PM, Emilio G. Cota <cota@braap.org> wrote:
>> > On Fri, Aug 10, 2018 at 13:39:38 -0400, Emilio G. Cota wrote:
>> >> Changes wrt v1: changed patch 3 as suggested by Richard. Also
>> >> added his R-b's.
>> >>
>> >> You can fetch this series from:
>> >>   https://github.com/cota/qemu/tree/riscv-lookup_ptr-v2
>> >
>> > RISC-V maintainers: any plans of picking this up for 3.1?
>>
>> Thanks for CCing me.
>>
>> I think Michael must be really busy, I haven't seen any activity for
>> awhile. I'm going to send a PR with everything that has been reviewed
>> and applies cleanly.
>
> Thanks!
>
> Did patch 1 not apply cleanly? I see it's not part of the pullreq
> you just sent.
>
> I'd like the three patches to go in in the original order, since
> the perf numbers in patch 3's commit log are laid out assuming
> that is the case.

The content of patch 1 was applied in this commit:

commit 07ea28b41830f946de3841b0ac61a3413679feb9
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Wed May 30 18:06:23 2018 -0700

    tcg: Pass tb and index to tcg_gen_exit_tb separately

    Do the cast to uintptr_t within the helper, so that the compiler
    can type check the pointer argument.  We can also do some more
    sanity checking of the index argument.

    Reviewed-by: Laurent Vivier <laurent@vivier.eu>
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

https://github.com/qemu/qemu/commit/07ea28b41830f946de3841b0ac61a3413679feb9

so unfortunately the patch no longer applies.

Alistair

>
> Cheers,
>
>                 Emilio
