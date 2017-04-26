Received: from eggs.gnu.org ([2001:4830:134:3::10]:39135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3Me2-0003w4-SE
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3Me1-0001uq-W8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:06:10 -0400
Date: Wed, 26 Apr 2017 15:06:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170426130600.GH4538@noname.str.redhat.com>
References: <20170413203401.3213-1-mreitz@redhat.com>
	<20170419154949.GF5826@noname.redhat.com>
	<93dfeca5-c43f-b753-4c29-ab9811b6359a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <93dfeca5-c43f-b753-4c29-ab9811b6359a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qemu-img/convert: Some small
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.04.2017 um 14:48 hat Max Reitz geschrieben:
> On 19.04.2017 17:49, Kevin Wolf wrote:
> > Am 13.04.2017 um 22:33 hat Max Reitz geschrieben:
> >> This series fixes some small issues I found in qemu-img's convert
> >> subcommand while reviewing Dan's convert/dd series.
> >>
> >> Nothing serious at all, so all for 2.10.
> >=20
> > This series conflicts with Peter Lieven's "qemu-img: simplify
> > img_convert" in my block-next branch.
> >=20
> > Patch 1 is unnecessary now (ret is still -EINVAL at this point), the
> > other two probably just need rebasing.
>=20
> Hm... What should I do about qemu-stable, though? I don't think that
> Peter's series will end up there, so qemu-stable should probably indeed
> take v1...

Yes, this is true. We probably need a patch specifically for qemu-stable
then and a different one for master.

Kevin

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZAJs4AAoJEH8JsnLIjy/W/ywP/0CovYtXAM9PLsB403lzMX8K
NeVNTapjqtwStlASB4bDPXy1I4TF96U/+v1eYZtPRfR7Lvc8dh793nekWBjttRg1
tIdZ5alEEMOWvV61SBCcklUCcvlnfu1eg3A06y7DnOkX44xrmRNbpkXtXMbnwQA/
ZqdpvqB7vtN3b+tUJIQsAd6m9Ekp728k3XRu8akdofmFbZaGtOscmd06ie86Bpk1
Js7CxglCrJx83U4dLROfJ4D9Eo1xfeWXJtVawLgK43BasHxrX6nOzyY7dkT7RhOu
JmI8/FuP7PoB6M4olKGJTTZw5p6Qjqe8RzF3QmcX1kPxk41xoSr9kfgjYehKe3SM
j9RT7ptYJsxbGYQaaL4aMzXjzHpa1emsNjep1ndcs9nG3cIuj0EMDSi56Ak7DnbV
lrD5KuMBOx/NmNB0TuHqgw0BityAdISKFAiC3pBzGBR/0i6mdFxFf5c/Ry4aVnC+
XCdRpIgTn94/taac6ZWuBlugDNLDz+fEOgrQW1qvp/Ly6waJ+Pe7tr/7DdNv/+wa
kg5n6pRufPuxj4VUAhXD8mRNimh/kQH3zayoWHndECPl7Urai1eijCZDCndlSM0C
uFXy5wj3coQGEWl7PtT4RPW1/0U1MYTv0OU8te/89O9g3noRD5B00VXB/dGxsNcn
HC7DPu+TvW6W+2I9ngtg
=irr/
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
