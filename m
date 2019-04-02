Received: from eggs.gnu.org ([209.51.188.92]:50512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hBF0n-0003e5-Ik
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hBF0l-0005XD-E2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 04:43:17 -0400
Date: Tue, 2 Apr 2019 10:42:49 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190402084249.GI2686@andariel.pipo.sk>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190328182810.21497-2-kwolf@redhat.com>
	<2fc10494-0f79-8d18-610d-be21cfc6c30b@redhat.com>
	<87ftr5iy8i.fsf@dusky.pond.sub.org>
	<c233c2b4-5257-2df7-3c1a-06bcf269d657@redhat.com>
	<20190329170439.GK5081@localhost.localdomain>
	<87o95sa40r.fsf@dusky.pond.sub.org>
	<87y34v42z0.fsf_-_@dusky.pond.sub.org>
	<87bm1pjxz6.fsf@dusky.pond.sub.org>
	<20190402081929.GA5352@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AptwxgnoZDC4KQWS"
Content-Disposition: inline
In-Reply-To: <20190402081929.GA5352@localhost.localdomain>
Subject: Re: [Qemu-devel] Options for 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, stefanha@redhat.com, qemu-block@nongnu.org


--AptwxgnoZDC4KQWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 10:19:29 +0200, Kevin Wolf wrote:
> Am 01.04.2019 um 22:02 hat Markus Armbruster geschrieben:
> > Markus Armbruster <armbru@redhat.com> writes:

[...]

> > Given that the libvirt code isn't ready, why do we need this done and
> > declared stable in 4.0?  We're going to tag -rc2 tomorrow...
>=20
> The next libvirt release will be long before the next QEMU release. If
> we don't have it in 4.0, enabling -blockdev will have to wait until the
> first libvirt release after the QEMU 4.1 release (so maybe September)
> and we'll still be stuck with -drive and unable to start deprecating it
> until then.
>=20
> Also, we don't want to give Peter the excuse that the qemu code isn't
> ready. ;-)

It will not be an excuse. That's because we have plenty of 'prior art'
in adding version-based capabilities if everything else fails. I'm just
always unhappy when I see it.

In this instance I failed to speak up soon enough to get a better fix
ready. I could try to excuse myself, but I will not.

Just please don't drop the work that can be used to detect further
changes like this. It might come in handy sooner or later.

At this point I'd not change anything. I agree that last second fixes
have a big probability to be regretted later.

In the end it may end up being necessary to fix yet another thing for
blockdev or something else and we can at least prevent that from having
a version-based check.

--AptwxgnoZDC4KQWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyjIIMACgkQHGwCByjY
1GoqFA//e1bLwHGklSbvjQgy/c328Hy7LUYDwMQxIluUZlLEKuG1lSHTm/AYlnPK
dJfn02uj2Q+HAf5oHHzKas5pm5QmUbxnVECmKVgZyFSVo7v3RDCJaqETmiuXYlti
c8dlrbG+rVxYHvxFK1upOiDVdDGiUNsMID6tGjqSERj/sPKYv/T9/xx74wFjsqTL
hGbkQl7fu8gL7Nxao9Eu6ZJA/ucg5mkdr3CjfCSp8dc5ngh5swFNTovsmLceCbph
kCKE8B2qm+JMpHLW7LzkeT1j7S5Dl3p3fEbv0D2H7XCB/3Rn5ki0h9ExzAkL/UKR
fibrQHuVyomWVtV3b5A2aHMdz2yBXuGZOXbyjvKPWCVJnWTvJB/yhN4rlOfi92RZ
j495I/qbtURFWdI/2mSFlrT5u7/whvMHSPW8uHRS75q6hIdscCqgqrykr5mPK30D
FwMLfw1gbwU5ojgML7lex1x4QZlki46FsH0wCGmIu93iPext5fFUP8g/2w9T6dfj
wEU5Rx7HT0ByoHTlxIQM3NWEAViM+qt+2jjYbGzgMVUYQWzywh0KKgZBVVeuHkfe
X1+LiF5xN9cJeXRt5Dlw4RD18W3P/4YfIysF2MDmw9/PjdHnY0OUijRKdczflnjq
VnuijXlg0mfJ69kfMuTGGxsZs1XZ1z7HL/rzGco2ucBwxOA/72g=
=0U2M
-----END PGP SIGNATURE-----

--AptwxgnoZDC4KQWS--
