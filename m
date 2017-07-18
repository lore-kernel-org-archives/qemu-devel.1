Received: from eggs.gnu.org ([2001:4830:134:3::10]:35433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQbt-00027S-LA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQbs-0005Do-JL
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:24:13 -0400
MIME-Version: 1.0
In-Reply-To: <87bmoi806u.fsf@linaro.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-27-f4bug@amsat.org>
	<CAJ+F1C+WsdUp3Vtx+-FZ9g7URSAQuJWb6h7-w6yJXM+4TKQNjA@mail.gmail.com>
	<87bmoi806u.fsf@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 04:24:00 -0700
Message-ID: <CAJ+F1CLXojLp2VxET469gBLsaSwCvkQoGODOMyFUs3jUbkdk3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 26/29] tests/tcg: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

Hi

On Tue, Jul 18, 2017 at 4:16 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> Hi
>>
>> On Mon, Jul 17, 2017 at 11:10 PM, Philippe Mathieu-Daud=C3=A9
>> <f4bug@amsat.org> wrote:
>>> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osde=
p.cocci
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  tests/tcg/alpha/test-cond.c | 2 +-
>>>  tests/tcg/alpha/test-ovf.c  | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>
>> I think those do not include osdep.h
>>
>> (sigh, tests/tcg would need some love ;)
>
> Pranith has had a couple of revs at this:
>
>   Subject: [PATCH v5 00/19] Cleanup of TCG tests
>   Date: Thu,  1 Dec 2016 00:14:14 -0500
>   Message-Id: <20161201051433.17168-1-bobby.prani@gmail.com>
>
> We have the cross-compilers available as a fallback via docker although
> not every one can seamlessly use it for building stuff. Is getting a
> working cross-compiler setup too much of a hurdle fore those that want
> to build cross-arch tests?

Yes, I also did some experiments in cleaning up tests/tcg
(https://github.com/elmarco/qemu/tree/tcg-tests)

The trouble is I don't see an official/automated way to run tests/tcg
tests. Which cross-compiler should I use? When I played with this,
they all had various quirks, on Fedora, Debian or crosstool-ng. I
haven't looked at the docker tests, is this running tests/tcg test
somehow?
