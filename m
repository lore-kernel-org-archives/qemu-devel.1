Received: from eggs.gnu.org ([2001:4830:134:3::10]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv3Be-0000c3-5u
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv3Bb-0002mD-0p
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:42:30 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cv3Ba-0002m1-Q7
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:42:26 -0400
Received: by mail-wr0-x244.google.com with SMTP id u18so34179997wrc.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 07:42:26 -0700 (PDT)
Date: Mon, 3 Apr 2017 15:42:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403144223.GC3539@stefanha-x1.localdomain>
References: <4712D8F4B26E034E80552F30A67BE0B1A3D97E@ORSMSX112.amr.corp.intel.com>
	<20170327132454.GD28620@stefanha-x1.localdomain>
	<4712D8F4B26E034E80552F30A67BE0B1A40E6D@ORSMSX112.amr.corp.intel.com>
	<339080cc-c86d-93be-9c13-596eb43d56dd@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A42954@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A42954@ORSMSX112.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] Create libqemutrace.a for all trace.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 07:00:34PM +0000, Xu, Anthony wrote:
> > >>> ./trace.o, ./qapi/trace.o and ./util/trace.o are added into
> > >>> libqemuutil.a  to avoid recursive dependencies between
> > >>> libqemuutil.a and libqemutrace.a.
> > >> Why would libqemutrace.a depend on libqemuutil.a?
> > > Each trace.c calls trace_event_register_group to register events,
> > > trace_event_register_group is defined in trace/control.c , which
> > > is linked into libqemuutil.a.
> >=20
> > Ah:
> >=20
> > util-obj-$(CONFIG_TRACE_SIMPLE) +=3D simple.o
> > util-obj-$(CONFIG_TRACE_FTRACE) +=3D ftrace.o
> > util-obj-y +=3D control.o
> > util-obj-y +=3D qmp.o
> >=20
> > With the introduction of libqemutrace.a, I believe these should be moved
> > into libqemutrace.a.
>=20
> Agreed,
> But it doesn't solve infinite recursion issue. register_module_init is=20
> needed by libqemutrace.a, which is defined util/module.c.
>=20
> it is hard to remove libqemutrace.a dependency on libqemuutil.a.
>=20
> Removing libqemuutil.a dependency on libqemutrace.a is feasible.
> Just like what I did in this patch, include all util related trace.o=20
> to libqemuutila.
>=20
> The other simple way is to include all trace.o into libqemuutil.a
>=20
> What's your opinion?

There's no harm in adding all trace objects into libqemuutil.a.  I'd go
that route.

Stefan

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4l9PAAoJEJykq7OBq3PIY8UH/3BlaKdXV1foYg+Uoo8dBMLT
KD9hpXLBOXz0FhXaqgn3LqXcNZ4jVUjX+5Gu87uEK3ewazdAKCJfqKBz8tIlFGVg
jfJeopybKRsH2H18rmwxu2KHYmw590OxsY10EvKLA2vZkpwO3BoBqqWDwIXPnDZr
vpc1ZjXlVlOKsRNK8NH5g8zK2LTduxf9tmBA0U/Dsy7Hi0Z9nawKwpRrEEICpXbw
Zv1G4gaNCVBcpCTBIndUyh5XKXFJTUmmNf6egsHmWXiqzjScne9/l4uo0iuFfY4P
VQ1us0//NIhIoxzF94OnA/Db3QihFhfOC3UWXEr9BHAW3P5pdyyv4slh+UJa1zk=
=d0yQ
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
