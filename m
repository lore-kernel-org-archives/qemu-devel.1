Received: from eggs.gnu.org ([209.51.188.92]:33418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gt9yH-0003y9-Gp
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gt9yF-0001xY-FX
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:41:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gt9yF-0001nV-8Z
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:41:55 -0500
Date: Mon, 11 Feb 2019 11:41:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211114120.GU27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
	<20190211110907.GP27585@redhat.com>
	<CAMxuvaz4w75CmN1o0E4y4+pTLk5cks-oGu+FnyUWUbvBqC-jUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaz4w75CmN1o0E4y4+pTLk5cks-oGu+FnyUWUbvBqC-jUA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] RFC: net/slirp: link with libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Mon, Feb 11, 2019 at 12:34:47PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Feb 11, 2019 at 12:09 PM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> >
> > On Fri, Feb 08, 2019 at 07:12:26PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Once libslirp has received its first release, we can link with the
> > > external libslirp library.
> > >
> > > The migration data should be compatible with current and older qemu
> > > versions (same compatibility as today). See "slirp: add state
> > > saving/loading" patch. However, the content should be treated as a
> > > blob, as the format may change eventually in the future.
> >
> > How are we going to manage live migration compat if libslirp changes
> > the blob content ?
> >
> > Bear in mind that we need to support all existing QEMU releases live
> > migrating to effectively all future QEMU releases, with all future
> > libslirp releases, in *both* directions. ie arbitrarily newer
> > libslirp needs to be able to emit a blob format that can be read
> > by arbitrarily older slirp inside QEMU.
>=20
>=20
> Right, this is all supported currently with the proposed patch set,
> since it is effectively the same code.
>=20
> So register_savevm_live() get passed slirp_state_version() (currently =3D=
=3D 4)
>=20
> & slirp_state_load() get the version_id from QEMU.
>=20
> >
> > Normally we tie data format changes to the machine type. How are
> > we going to achieve such machine type associations with an external
> > libslirp ?
>=20
> Is this relevant for slirp? I don't see any version tied to machine
> type. Am I missing something?

Old to new would work provided new slirp can read & understand all previo=
us
slirp state versions. It is entirely possible no one ever tested new -> o=
ld
live migration with slirp. I doubt we would have tested it in RHEL, since=
 we
don't really care very much about slirp in context of migration.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
