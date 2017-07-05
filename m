Received: from eggs.gnu.org ([2001:4830:134:3::10]:44744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSman-0004nw-V3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSmak-0005cu-SV
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:51:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170626101159.19676-1-berrange@redhat.com>
	<c4381bd8-a417-0c3b-f3c2-1292ca9f6dfc@redhat.com>
	<20170705134104.GD1280@stefanha-x1.localdomain>
Date: Wed, 05 Jul 2017 17:51:43 +0200
In-Reply-To: <20170705134104.GD1280@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 5 Jul 2017 14:41:04 +0100")
Message-ID: <87bmoynapc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] sockets: avoid formatting buffer that may
 not be NULL terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Jun 26, 2017 at 12:19:40PM +0200, Thomas Huth wrote:
>> On 26.06.2017 12:11, Daniel P. Berrange wrote:
>> > The 'sun_path' field in the sockaddr_un struct is not required
>> > to be NULL termianted, so when reporting an error, we must use
>> 
>> s/NULL/NUL/
>> 
>> NULL is a pointer, NUL is the '\0' character.
>
> I wanted to point out the same thing to someone recently, so I chased up
> a reference to the NUL character in RFC 20 "ASCII format for Network
> Interchange".  After all, no one can argue with an RFC.
>
> What I found shocked me!  There must be a typo in the ASCII RFC:
> https://tools.ietf.org/html/rfc20#section-5.2
>
> I closed my browser tab quickly and headed to Wikipedia instead.  If the
> primary source didn't support my argument, I could always count on good
> old Wikipedia...
>
> But do you know what I found?  Someone had conflated nul and null on the
> Wikipedia entry:
> https://en.wikipedia.org/wiki/Null_character
>
> Amateurs!  The Wikipedia editors probably didn't have the intellectual
> calibre to question the correctness of the RFC text the way I did.
>
> But to cut a long story short, as my search continued the evidence
> became overwhelming.  It is acceptable to refer to the nul character as
> the null character.
>
> Coming back to the patch in question, although we can't complain about
> the "NULL" it's with considerable joy that I'd like to highlight:
>
> s/termianted/terminated/
>
> :)
> Stefan

Despite this shocking, shocking precedence, I formally object to the use
of NULL in the context of C for anything other than "one particular null
pointer".  C's confusing enough without overloading identifiers.
