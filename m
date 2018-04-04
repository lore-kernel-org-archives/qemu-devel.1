Received: from eggs.gnu.org ([2001:4830:134:3::10]:39898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3nIT-0006UC-IT
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3nIS-0006Gk-MN
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:38:13 -0400
Date: Wed, 4 Apr 2018 20:37:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180404183755.GI4482@localhost.localdomain>
References: <20180403110810.25624-1-kwolf@redhat.com>
	<d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
	<20180404154141.GS38016@angien.pipo.sk>
	<20180404155420.GG4482@localhost.localdomain>
	<98cbcf10-6dd4-3373-5b08-f5c73691fa73@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <98cbcf10-6dd4-3373-5b08-f5c73691fa73@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12] gluster: Fix
 blockdev-add with server.N.type=unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, prasanna.kalever@redhat.com


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.04.2018 um 20:16 hat Eric Blake geschrieben:
> On 04/04/2018 10:54 AM, Kevin Wolf wrote:
>=20
> >>> Should we also add a deprecation warning for 'socket' and update the
> >>> deprecation documentation, so we can start the clock ticking on getti=
ng
> >>> rid of maintaining the back-compat glue forever?
> >>
> >> Well, that won't be as easy. Since there is at least one qemu release
> >> which declared this in the QAPI schema but did not support using it it=
's
> >> hard for libvirt to detect that this was fixed, and thus we can't infer
> >> a capability which would be used to switch to the new-syntax only.
> >=20
> > Markus wanted to add some way to declare capabilities for a command in
> > the schema that could be queried with schema introspection and would
> > cover such cases. I think we even discussed this with you at KVM Forum?
> >=20
> > Eric, do you happen to know if there were any patches on the list
> > related to this?
>=20
> I don't recall seeing any patches from Markus before his leave, and
> doubt anyone else has tackled anything along these lines.  It's too late
> for 2.12, at any rate, so even if we had such a feature implemented in
> time for 2.13, it won't help introspecting the 2.12 release.

We only strictly need it in introspection at the time when we remove the
old option. But maybe it would be nicer to wait with the deprecation
error_report() until libvirt has a chance to avoid the warning.

Kevin

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaxRuDAAoJEH8JsnLIjy/We1gQAKHCoN9WOWG5P6nvOh58FYZl
LD302KlUnxSomYcdKxiipUhaWmw8ija4R6QnScKFTYTiv7jQEMrmUq3DkuXM9snC
yB0pXZP+Hlg9MkALvfepmaKaJdNWt+xyqiwfFjn6ZWL/AdNZKCXhN4EyMWMVpJAL
vGg5oGRYPk6xoavWY9Ymq105gaTkWKti5oW8JdgNe2hOV/6eP4CF3DMkFotTaIfA
ezzubqLi4PxJvlm4u+9YbfdFkLwFy1wRhnfwiNpr9qujEcj6A2qxGApKM6hAz+r9
HpKpfHTsgwAO8UVcNvFVBdtBjZ5Yb4R+EPxB44Jjaq+VmJKnrTLrVgMARSE3qPXu
wDsk7Z4WCwF/a7oahSQdzeAw1Fix12M/ZyXDLgpx9l1Cby1BuMmsNTlnYeLQbg4Y
RvoOFJOwQAkAdxQPyLRCnYt4ja7ev2jLDULt86oGIAE7G5Z+d1yz7iLh919uug/4
1gtYWpSuVX5njmgtzsxEpylGi5kuLpGLsWaxxWh4wvk3mk/raMD7K1d0qGtWpHTp
juPBLPDVB6Tpyitpn3NswdmN0/NY6W2pRL/gR+T/m23hoBwHeqSX92T9cRFmmP2g
ltTAX8zfsFzz8KbmgnpU31MDA6KLZQGiP0vareTFmkupys+WLCIQnRsLvSEn1Amv
WF0nqu/w18EBV1BHg9aw
=a7VU
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
