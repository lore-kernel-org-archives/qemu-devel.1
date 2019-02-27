Received: from eggs.gnu.org ([209.51.188.92]:48661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gz2ku-0007yw-PU
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gz2kn-0005ui-In
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:12:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gz2kn-0005uM-3S
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:12:21 -0500
Date: Wed, 27 Feb 2019 17:12:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190227171218.GF927@stefanha-x1.localdomain>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225092846.GA4757@angien.pipo.sk>
	<20190225174001.GI379@stefanha-x1.localdomain>
	<87a7iincg0.fsf@dusky.pond.sub.org>
	<20190227151535.GE22539@stefanha-x1.localdomain>
	<20190227152525.GK31688@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <20190227152525.GK31688@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 03:25:25PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Feb 27, 2019 at 03:15:35PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Feb 26, 2019 at 10:09:19AM +0100, Markus Armbruster wrote:
> > > Stefan Hajnoczi <stefanha@redhat.com> writes:
> > > > On Mon, Feb 25, 2019 at 10:28:46AM +0100, Peter Krempa wrote:
> > > >> On Mon, Feb 25, 2019 at 09:50:26 +0100, Markus Armbruster wrote:
> > > >> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> > > >> Other than the above, this is a welcome improvement as I've person=
ally
> > > >> ran into scenarios where a feature in qemu was fixed but it was
> > > >> impossible to detect whether given qemu version contains the fix a=
s it
> > > >> did not have any influence on the QMP schema.
> > > >
> > > > I'd like to make things as simpler as possible, but no simpler :).
> > > >
> > > > The simplest option is that the advertised features are set in ston=
e at
> > > > build time (e.g. selected with #ifdef if necessary).  But then we h=
ave
> > > > no way of selecting features at runtime (e.g. based on kernel featu=
res).
> > > >
> > > > What do you think?
> > >=20
> > > I think we should map the problem space, identify cases with actual
> > > uses, then design a solution that covers them and can plausibly grow =
to
> > > cover cases we anticipate.
> > >=20
> > > The migrate-with-cache-direct-off-on-linux case is compile-time stati=
c.
> > >=20
> > > Do we have or have we had a case that is not compile-time static?
> >=20
> > I can't think of something that both requires query-qemu-features and
> > isn't compile-time static.  But that could be because not many things
> > require query-qemu-features :).
> >=20
> > The philosophy on Linux seems to be: distros compile QEMU against
> > headers that accurately reflect the system features that are available.
> > Therefore there isn't a lot of runtime fallback logic in case a new QEMU
> > is running on an old host.  This means we can get by with compile-time
> > static features only.
>=20
> This assumption is probably going to be more troublesome in future. It
> is increasingly common to deploy libvirt & QEMU inside docker containers,
> and there's not a strict requirement that the docker container image
> is the same distro / version as the docker host. ie a Fedora docker
> image could be run on a RHEL host & vica-verca. IOW we could see an older

Off-topic, the standard spelling seems to be "vice versa".  Is this a
typo or another accepted spelling?

> kernel than what we compiled on. I don't know how common such mismatches
> will be in practice, but at the Docker level there's nothing preventing
> such mismatches, which means some people will inevitably end up running
> in such scenarios whether we like it or not.=20

Good point.

Peter's suggestion for a cacheable flag sounds useful.  I can propose
that in the next revision.

Stefan

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdsTyAAoJEJykq7OBq3PIcMoH/2EbeCJfZnxC/MgUHFCJ7EFy
klJsKGxs5c13s7ztfnBaS68nDOeeV3LJOObvQwEXArzkB3nWpgsHMFZh/rgCH9qG
63qjj4rvUqBghyDBh2Wa6AaCqyc5HtUmL0CIv/2jkH1B8lfvZ4HZaQ61/d8cnsSW
2xi47NoVSMsCbm0mnmITTy4Cc68iHVVbfT2iKYFU7VwDJFHIOaw1Inv1idcmjfxr
/3jaETxGW79zGNtsN3Abgja+ct1trZ9oVEPcISLZ9qf34tDInrCuVxBUtDx751EC
68xnopcUISouz0lg1TSFJKmZ/815KUSPDZJL7A/IffQC15tDRIcIWI8mkUsFT/Y=
=f/HZ
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
