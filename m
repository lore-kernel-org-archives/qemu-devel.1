Received: from eggs.gnu.org ([2001:4830:134:3::10]:55366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS1EP-0006Qp-Pg
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS1EO-0008Ib-Uz
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gS1EO-0008IG-P0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EC8E8830A
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 14:54:24 +0000 (UTC)
Date: Wed, 28 Nov 2018 14:54:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181128145409.GN24355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181128142135.15900-1-marcandre.lureau@redhat.com>
	<20181128143307.GM24355@redhat.com>
	<CAMxuvayS9ja1H-ftsahECEJU+T6EE8-KcYTpDnii8KdJHwaYmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvayS9ja1H-ftsahECEJU+T6EE8-KcYTpDnii8KdJHwaYmw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] configure: bump spice-server
 required version to 0.12.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, Frediano Ziglio <fziglio@redhat.com>

On Wed, Nov 28, 2018 at 06:46:37PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Nov 28, 2018 at 6:33 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > On Wed, Nov 28, 2018 at 06:21:35PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Looking at chardev/spice.c code, I realize compilation was broken f=
or
> > > a while with spice-server < 0.12.3. I propose to bump required vers=
ion
> > > to 0.12.6, released 3y ago, instead of adding more #ifdef.
> >
> > As mentioned last time this patch was posted[1], any changes in the
> > min required versions should follow our supported build platforms
> > support statement:
>=20
> Sorry, I totally forgot that.
>=20
> >
> >   https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platform=
s
> >
> > Preferrably the commit message should list the version in each of the
> > main distros, such as in a0722409bcb980ecdab8330d4c716a73c9fcb489
> >
> > At a glance it looks like Debian Jessie is likely to be the determini=
ng
> > vote with 0.12.5 as its newest version.
>=20
> https://repology.org/metapackage/spice/versions
>=20
> Debian Oldstable
> oldstable/main spice 0.12.5
>=20
> https://wiki.debian.org/DebianReleases
>=20
> ~June 6th 2020 (LTS)
>=20
> But the current stable, Stretch, was released on June 17th 2017.
>=20
> So we are stuck with spice server 0.12.5 until +2y, June 17th 2019 ?

Yep, but that means one more dev cycle - 4.0

We're free to drop Jessie once QEMU 4.1 opens for development at
end of April / early May.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
