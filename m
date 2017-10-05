Received: from eggs.gnu.org ([2001:4830:134:3::10]:60809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e06u7-00014u-NK
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e06u6-0001ES-Hw
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:13:35 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:56604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e06u6-0001E3-Db
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:13:34 -0400
Received: by mail-oi0-x22c.google.com with SMTP id v9so12618374oif.13
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:13:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87sheyi4uj.fsf@dusky.pond.sub.org>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-20-armbru@redhat.com>
	<CAJ+F1CJYd4LqyPtkmr40tnCKhDV63urnAhUgkX=M++njtPmgYw@mail.gmail.com>
	<87sheyi4uj.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Oct 2017 16:13:32 +0200
Message-ID: <CAJ+F1CJbOkWCbJZj0D-oBT4STr7zqG1hdhB70eyShG6taSmRSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Oct 5, 2017 at 6:41 AM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>>> The QAPI schema parser has always accepted only single-quoted strings,
>>> even though JSON strings are double-quoted.  Accept double-quoted
>>> strings as well, so you can write strings containing single quotes
>>> without backslash escapes.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> What's the motivation to allow both? If we were to switch from single
>> to double quote only, that would make more sense.
>
> Abandoning single quotes now would require us to touch pretty much every
> line of code in the schemas.  I don't think correcting quotes is worth
> wrecking git-blame.
>

Recent (and upcoming) changes to the schema are already quite
invasive. I think we could do it, convert all strings to double-quote,
and it would help with getting the schema closer to a valid json.

Fwiw, there are tools like
https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools=
/docs/html/git-hyper-blame.html
to skip commits in git-blame. It's also fairly easy to run git blame
before the reformatting commit.

> Sadly, the schema language is neither JSON, nor an established extension
> of JSON, nor Python.  This commit brings the schema language one step
> closer to a superset of JSON.  I feel "homegrown superset" is a slightly
> less bad idea than "homegrown with large overlap".
>
> Naming the schema files .json was in bad taste.
>
>> otherwise, patch looks good
>
> Ready to upgrade to R-by now?
>
> Want me to work more of my rationale into the commit message?

--=20
Marc-Andr=C3=A9 Lureau
