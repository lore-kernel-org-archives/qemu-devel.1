Received: from eggs.gnu.org ([2001:4830:134:3::10]:49155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQ3Aw-0002i4-FM
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 00:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQ3Av-0003uf-KL
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 00:02:26 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
	<87tvqjf28u.fsf@dusky.pond.sub.org>
	<3f5aaa32-5e43-542b-c657-3f1eec553e70@redhat.com>
	<df356e6b-8559-1a79-17cf-47bdfeb8612d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b088605a-477f-4c80-34d8-c6677cfdb37e@redhat.com>
Date: Tue, 5 Jun 2018 06:02:17 +0200
MIME-Version: 1.0
In-Reply-To: <df356e6b-8559-1a79-17cf-47bdfeb8612d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/17] iotests: ask qemu for supported
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 05.06.2018 00:40, Eric Blake wrote:
> On 06/04/2018 05:34 AM, Thomas Huth wrote:
>> On 04.06.2018 09:18, Markus Armbruster wrote:
>>> Roman Kagan <rkagan@virtuozzo.com> writes:
>>>
>>>> Add helper functions to query the block drivers actually supported b=
y
>>>> QEMU using "-drive format=3D?".=C2=A0 This allows to skip certain te=
sts that
>>>> require drivers not built in or whitelisted in QEMU.
>>>>
>=20
>>>> +=C2=A0=C2=A0=C2=A0 supported_formats=3D$($QEMU_PROG $QEMU_OPTIONS -=
drive format=3D\?
>>>> 2>&1 | \
>>>
>>> Use of '?' to get help is deprecated.=C2=A0 Please use 'format=3Dhelp=
', and
>>> update your commit message accordingly.
>>
>> Is it? Where did we document that?
>=20
> Hmm, we haven't documented it yet, but it's been that way since commit
> c8057f95, in Aug 2012, when we added 'help' as the preferred synonym,
> and have tried to avoid mention of '?' in new documentation (as it
> requires additional shell quoting).=C2=A0 I'm guessing we'll probably s=
ee a
> patch from you to start an official deprecation window?

I'm using '?' regularly on my own, so don't expect a patch from
my side here ;-)
Anyway, we still use the question mark in our documentation, e.g.:

options

    is a comma separated list of format specific options in a name=3Dvalu=
e format.
    Use -o ? for an overview of the options supported by the used format =
or see
    the format descriptions below for details.

or:

-b, --blacklist=3Dlist

    Comma-separated list of RPCs to disable (no spaces, =E2=80=98?=E2=80=99=
 to list available RPCs)

So calling it deprecated sounds wrong to me.

 Thomas
