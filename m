Received: from eggs.gnu.org ([2001:4830:134:3::10]:42501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMzK8-0007J9-7w
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gMzJy-0005dU-17
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:51:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gMzJu-0005aa-6t
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:51:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<871s7nstle.fsf@dusky.pond.sub.org>
	<e935a267-a5ae-4dd4-a1a7-064c084671ab@redhat.com>
	<874lcjra28.fsf@dusky.pond.sub.org>
	<0e7341c4-364f-187a-4136-abc607d989df@redhat.com>
Date: Wed, 14 Nov 2018 18:51:08 +0100
In-Reply-To: <0e7341c4-364f-187a-4136-abc607d989df@redhat.com> (Thomas Huth's
	message of "Wed, 14 Nov 2018 17:52:33 +0100")
Message-ID: <87lg5vlf8z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, renzo@cs.unibo.it, Jan Kiszka <jan.kiszka@siemens.com>, rjones@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, samuel.thibault@ens-lyon.org

Thomas Huth <thuth@redhat.com> writes:

> On 2018-11-14 15:46, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 2018-11-14 13:59, Markus Armbruster wrote:
>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
>>>>>
>>>>> This series goal is to allow building libslirp as an independent libr=
ary.
>>>>>
>>>>> While looking at making SLIRP a seperate running process, I thought
>>>>> that having an independent library from QEMU would be a first step.
>>>>>
>>>>> There has been some attempts to make slirp a seperate project in the =
past.
>>>>> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
>>>>> Unfortunately, they forked from QEMU and didn't provide enough
>>>>> compatibility for QEMU to make use of it (in particular, vmstate
>>>>> handling was removed, they lost git history etc). Furthermore, they
>>>>> are not maintained as far as I can see.
>>>>>
>>>>> I would propose to make slirp a seperate project, that can initially
>>>>> be used by QEMU as a submodule, keeping Makefile.objs until a proper
>>>>> shared library with stability guarantees etc is ready..
>>>>>
>>>>> The subproject could created by preserving git tags, and cleaning up =
the code style, this way:
>>>>>
>>>>> git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then clan=
g-format -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prune-empt=
y --tag-name-filter cat -- --all
>>>>> (my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e2fb8=
a2404678ac73)
>>>>>
>>>>> What do you think?
>>>>
>>>> Has the slirp code been improved to be generally useful?  I still got =
it
>>>> filed under "friends don't let friends use that, except for testing"...
>>>
>>> The slirp code is already used in a lot of other projects:
>>=20
>> The issue I have with SLIRP isn't that it solves a useless problem (au
>> contraire!), it's that it's a useless solution.
>
> Ouch, that was completely arrogant and inappropriate. It's far away from
> being useless,

... as I immediately admit ...

>                and Samuel is doing a very good job in picking up all the
> patches and fixes that have been posted in the past months. Have you had
> a look at the changelog at all before you wrote that sentence?

... right in the next sentence:

>> Okay, that's an unfair
>> exaggeration, it's not useless, I just wouldn't trust it in production,
>> unless it has improved significantly since I last looked at it.

If my joke offended Samuel, or anyone, I offer my sincere apologies.

> Nobody said that the slirp code would suddenly be perfect, but if it's
> getting even more traction and attention as a separate library (since
> other projects might contribute their fixes back "upstream" in that
> case), it could really get a solid building block for a lot of emulators
> and similar software.
[...]

I'm afraid we're in violent agreement there.  I wrote:

>> No objections to spinning it out, as long as it comes with a fair
>> assessment of its limitations.
>>=20
>> Turning it into a proper project might even improve its chances to
>> get improved towards production quality, compared to its current
>> existence as a corner of QEMU next to nobody wants to touch.
