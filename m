Received: from eggs.gnu.org ([2001:4830:134:3::10]:45052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eD8rv-0005Xa-3E
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 07:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eD8ru-0007rw-3V
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 07:57:11 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eD8rt-0007pJ-TB
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 07:57:10 -0500
Received: by mail-wm0-x242.google.com with SMTP id p75so2574479wmg.3
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 04:57:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5a7b721c-fe04-921b-b9d2-986c9930b00b@amsat.org>
References: <1510228971-6005-1-git-send-email-sundeep.lkml@gmail.com>
	<4beb4e47-0ff9-8251-6502-23824779edbd@amsat.org>
	<CAFEAcA-ATtAougvALVo=48p+jVx5B+Ejq60TD9dGYEQU2ReWCQ@mail.gmail.com>
	<5a7b721c-fe04-921b-b9d2-986c9930b00b@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Nov 2017 12:56:47 +0000
Message-ID: <CAFEAcA_0jvR90=N9Pd+oA2U6Yy=oF7vvNV67cEAsUYQFcup9KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel PATCH] MAINTAINERS: Add entries for
 Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 10 November 2017 at 00:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 11/09/2017 08:55 PM, Peter Maydell wrote:
>> I don't in general expect to take pull requests from
>> everybody listed as a maintainer in the MAINTAINERS file.
>> That just means "I'm going to be reviewing and should
>> be cc'd on patches". Pull requests are sent by people
>> who are maintainers for a subsystem. Rule of thumb:
>> unless somebody asks you to send a pull request, you
>> don't need to do it.
>
> Ok, please apologize my misunderstanding. I still think the M: entry
> stand for 'Maintainer' instead of 'Mail', and still don't understand the
> difference with a "Designated reviewer" (R: entry):
>
>         M: Mail patches to: FullName <address@domain>
>         R: Designated reviewer: FullName <address@domain>
>            These reviewers should be CCed on patches.
>
> "Designated reviewer" seems to duplicate the M: entry and is therefore
> confusing. Can we simply remove it instead?

I hadn't realized we had an 'R:' tag in MAINTAINERS...

> --
> Some people are not content with the amount of mail they get, and would
> like to be CCed on patches for areas they do not maintain.  Let them
> satisfy their own appetite for qemu-devel messages.
>
> Seriously: the purpose here is a bit different from the Linux kernel.
> While Linux uses "R" to designate non-maintainers for reviewing patches
> in a given area, in QEMU I would also like to use "R" so that people can
> delegate sending pull requests while keeping some degree of oversight.
> --

So, my view, based on what happens in practice:
 * "maintainer" means you are in effect accepting some responsibility
   for the continued maintenance of some bit of the codebase, ie
   you actually will review stuff
 * "reviewer" is a bit weird but I guess is just asking for cc:
   without promising to actually do anything
 * somebody who sends me pull requests is effectively somebody we've
   given the ability to make direct more-or-less unchecked commits
   to master, so that is given out more sparingly and for larger
   subsystems

But MAINTAINERS is mostly about what submitters need to do (ie
who to send patchmails to), so it doesn't particularly document
how patches flow onward into master, which varies. (For instance
the block layer folks have a two-level setup where some trees
get merged into others before they go to master. ARM devboards
go through me, and "maintainer" just means I let somebody else
deal with the device specifics if possible but am still the
reviewer of last resort.)

thanks
-- PMM
