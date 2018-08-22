Received: from eggs.gnu.org ([2001:4830:134:3::10]:37048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWHL-0001Uc-Of
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWHH-0007Vk-QW
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:46:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsWHH-0007Tl-Ck
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:46:39 -0400
Date: Wed, 22 Aug 2018 17:46:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822164633.GT12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
	<CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
	<20180822160614.GQ12750@redhat.com>
	<CAJ+F1CK65vU4pkX9w8gbMfJdMfEXv5OZyXv6yRJbJjG1J1OYmg@mail.gmail.com>
	<CAJ+F1CLdOsxLu+cHScTDMPUm9iq=3NO6=F4wQJi2FSssVZBVuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLdOsxLu+cHScTDMPUm9iq=3NO6=F4wQJi2FSssVZBVuA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] seccomp: set the seccomp filter to
 all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Wed, Aug 22, 2018 at 06:39:52PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Aug 22, 2018 at 6:37 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Wed, Aug 22, 2018 at 6:08 PM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > > We would have to make libvirt probe for tsync support too, because =
it
> > > now unconditionally uses -sandbox for new enough QEMU.
> >
> > sigh :( that's where the -sandbox tsync option could have been helpfu=
l
> > keeping the compatibility.
>=20
> So what can libvirt do if tsync is not available?

It depends how libvirt is configured. If /etc/libvirt/qemu.conf has
seccomp=3D1, then we'd  blindly start QEMU and expect QEMU to fail
because -sandbox can't be usefully enforced. If qemu.conf has "seccomp"
unset, then we'd simply not use -sandbox flag for any guests.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
