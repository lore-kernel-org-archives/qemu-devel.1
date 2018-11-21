Received: from eggs.gnu.org ([2001:4830:134:3::10]:53115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPTNr-0004JF-WA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPTNr-0007Wa-Cw
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:21:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPTNr-0007Vo-7v
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:21:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
	<20181121115718.GN26577@redhat.com>
	<20181121072237-mutt-send-email-mst@kernel.org>
Date: Wed, 21 Nov 2018 15:21:34 +0100
In-Reply-To: <20181121072237-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Wed, 21 Nov 2018 07:23:36 -0500")
Message-ID: <87sgzu340h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: tap: use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Li Qiang <liq3ea@gmail.com>, Jason Wang <jasowang@redhat.com>, =?utf-8?Q?Marc-An?= =?utf-8?Q?dr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Nov 21, 2018 at 11:57:18AM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Nov 21, 2018 at 03:28:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> > Hi
>> >=20
>> > On Wed, Nov 21, 2018 at 3:22 PM Li Qiang <liq3ea@gmail.com> wrote:
>> > >
>> > > The fcntl will change the flags directly, use qemu_set_nonblock()
>> > > instead.
>> >=20
>> > qemu_set_nonblock() will preserve the existing flags. And on windows,
>> > it will register the FD to the event loop.
>> > that's a reasonable thing to do, is this fixing an actual bug?
>>=20
>> tap.c is only built with CONFIG_POSIX. Win32 is completely separate
>> in tap-win32.c.  So the event loop reg doesn't apply.
>>=20
>> I agree it is good to preserve fcntl flags though, so this patch
>> looks desirable.
>>=20
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Sure
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> but really not for this release I guess as we are in freeze.

That's fair.

> So thanks! And pls remember to ping after the release.

I strongly recommend maintainers do not use patch submitters as
substitutes for git branches.  Just create a branch for collecting stuff
for the next development cycle, merge the thing, say thank you, and let
the patch submitter move on.
