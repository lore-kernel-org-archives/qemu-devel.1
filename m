Received: from eggs.gnu.org ([2001:4830:134:3::10]:42811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1elBAg-0007gd-Rx
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 05:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1elBAf-00020Q-EF
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 05:17:14 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1elBAf-0001zc-6m
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 05:17:13 -0500
Received: by mail-wm0-x22e.google.com with SMTP id 141so8798340wme.3
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 02:17:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212095231.GF4071@redhat.com>
References: <20180211004013.10784-1-eblake@redhat.com>
	<20180211004013.10784-4-eblake@redhat.com>
	<20180212095231.GF4071@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Feb 2018 11:17:11 +0100
Message-ID: <CAJ+F1CKLhP88mTk7bn-VYfGra1BGTALtgj8tmgksq2-pDdJPJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Mon, Feb 12, 2018 at 10:52 AM, Daniel P. Berrang=C3=A9
<berrange@redhat.com> wrote:
> On Sat, Feb 10, 2018 at 06:40:13PM -0600, Eric Blake wrote:
>> Our QAPI input files aren't quite true JSON (comments being the obvious
>> difference); naming things .json doesn't make that obvious.  Use a new
>> suffix .qapi that makes it easy to identify our files.
>>
>> This change is mostly mechanical, but it is not just a global
>> search-and-replace as some instances of '.json' really do refer
>> to JSON files, or to a URL that can't change, and so on.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> I'd also like help figuring out how to make .dir-locals.el give
>> an automatic sane mode to all .qapi files
>
> Stuff I'm reading the suggests the only way to achieve that is to
> use 'eval' which is considered unsafe for .dir-locals.el. As a
> result the user will get prompted to allow the "eval" to run
> when emacs starts which is unpleasant :-(
>

I suggested such patch some time ago:

"[PATCH 2/2] .dir-locals.el: add json schema to auto-mode"

I still consider that a one time prompt for this is fairly unintrusive
(after all you, run so much code you trust blindly by doing make check
from qemu :)

> Alternatively though, just add "-*- json -*-" in a comment in
> the first line of the file
>

In each file, that's intrusive. Especially because there are no
comments in json in theory :)


--=20
Marc-Andr=C3=A9 Lureau
