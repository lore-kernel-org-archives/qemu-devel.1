Received: from eggs.gnu.org ([209.51.188.92]:39287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2zWi-0007L1-GJ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2zWh-0004P2-Ay
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:34:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h2zWa-0004L9-AM
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:34:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
Date: Sun, 10 Mar 2019 15:33:53 +0100
In-Reply-To: <CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
	(Peter Maydell's message of "Thu, 7 Mar 2019 10:13:13 +0000")
Message-ID: <877ed6x0ha.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 7 Mar 2019 at 06:39, Thomas Huth <thuth@redhat.com> wrote:
>> On 06/03/2019 19.12, Paolo Bonzini wrote:
>> > lately I have been thinking of converting the QEMU build system to
>> > Meson.  Meson is a relatively new build system that can replace
>> > Autotools or hand-written Makefiles such as QEMU; as a die-hard
>> > Autotools fan, I must say that Meson is by far better than anything else
>> > that has ever tried to replace Autotools, and actually has the potential
>> > to do so.
>> >
>> > Advantages of Meson that directly matter for QEMU include:[...]
>>
>> I'm not objecting a new build system per se, but could you elaborate on
>>  problems of the current QEMU build system that will be fixed by this
>> change? Since apart from some minor glitches (with the *.mak file
>> dependencies for example), the current build system seems to work quite
>> well for me ... so at least I currently don't feel enough pain yet to do
>> such a big step, just because there is another new cool build system
>> around...
>
> Yes, that tends to be my view. Our current build system:
>  * has no dependencies that are problematic for older hosts
>    (contrast Meson, which needs Python 3.5, even if we take
>    the drastic step of shipping an entire build tool along
>    with QEMU; OSX python is 2.7 still)

By the time Meson is ready for us, and we're ready for Meson, chances
are even OS-X has moved on from Python 2.

https://pythonclock.org/

>  * is not particularly hard to deal with for the common cases
>    ("add new source file" is straightforward)

Yes.  Quite an achievement.

>  * covers all our requirements as far as I'm aware
>    (whereas you've listed a couple of places where Meson
>    would need changes/extensions to support things we do already)
>  * is generally flexible enough to be hackable to deal with odd
>    cases (it has escape mechanisms to generic-programmability,
>    even if they're ugly and awkward)

Yes, it's hackable, but it takes quite a hacker to hack it.  While it's
reasonably easy to do simple things in it with basic voodoo skills, the
learning curve goes up like the Zimbabwean inflation rate after that.  I
got plenty of experience in Make, and consider myself pretty fluent, yet
I find myself running to Paolo for help.

> So I think we'd need a more compelling reason to move right now.
> (This might change in the future, eg if Meson catches on to the
> extent that everybody is using it and competitors like CMake are
> more obviously eclipsed by it, in the way that git took over
> from svn and relegated mercurial and bzr to obscurity.)
>
> thanks
> -- PMM
