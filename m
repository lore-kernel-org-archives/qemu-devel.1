Received: from eggs.gnu.org ([2001:4830:134:3::10]:57077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1eYZ6x-0000Mr-53
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1eYZ6w-000451-4V
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:13:15 -0500
Date: Mon, 8 Jan 2018 16:12:30 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180108151230.GI6172@angien.pipo.sk>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
	<20171220111133.GR21216@redhat.com>
	<87ind16zac.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wnLTWEf+vlzHZaR9"
Content-Disposition: inline
In-Reply-To: <87ind16zac.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block] Raw notes from a small block
 layer/QAPI/something pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--wnLTWEf+vlzHZaR9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 19:15:55 +0100, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
>=20
> > On Fri, Dec 15, 2017 at 05:38:00PM +0100, Max Reitz wrote:
> >
> >> Image creation in qemu-system-* vs. qemu-img:
> >>   In order to get proper introspection for qemu-img create, we need a
> >>   QAPI schema.  If we have a QAPI schema, we might as well add
> >>   blockdev-create to QMP.
> >>   As long as we do not have a really-none (null, void, ...) machine ty=
pe
> >>   for qemu-system-*, launching such a process just for creating an ima=
ge
> >>   will bring quite a bit of overhead (e.g. with -M none -accel qtest).
> >>   However, as for libvirt, this is not exactly a regression since
> >>   libvirt currently cannot create images at all (apart from implicitly
> >>   through drive-mirror etc.).  Further work on voidifying qemu-system-*
> >>   will improve performance.
> >
> > In terms of the I/O operations involved, image creation is a already a
> > pretty slow process, particularly if pre-allocation is used which is
> > common.  So even QEMU's current slow (circa 300ms) startup time is a
> > complete non-issue for image creation IMHO - it'll be dwarfed by the
> > time to actually create the image.=20
> >
> >>   On the other side, we can also add QAPI introspection to qemu-img.
> >>   (qemu-img already links to QAPI, so this should not be too hard.)
> >>   qemu-img will also need command-line introspection, though.
> >
> > I figure the qapi-ificiation is the hard & time consuming bit of
> > work. Once that's done exporting it via both qemu-img & qemu-system*
> > is quite straighforward.
>=20
> qemu-system-*: trivial.
> qemu-img, via command line: straightforward
> qemu-img, via QMP: more difficult, since QMP is entangled with HMP,
>     character devices, ...
>=20
> If libvirt really wants to use QMP for the job, *and* doesn't want to
> use the qemu-system-* that's running a guest, the easy solution is
> running another qemu-system-* without a guest.

QMP is necessary to have for very-long operations (blockdev-mirror), but
for image creation the command line will be enough. Provided that
interface for -blockdev and "create image" will be similar enough.

Especially the fact that qemu-img create does not really like 'json:{}'
thus some image options are impossible to pass (multiple hosts for
gluster, ...).

--wnLTWEf+vlzHZaR9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlpTilsACgkQHGwCByjY
1GqaFw/9Ginsr5I6yWYtM4hZyd1shou4qtRwiAzZX9sSNlcvQX6GvsmB7DwE7qeH
1WJHhaoUuslONEsCLkpphyWrOqLJBtmYEbVAUaph34U0OK0L8rUURg3gnyRtHdZ0
eRXTT+QydUOI2JA2aEze1RAkgkUGebsTJMCWS1b51k/jqxXQ46v5vZu8KY8CCdRf
iQbDmBOGK5EbWGvSeNqDnZDSgHxiNbX3rLYvBgXylUnebIXnCXoHK+Q8nvp1WXnq
zWWO503fm+uaWLl1ZMRRxQC4Y+hfBKiWH210js43DyQ9lQXb/o76ddaYVcyLywsl
UXE2L1YDdRHnSzOEOIwg7uBvJSeCBeLqpO9G7s0WJAV3rnmRUo2MIYm3a6HSVw4w
jW5pvGnJFsbqJSHXlPKVRVhTBjTqLOYXCaV4xIzEIK5HkjwkNmooVXan9RoxamaH
SHS/traeRYWy+5wzZTSSfVD8G+s42Y9FCn7xriTaoCjaX2iWKgr1rzr+oTK1hIoO
zQyfs5OacLX9yCXj7tmbuRwWuxorudPkcx9zZMP1efql59AGBlOaGMWGFVMt6Mzb
pCf47IojEca9XgPE4OZ0q5NaZsMx8DB2OJGaGJbleJxivCK5gPx1B++4aS51Km5j
y3p7q6MFw+fiAWuC9ubNA6oNs+OdHND95a3+raEbfqI3VPq93yE=
=wAlf
-----END PGP SIGNATURE-----

--wnLTWEf+vlzHZaR9--
