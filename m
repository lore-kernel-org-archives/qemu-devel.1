Received: from eggs.gnu.org ([2001:4830:134:3::10]:57355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LCP-0003cJ-Et
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LCM-0003xX-BF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:29:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e0LCM-0003w6-61
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:29:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-20-armbru@redhat.com>
	<CAJ+F1CJYd4LqyPtkmr40tnCKhDV63urnAhUgkX=M++njtPmgYw@mail.gmail.com>
	<87sheyi4uj.fsf@dusky.pond.sub.org>
	<CAJ+F1CJbOkWCbJZj0D-oBT4STr7zqG1hdhB70eyShG6taSmRSw@mail.gmail.com>
Date: Fri, 06 Oct 2017 07:29:19 +0200
In-Reply-To: <CAJ+F1CJbOkWCbJZj0D-oBT4STr7zqG1hdhB70eyShG6taSmRSw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 5 Oct 2017
	16:13:32 +0200")
Message-ID: <877ew8alow.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 19/32] qapi: Accept double-quoted
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Thu, Oct 5, 2017 at 6:41 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>>> On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> w=
rote:
>>>> The QAPI schema parser has always accepted only single-quoted strings,
>>>> even though JSON strings are double-quoted.  Accept double-quoted
>>>> strings as well, so you can write strings containing single quotes
>>>> without backslash escapes.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> What's the motivation to allow both? If we were to switch from single
>>> to double quote only, that would make more sense.
>>
>> Abandoning single quotes now would require us to touch pretty much every
>> line of code in the schemas.  I don't think correcting quotes is worth
>> wrecking git-blame.
>>
>
> Recent (and upcoming) changes to the schema are already quite
> invasive. I think we could do it, convert all strings to double-quote,
> and it would help with getting the schema closer to a valid json.

Is the recent (and upcoming) churn *that* bad?  Got numbers?

> Fwiw, there are tools like
> https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_too=
ls/docs/html/git-hyper-blame.html
> to skip commits in git-blame. It's also fairly easy to run git blame
> before the reformatting commit.

Both techniques add friction...

>> Sadly, the schema language is neither JSON, nor an established extension
>> of JSON, nor Python.  This commit brings the schema language one step
>> closer to a superset of JSON.  I feel "homegrown superset" is a slightly
>> less bad idea than "homegrown with large overlap".
>>
>> Naming the schema files .json was in bad taste.
>>
>>> otherwise, patch looks good
>>
>> Ready to upgrade to R-by now?
>>
>> Want me to work more of my rationale into the commit message?
