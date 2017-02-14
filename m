Received: from eggs.gnu.org ([2001:4830:134:3::10]:38069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdd2y-0007GS-KO
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdd2v-0000Rh-Dv
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:21:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cdd2v-0000Qs-4g
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:21:29 -0500
Date: Tue, 14 Feb 2017 13:21:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170214132122.GH23310@stefanha-x1.localdomain>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<71b1733d-7638-5e27-e828-fad57f76f507@redhat.com>
	<20170207001533.3f18e4ea@bahia.lan>
	<20170207113231.44e35be6@bahia.lan>
	<6b702369-7891-4e38-7240-57ad643657bd@redhat.com>
	<20170207172933.05574f60@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline
In-Reply-To: <20170207172933.05574f60@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/2 v16] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 05:29:33PM +0100, Greg Kurz wrote:
> Cc'ing Stefan who reviewed patch 2/2.
>=20
> On Tue, 7 Feb 2017 09:56:08 -0600
> Eric Blake <eblake@redhat.com> wrote:
>=20
> > On 02/07/2017 04:32 AM, Greg Kurz wrote:
> > >>
> > >> I'm not aware of anything related to fsdev in QMP... and libvirt see=
ms to
> > >> only parse the output of -help to guess fsdev capabilities. =20
> > >=20
> > > Oops, reading some more libvirt code I now see that libvirt doesn't p=
arse
> > > -help anymore with QEMU >=3D 1.2.0... sorry for the noise :)
> > >  =20
> > >> And indeed,
> > >> qemu-options.hx doesn't expose this new feature.
> > >> =20
> > >>> Please make sure we don't reach 2.9 with only a half-baked feature;
> > >>> whether that means finishing the QMP work or temporarily disabling =
the
> > >>> cli additions until a later release can finish the work.
> > >>>    =20
> > >>
> > >> Would this be ok to add the missing bits in qemu-options.hx or do you
> > >> expect more ? =20
> >=20
> > If it cannot be probed via QMP, then libvirt will most likely assume
> > that it does not exist.  I guess we're okay having command line only in
> > 2.9 if you can't get QMP working, because libvirt will just never drive
> > the feature until 2.10 when QMP is available; but then we risk the
> > command line subtly changing and breaking someone else that was using
> > the command line without QMP.  Maybe the safest approach is to just use
> > the 'x-' prefix to the command line portion, until the feature is compl=
ete.
> >=20
>=20
> The semantics here are exactly the same as for block devices. The
> command line options added to -fsdev are the very same already used
> by -drive for years.
>=20
> Patch 2/2 in this series even factors them out to a common header file
> to be used by fsdev and blockdev. I really don't expect any modification
> at all on the command line (nor the other people who reviewed that patch
> obviously)... are you suggesting that we should put 2/2 on hold and
> use the 'x-' prefix anyway ?

I see these parameter names as stable.  There is little risk that they
would change.

Stefan

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYowRSAAoJEJykq7OBq3PIprIH/2DCN088hQNMn5BL/DlT97G9
dfs3kYPzwqwk11yWKWbsosVzYOMrdenOsbstaE8gbfUtYIffhI3slN1G/OzmzKgp
Hya1S5zHR/KvYMmiJVR/k/HqeY3gzgtU++0u+EO9qeyKBfUw+hZEQUGS4yx+XP1b
Ih0XYlLYbQDad0Eoaps+FA8Q6dEV6TI6G6F/F4FZ3agFUNraowxHTyS7YnesCKy7
1Xw6/vLXbLOd1/mo86fwKs3GqYBY1oiUp8SN6xAz+x+qCkJIu3vGhYW2PVrRgLWP
IW6lK0viqqDXFYmo0UniTtAPtz4fOlGBjMJucK+H9j1NzGbYcPDOdoyHvxZlNLo=
=IQ+Y
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--
