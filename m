Received: from eggs.gnu.org ([2001:4830:134:3::10]:33914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwnyt-0008Qy-58
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwnyp-0002MH-6Y
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:29:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fwnyp-0002Lw-1I
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:29:19 -0400
Date: Mon, 3 Sep 2018 13:29:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180903122915.GE14377@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-2-sameeh@daynix.com>
	<20180903115926.GB14377@redhat.com>
	<CAFEAcA8HATZQqawAX3=OPmas6uzp0UAciK7QXo=uuRbCfvUjaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8HATZQqawAX3=OPmas6uzp0UAciK7QXo=uuRbCfvUjaQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/6] Add bpf support to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Sep 03, 2018 at 01:24:16PM +0100, Peter Maydell wrote:
> On 3 September 2018 at 12:59, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
>=20
> >>  ##########################################
> >> +# check for usable bpf system call
> >> +if test "$bpf" =3D "yes"; then
> >
> > if test "x$bpf" !=3D "xno"; then
>=20
> We don't use the leading-x thingy elsewhere in configure,
> why is this condition special?
> (We can assume we don't have a broken shell, and we
> know that $bpf won't be a string starting with a hyphen.)

It is just my habit. Drop the 'x' prefix if that's not used in QEMU's
configure script normally.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
