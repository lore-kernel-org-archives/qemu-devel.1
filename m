Received: from eggs.gnu.org ([2001:4830:134:3::10]:34651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpFGl-0007WQ-JQ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpFGk-0004mp-UG
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:00:35 -0400
Date: Mon, 13 Aug 2018 18:00:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813160025.GM4323@localhost.localdomain>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
	<BDD8E417-5EE2-4B3A-BF19-C37A7BBD0330@janustech.com>
	<572652c3-bb11-4158-c3ec-8dc786fd2ae8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <572652c3-bb11-4158-c3ec-8dc786fd2ae8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.08.2018 um 17:16 hat Max Reitz geschrieben:
> On 2018-08-13 08:09, Leonid Bloch wrote:
> > On August 13, 2018 4:39:35 AM EEST, Max Reitz <mreitz@redhat.com> wrote:
>=20
> [...]
>=20
> >> Ideally we'd probably want a soft and a hard cache limit, but I don't
> >> know...
> >>
> >> (Like, a soft cache limit of 1 MB with a CCI of 10 min, and a hard
> >> cache
> >> limit of 32 MB with a CCI of 1 min by default.  So whenever your cache
> >> uses more than 1 MB of RAM, your CCI is 1 min, and whenever it's below,
> >> your CCI is 10 min.)
> >=20
> > Max, thanks for your insight. Indeed some good points.
> > Considering this, I'm thinking to set the limit to 16 MB, and the CCI t=
o 5 min. What do you think?
>=20
> I think it's good for a preliminary solution, and then later increase
> the limit with the soft and hard limits.
>=20
> OTOH, if we implement the soft/hard limits, it doesn't really matter
> what default you choose now...
>=20
> > Modern Windows installations should gain performance from being able to=
 random I/O to >8 GB chunks, and data processing tasks where each data set =
is 8+ GB for sure do (did benchmarks). And the maximum is only ever used if=
 (a) the image is large enough and (b) it is indeed used.
> > While taking 256 GB images as the "limit" can be considered an overshoo=
t, 128 GB is quite reasonable, I think.
> >=20
> > Your idea with "soft" and "hard" limits is great! I'm tempted to implem=
ent this. Say 4 MB with 10 min., and 16 MB with 5 min?
>=20
> 32 MB and 2 or 3 min? :-)
>=20
> If you do that, I'm fine with a plain default of 32 MB for now.

I would be happy with that.

Kevin

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbcasZAAoJEH8JsnLIjy/WAgwP/A4kVVL+KQGcekwmo0zNFgFL
0h2f7AwyWLPTsX5Q7rwHJf0OlG6hGo8fqEZMYtoOE9s91PjTALQ1unwg8gumh8+7
ZfUuh88tCiBfEPUzORQO99g0JMFQL0O4suGsdpDWUnBbT7H3dL2D2oJH+tfHA+b0
tro7yZjPWeopeplR9xoWLcQxwPbzIwpamlcd1ogu1iFj71ObA8WkdOisnhscOWgk
DTriHHVd1FbDbgibc7KQe1LPn2Y3Cj6Q+b/PJeLs3GXASacQ+eP8/soQdY0F5faW
t8qhWqErmyJiFIqSCk/8jcbsjt3AJu+f4ImzlMubNk2grhThr2UdJYNgk4OAo0fl
QuzyX7/AWThQb3iE0dLwbGpy5qzVeMNdZZeSox5OBqbP9iM34qv0xGkpQY+sIv6S
9Ny84Ei2j7+dv8Moi23ER5CeFwN8Yyiu9KF+SARYK4zRdHd1xMLhyjr7W4ZVeqFT
fgZemX9ydu1RE2wIxJ+LBZ3L9bYstVkx1IjrC/FNU2f06qGSu5zKCfKZi45Xoqe2
/Og7+PoujL9EMImeACvKh+Iz6pqSFcrZPa71bLXlSfNjV1v0gqXURpBC1JQwdg58
TNsHpkLhqz6WiQ0CYWh+WAtB1Va/DXtEE9ydnpjGPeay6DWbr5KUGGfDJOjDhmtq
a+D2mvuYYYcxnMGgx4cl
=E+p9
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
