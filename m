Received: from eggs.gnu.org ([2001:4830:134:3::10]:54846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMuY-0006xM-1t
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faMuX-0002t8-7z
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:08:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34494 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faMuX-0002sx-3U
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:08:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-10-marcandre.lureau@redhat.com>
	<87efgkbjwc.fsf@dusky.pond.sub.org>
	<CAJ+F1C+7PNgM=Qq4d4HmG6VfneML6WGPbhh68WwReUicE1B_JA@mail.gmail.com>
	<87h8lga0sh.fsf@dusky.pond.sub.org>
Date: Tue, 03 Jul 2018 17:08:05 +0200
In-Reply-To: <87h8lga0sh.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 03 Jul 2018 15:47:42 +0200")
Message-ID: <87tvpg73xm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 09/15] qapi-introspect: add preprocessor
 conditions to generated QLit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

[...]
> Let's add a hint to the commit message.  Pergaps:
>
>     qapi-introspect: add preprocessor conditions to generated QLit
>
>     This commit adds 'ifcond' conditions to top-level QLit objects.
>     Future work will add them to object and enum type members, i.e. within
>     QLit objects.
>
>     Extend the QLit generator to_qlit() to accept (@obj, @cond) tuples in
>     addition to just @obj.  The tuple causes the QLit generated for
>     objects for @obj with #if/#endif conditions for @cond.
>
>     See generated tests/test-qmp-introspect.c.  Example diff after this
>     patch:
>     [...]

With that,
Reviewed-by: Markus Armbruster <armbru@redhat.com>
