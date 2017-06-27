Received: from eggs.gnu.org ([2001:4830:134:3::10]:33387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dPvQa-0007jw-Gk
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dPvQZ-000663-MW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:41:32 -0400
Date: Tue, 27 Jun 2017 20:41:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170627184123.GD4792@noname.redhat.com>
References: <20170605203845.24351-1-eblake@redhat.com>
	<20170606122645.GC5448@noname.redhat.com>
	<fffc2bff-063b-4e0e-c90d-e5a77857ab1c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <fffc2bff-063b-4e0e-c90d-e5a77857ab1c@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 0/4] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.06.2017 um 18:01 hat Eric Blake geschrieben:
> On 06/06/2017 07:26 AM, Kevin Wolf wrote:
> > Am 05.06.2017 um 22:38 hat Eric Blake geschrieben:
> >> I found a crasher and some odd behavior while rebasing my
> >> bdrv_get_block_status series, so I figured I'd get these things
> >> fixed first.  This is based on top of Max's block branch.
> >>
> >> Available as a tag at:
> >> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-status-v4
> >>
> >> Since v3:
> >> - check all qemu-iotests (patch 1)
> >=20
> > Whoops, somehow I ended up applying and reviewing v4 while looking at
> > the v3 thread... Looks like there really aren't any missing test case
> > updates any more.
> >=20
> > Thanks, applied to the block branch.
>=20
> Did this get lost somehow?

No idea what happened there, but it looks like it. It's queued now.

Kevin

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZUqbTAAoJEH8JsnLIjy/WEPUQAIN7pXvwL5FSGwlWjsMyl8X/
0GGoxLMKJN0bCul9cYGnLBzwKYET6TzyfSkll1qzqpy5BAyyC0j4h7lo4w8ewfjY
sE7+AAfgZVTSyGetXFfXLhcf3TagjNM81TIoHTqQqypeJzITBcf6Pq7c28NJjnNZ
1DhaMhBXaBlGvoLFLHJXeOQYAWgkL2946meT3mdj0g0ef6Q3lFpWTZ9/AWyiQvlJ
Lv1bJ+m8QdOVHKJgR4H7RifvutfJdTXcSGEyuyMZSlZf8gbC02UB7VSryv+B/W0k
jDNjeyyu5lWV99/4VY4gLfyiF4IZD58qYi+17yla5f0zQKFHKb/iuPsbuMeyoe9z
2t3RJ6FJhc716475602HsoabfaQzCU7pGkm79IGEB9e2jt58lxgIZvD1P6Ro5a1i
g+61xTTm8BcoNTM+mqLnRPe0vJGiRNUqot0eYOrcU8y/h4FaeMqkGmkUkmNQjP+5
ldOv/gGcp4jHseLG19UPZUcOzrCjfoQ1qJyB5x/qgZP6BkiwVmLzNaq4yo/1S4Nw
NQL5MS5M3AmSsYk6cnndqkw/gOGiK7qtJ5R5HZpzzQmAecZy1JYLGkdekjx7qg5U
bLDM33hzMgllhmSC/EdRcoyJ5Wat0u3He0Zy3JT1x2NNOmvU/RW/o1g1myesY79+
wTCpcMlauf62IdPm+Wya
=iMoX
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
