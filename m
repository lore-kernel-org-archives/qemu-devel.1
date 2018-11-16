Received: from eggs.gnu.org ([2001:4830:134:3::10]:53390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNgPE-0000pb-V7
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNgP6-0007Yg-BK
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:51:38 -0500
Date: Fri, 16 Nov 2018 16:51:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181116155106.GD5066@localhost.localdomain>
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
	<20181116151834.GA5066@localhost.localdomain>
	<001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.11.2018 um 16:27 hat Max Reitz geschrieben:
> On 16.11.18 16:18, Kevin Wolf wrote:
> > Am 16.11.2018 um 16:03 hat Alberto Garcia geschrieben:
> >>> I don't think anything needs a way to generally block graph changes
> >>> around some node.  We only need to prevent changes to very specific
> >>> sets of edges.  This is something that the permission system just
> >>> cannot do.
> >>
> >> But what would you do then?
> >=20
> > I agree with you mostly in that I think that most problems that Max
> > mentioned aren't readl. The only real problem I see with GRAPH_MOD as a
> > permission on the node level is this overblocking
>=20
> I wholeheartedly disagree.  Yes, it is true that most of the issues I
> thought of can be fixed, and so those problems are not problems in a
> technical sense.  But to me this whole discussion points to the greatest
> issue I have, which is that GRAPH_MOD is just too complicated to
> understand.  And I don't like a solution that works on a technical level
> but that everybody is too afraid to touch because it's too weird.

GRAPH_MOD with the meaning that Berto suggested isn't weird or
complicated to understand. It's only the wrong tool because it blocks
more than we want to block. But if we didn't care about that, it could
be just another permission like any other.

If you want to change the graph, you'd need to get the permission first,
and bdrv_replace_child_noperm() could assert that at least one parent of
the parent node has acquired the permission (unless you want to pass the
exact parent BdrvChild to it; maybe this is what we would really do
then).

> We have this discussion again and again, and in the end we always come
> up with something that looks like it might work, but it's just so weird
> that we can't even remember it.

I don't think we ever come up with something, weird or not, that
achieves what we wanted to achieve - because the problem simply can't be
solved properly at the node level.

> Maybe it's just me, though.  Frankly, I think the permission system
> itself is already too complicated as it is, but I don't have a simpler
> solution there.

It doesn't feel too bad to me, but that's subjective.

Kevin

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb7udqAAoJEH8JsnLIjy/WZkUP/1YE4oZpb/5TkyZaye4TF/CJ
+Rmy/GbOUjW/r7RxzUQHYSEDNndQh5i1DEVtPsDLSmYqcXizW3lsljU6Zd7mErJz
ewZu+xY1lziRopIqMVINcM7ISNFgaNjqwnld1ZuSzjbeGUqhUpXs2iw/blasBQ7n
2m1aYfwokCbwQPtyBUq/D6mpZuCnEG2rv7U4tVDEIZN/kHiTohp7JKwXc+S5pCe0
aLUVh2ibNAIbEOI14dZpFm4JYC728lcKkywlIOH+XApuyfivD4SIMWO6dAqS6gse
KWMawqWFXUGOQC1+N5G96PmctLUFMnymyfW2V6hE4E+C/WNQ3U4XJIBl7AZZoEy1
vBgbykZPiO0ve1e8AWZ2CMJvOOEdPml+wQq9jKw3k88xN9EX7p6RUmDKJTFyxvaB
JayUw611eJbGCNCKmEi+kKiwEvxQL3W4fQxp1cDZ9vBFJNyzPYxPxJRMwzoBeNq7
jr+6oIqvKiHdn8pRfXksV3tOn+d3ixceFNhod3I0ME/NOPM7ZYIvU75WEl859zh3
m7vzQQR9Jui27f2svo+Degvv3sB/9W5QZOeD8m+PDFFeOOaSyxXNWJPwcm218Lbv
xBpSTBweqsvoej+HVxaXlZSi+ZXqs82EdjSuGjNAOGGYz2oK5m8iHIZ2N72QyRtb
U9s05pxM6pji2xTCNSUf
=1JQv
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
