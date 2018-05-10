Received: from eggs.gnu.org ([2001:4830:134:3::10]:41596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGheS-0002Cm-CL
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fGheP-0001ed-78
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:14:16 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fGheO-0001do-Vw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:14:13 -0400
Received: by mail-wr0-x231.google.com with SMTP id p18-v6so1255492wrm.1
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 02:14:12 -0700 (PDT)
Date: Thu, 10 May 2018 10:14:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180510091410.GA3024@stefanha-x1.localdomain>
References: <20180420181951.7252-1-ehabkost@redhat.com>
	<20180420181951.7252-14-ehabkost@redhat.com>
	<20180430130246.GB10576@stefanha-x1.localdomain>
	<20180507140329.GW25013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20180507140329.GW25013@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC 13/24] avocado_qemu: Functional test for
 RHBZ#1431939
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Amador Pahim <apahim@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 11:03:29AM -0300, Eduardo Habkost wrote:
> On Mon, Apr 30, 2018 at 02:02:46PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Apr 20, 2018 at 03:19:40PM -0300, Eduardo Habkost wrote:
> > > +    def test_hotplug_memory_default_policy(self):
> > > +        """
> > > +        According to the RHBZ1431939, the issue is 'host nodes'
> > > +        returning '128'. It should return empty value when memory
> > > +        hotplug default policy is used.
> > > +
> > > +        Fixed in commit d81d857f4421d205395d55200425daa6591c28a5.
> > > +        :avocado: tags=3DRHBZ1431939
> > > +        """
> > > +
> > > +        cmd =3D 'object_add memory-backend-ram,id=3Dmem1,size=3D1G'
> > > +        res =3D self.vm.qmp('human-monitor-command', command_line=3D=
cmd)
> > > +        self.assertEqual('', res['return'])
> >=20
> > General question about QMP test coding style:
> >=20
> > What happens if res['return'] does not exist because the QMP command
> > failed?
> >=20
> > I tend to use dict.get() to prevent KeyError.  That way the
> > assertEqual() will fail instead of an unhandled KeyError in the test
> > code.
>=20
> It looks like vm.command() would be appropriate on most cases, as
> it will check for errors and return res['result'] automatically.
>=20
> vm.qmp() seems to be useful only if you really don't want an
> exception to be raised in case of QMP errors.
>=20
> Maybe we should rename .qmp() to .raw_qmp() to discourage people
> from using it.

Sounds good.

Stefan

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9A1iAAoJEJykq7OBq3PIVHcH/imaHniNU1Rz8ZagxgKl+4mO
c1mBkm3jFXYYUlGOmvEU5/I0KzOo22rKGphyLbMjOeGwVUF1h3+v/M0flT2hNiIn
2S5bGeqVdBv1bDBJh729oHY2RdEy4tYvnzjVJoZ4XaBtvsP74VhLYzLHJ9Q2+LjK
3zzqj/T0EEcsZsh77O5EpJ9t0vDpgr7+lroaJKZQTHI+FZYrzLedtt+bqNcITkil
X15TVw593rKKoK7dM9FjQ4xJkTtX31J0JGiOLtXNLj4sAOcPG8aCoDFazV+3y8O4
Euvi+t5OEjjgYWoIyQbm2xavWKgssTLI4SOYcVQdeVVU+RqcWPQK+R+YLupXxRI=
=XyKq
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
