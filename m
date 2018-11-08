Received: from eggs.gnu.org ([2001:4830:134:3::10]:57869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKpHj-0006FE-L9
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKpHi-0002Xk-4h
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:44:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gKpHh-00024P-P1
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:44:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181108143422.15955-1-philmd@redhat.com>
	<20181108171716.GN12503@habkost.net>
	<CAFEAcA-t5qOHngv9ciTkuakmT84N7QV4c0=TYMD-NUgh5uT_DA@mail.gmail.com>
	<CAP+75-WTmYUAWgOZ7cf2jsaqvQVv+atBzatUgDOhudz1kqPg4g@mail.gmail.com>
	<CAFEAcA8XK51Uun6MUQDSOMAN7aCQ0TtKzQBWtVXtBx9=A5yECw@mail.gmail.com>
	<5f495bd7-8489-4e8f-8fd5-d0bb28787fa4@redhat.com>
	<CAFEAcA-CtBWk-JYBw=Jk3Pqp_U1e_aA9Rcvs=mtwOqjZK0AX=g@mail.gmail.com>
Date: Thu, 08 Nov 2018 19:42:57 +0100
In-Reply-To: <CAFEAcA-CtBWk-JYBw=Jk3Pqp_U1e_aA9Rcvs=mtwOqjZK0AX=g@mail.gmail.com>
	(Peter Maydell's message of "Thu, 8 Nov 2018 18:18:02 +0000")
Message-ID: <87o9azjtqm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: Remove unused python imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 8 November 2018 at 18:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>> Anyway there are no information about merge window in the wiki.
>> When I started it was not easy to understand it and why patches sent when
>> 'merge window is close' fall under the crap and are unnoticed, thus it is
>> better to wait before to send, or resend them.
>
> The intention (not always something we succeed at) is that
> maintainers should respond to patches, do review, etc, at
> any point in our release cycle. During a release they might
> reply to say "I won't get to reviewing this for a little while"
> or "I'll take this patch once the trunk reopens for releases",

In both cases, the maintainer remains responsible for tracking the
patches.

I believe the sane thing to do is to review patches as usual, and to
queue the ones that are ready to go into the next release on a separate
branch.

> but they shouldn't just leave patch submitters with no response
> at all...

Yes, that's rude.

[...]
