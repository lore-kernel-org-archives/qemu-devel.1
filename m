Received: from eggs.gnu.org ([2001:4830:134:3::10]:32861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYVff-00052d-BO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYVfb-0008UY-JK
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:05:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYVfb-0008Tc-DT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:05:03 -0400
Date: Thu, 28 Jun 2018 13:04:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628120458.GG3513@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628110254.6725-1-berrange@redhat.com>
	<20180628110254.6725-3-berrange@redhat.com>
	<f4be1ffd-3bd4-f8f8-c283-b59993971ca3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4be1ffd-3bd4-f8f8-c283-b59993971ca3@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/2] Delete AF_UNIX socket after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Pavel Balaev <mail@void.so>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Jun 28, 2018 at 07:02:38AM -0500, Eric Blake wrote:
> On 06/28/2018 06:02 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: Pavel Balaev <mail@void.so>
> >=20
> > This is a second attempt at sending this patch:
> >=20
> > http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg04697.html
>=20
> I'm not stopping the pull request, but this particular commit message i=
s not
> very useful. A year from now, looking through 'git log' will tell us no=
thing
> about the "why" for this patch (the subject line only covers the "what"=
).
> And at that time, no one will care how many failed attempts went throug=
h the
> list, but only what actually got committed.  Better would have been jus=
t
> directly using the message from that mail:
>=20
> > > Since version 2.12.0 AF_UNIX socket created for QMP exchange is not
> > > deleted on instance shutdown.
> > >=20
> > > This is due to the fact that function qio_channel_socket_finalize()=
 is
> > > called after qio_channel_socket_close().
>=20
> As a hint for future patches, mentioning that a post is a second versio=
n and
> replaces an earlier post to the list is best done after the --- line (w=
here
> it is still readable on list as an aid to reviewers, but dropped by the
> maintainer using 'git am' as unnecessary fluff for the git log). More p=
atch
> submission tips at: https://wiki.qemu.org/Contribute/SubmitAPatch

Yeah, sorry my bad - i had intended to fix up the commit message but
completely forgot.

Peter, please ignore this PR, I will resend.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
