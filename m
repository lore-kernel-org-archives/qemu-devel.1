Received: from eggs.gnu.org ([2001:4830:134:3::10]:53265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk6qy-0004BB-2K
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 08:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk6qx-0002aT-1H
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 08:00:44 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk6qw-0002Zz-QI
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 08:00:42 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so20697972oie.13
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 05:00:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsJnejaweD24bFR9BEZyJ+yiyabX6a9F3cmGBhqXp5Z=A@mail.gmail.com>
References: <1527229488-49822-1-git-send-email-mjc@sifive.com>
	<83728e91-de69-c376-a768-0aad501ff64e@twiddle.net>
	<CAFEAcA-hOTPOfW7ruRsSYt32Ahu707iMJtXdXkUREpLyHdFwJQ@mail.gmail.com>
	<CAHNT7NsJnejaweD24bFR9BEZyJ+yiyabX6a9F3cmGBhqXp5Z=A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 13:00:21 +0100
Message-ID: <CAFEAcA8KxwoJGKY6++7uNp29orJDWivnq0YQ_TPzQzoh38NpQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Correct typo in RV32 perf counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Richard Henderson <rth@twiddle.net>

On 30 July 2018 at 12:42, Michael Clark <mjc@sifive.com> wrote:
>
>
> On Mon, 30 Jul 2018 at 10:46 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>>
>> On 25 May 2018 at 14:17, Richard Henderson <rth@twiddle.net> wrote:
>> > On 05/24/2018 11:24 PM, Michael Clark wrote:
>> >> This patch enables mhpmcounter3h through mhpmcounter31h on RV32.
>> >> Previously the RV32 h versions (high 32-bits of 64-bit counters)
>> >> of these counters would trap with an illegal instruction instead
>> >> of returning 0 as intended.
>> >>
>> >> Reported-by: Richard Henderson <rth@twiddle.net>
>> >> Signed-off-by: Michael Clark <mjc@sifive.com>
>> >> ---
>> >>  target/riscv/op_helper.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > Fixes: Coverity CID 1390849
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> Ping -- Coverity is still complaining about this -- did this
>> patch get lost?
>
>
> Sort of. I assumed it would go into a trivial queue.

As a general rule of thumb, patches which apply to an area
of code which has a maintainer (especially when that area is
in active development, as riscv is), usually go through that
maintainer's tree. Picking up and shepherding patches like this
into master is one of the things maintainers do in QEMU's system.
The -trivial queue mostly exists for things which would otherwise
fall through the cracks between different subsystems.

> Feel free to apply, however it=E2=80=99s going to create (another) rebase=
 conflict
> against my =E2=80=98for-upstream=E2=80=99 queue as this code has gone awa=
y, hence it is not
> in my queue.

That sort of possibility for conflicts is why it makes more sense
to put even fairly minor patches through maintainer trees rather
than via -trivial).

> I can include this change in my pull for 3.1, along with the patches in m=
y
> tree that have Reviewed-by and fix the rebase conflicts for anything that
> depends on new context (hopefully not creating new bugs during that
> process).

If the code has been removed then you don't need to put this
patch in your pullrequest for 3.1, because you already have
changes that make it moot. (Given that Coverity spotted
it rather than an actual user it doesn't seem like a bug fix
urgent enough to put in 3.0.)

thanks
-- PMM
