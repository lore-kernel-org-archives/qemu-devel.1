Received: from eggs.gnu.org ([2001:4830:134:3::10]:60814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epGwT-0003yv-UC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epGwQ-0000a0-Fl
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:15:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epGwQ-0000YG-4R
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:15:26 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211004013.10784-1-eblake@redhat.com>
	<20180211004013.10784-4-eblake@redhat.com>
	<20180212095231.GF4071@redhat.com>
	<CAJ+F1CKLhP88mTk7bn-VYfGra1BGTALtgj8tmgksq2-pDdJPJA@mail.gmail.com>
Date: Fri, 23 Feb 2018 18:15:09 +0100
In-Reply-To: <CAJ+F1CKLhP88mTk7bn-VYfGra1BGTALtgj8tmgksq2-pDdJPJA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 12 Feb 2018
	11:17:11 +0100")
Message-ID: <87o9kfljaa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] qapi: Rename .json to .qapi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Feb 12, 2018 at 10:52 AM, Daniel P. Berrang=C3=A9
> <berrange@redhat.com> wrote:
>> On Sat, Feb 10, 2018 at 06:40:13PM -0600, Eric Blake wrote:
>>> Our QAPI input files aren't quite true JSON (comments being the obvious
>>> difference); naming things .json doesn't make that obvious.  Use a new
>>> suffix .qapi that makes it easy to identify our files.
>>>
>>> This change is mostly mechanical, but it is not just a global
>>> search-and-replace as some instances of '.json' really do refer
>>> to JSON files, or to a URL that can't change, and so on.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>
>>> I'd also like help figuring out how to make .dir-locals.el give
>>> an automatic sane mode to all .qapi files
>>
>> Stuff I'm reading the suggests the only way to achieve that is to
>> use 'eval' which is considered unsafe for .dir-locals.el. As a
>> result the user will get prompted to allow the "eval" to run
>> when emacs starts which is unpleasant :-(
>>
>
> I suggested such patch some time ago:
>
> "[PATCH 2/2] .dir-locals.el: add json schema to auto-mode"
>
> I still consider that a one time prompt for this is fairly unintrusive
> (after all you, run so much code you trust blindly by doing make check
> from qemu :)

Quoting myself (Message-ID: <878thydawr.fsf@dusky.pond.sub.org>):

    Not a nice user experience.  [...]

    Why can't we simply use the usual file name extension like a normal
    person?

    If that's too much to ask, then I'd recommend adding modelines (like the
    ones you delete) to the Makefiles that lack one.

>> Alternatively though, just add "-*- json -*-" in a comment in
>> the first line of the file
>
>
> In each file, that's intrusive.

Interrupting every developer looking at source file with Emacs the first
time with a question that has security implications is also intrusive.
I've made my preference clear.

We already have modelines in 20 out of 190 .json files.  The missing one
are all under tests/.

>                                 Especially because there are no
> comments in json in theory :)

That's one of the reasons we use "-*- Mode: Python -*-" instead.
