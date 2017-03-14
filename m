Received: from eggs.gnu.org ([2001:4830:134:3::10]:35875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnp88-0002Ix-6x
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnp87-0005nQ-7r
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:17:00 -0400
Date: Tue, 14 Mar 2017 17:16:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170314161651.GM3952@noname.str.redhat.com>
References: <20170314154315.17869-1-famz@redhat.com>
	<bcb24567-c232-803d-a316-c9f285494583@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <bcb24567-c232-803d-a316-c9f285494583@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.03.2017 um 17:11 hat Eric Blake geschrieben:
> On 03/14/2017 10:43 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/file-posix.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index c4c0663..e6170f4 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -703,6 +703,7 @@ static int hdev_get_max_segments(const struct stat =
*st)
>=20
> hdev_get_max_segments() is not part of master yet; should this just be
> treated as a fixup! to a pending patch?

It is already in master, since yesterday, I think.

Kevin

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYyBdzAAoJEH8JsnLIjy/WOxwP/3BWoAjGX/VYctj1zS6Aj74O
w8AHb3rzde/mx8sghje08ib76oyEBu2dmK66SNPNX0zdumvlBkt6dcncUmtompYG
RY8LpjxN+7sovvgRpH8GKYMuctadtfi333SARlx698dqFtQy7Lz05eruDyD22C2f
xBS47Jp5DTXQLzRTWin0IiaQ+CF1IJqn6UVovgYMOs48+VsdryxOtVSTAH3W7tE1
P/r+9rawE9BN7VJ7cYtHJGw7kzQPxO5zJR4x0GIH2HxHdlkaZ1H3pnRhZjzhlX4J
IzBEmFQfECzcmGSxqRGYXlow7W6HMfaH4oJatGPItm8qRz4RAIlypNIsBoEaTMyT
HwRXbX0JUpjgnlAmo2JRPGFjn1sTUBpEoVRpDwg457a88uj5OSacBXimgC18e9FY
t3OaKMCcc4ux0mlsulrIEh9fPIEyUB4e7LNTVRw3J9maTC3Hu8d/wGQg7lY/JWCz
2BIfjJP6xhPMbuNPG/LGS35lXS+I1hWZvj3Kw2TA1OXX9wDv3Y64BXKWGD/cWiEX
NSveN2EHX5kBF7Qspe9tKCOHC69MxIgw3Cby2pC5wNhdQEe7c3rndtpGyXgMnFxb
kNJHm1DTvoFP6gD5OEdNseHG9hwc6u/WEdCJ1kaOtfN7FlopY4Q7q7N1B+1M7Fu1
mxzkOMk1IODuv0EB6emJ
=l0ah
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
