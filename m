Received: from eggsout.gnu.org ([209.51.188.92]:54353 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmPG-0000mC-9Y
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 08:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmPF-0000iq-Hf
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 08:54:30 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-9-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7d780e1-60a8-262f-9989-f03f47e91f38@redhat.com>
Date: Sat, 5 Jan 2019 07:54:18 -0600
MIME-Version: 1.0
In-Reply-To: <20181215135324.152629-9-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J53o0J3HzlurLspdrUpyTp0w8H1h4XyH7"
Subject: Re: [Qemu-devel] [PATCH v2 08/22] nbd/client: Drop pointless buf
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J53o0J3HzlurLspdrUpyTp0w8H1h4XyH7
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <a7d780e1-60a8-262f-9989-f03f47e91f38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/22] nbd/client: Drop pointless buf
 variable
References: <20181215135324.152629-1-eblake@redhat.com>
 <20181215135324.152629-9-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/18 7:53 AM, Eric Blake wrote:
> There's no need to read into a temporary buffer (oversized
> since commit 7d3123e1) followed by a byteswap into a uint64_t
> to check for a magic number via memcmp(), when the code
> immediately below demonstrates reading into the uint64_t then
> byteswapping in place and checking for a magic number via
> integer math.  What's more, having a different error message
> when the server's first reply byte is 0 is unusual - it's no
> different from any other wrong magic number, and we already
> detected short reads. That whole strlen() issue has been
> present and useless since commit 1d45f8b5 in 2010; perhaps it
> was leftover debugging (since the correct magic number happens
> to be ASCII)?  Make the error messages more consistent and
> detailed while touching things.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I'm queuing 1, 2, 5, 6, and 8 for my next NBD pull request, and will
respin the rest of the series to incorporate review comments.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--J53o0J3HzlurLspdrUpyTp0w8H1h4XyH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwwtwoACgkQ3g5py3or
ov2/mwf/QnFJxXkBH8U1a11xAF9LSuY3yiOPct0BvVv2bwPvbUCslOgNF8++E8+4
6xnnzsRi/Io02aPqD0aoRHhN7mOm5iivwguy7KKyZtFMZULSTzq1fsLiRql5ZSXV
pzNjuL1StA5wh1N6aLdCHq3s6UHWsFWww0GIkGyxKnV51H93Qqo3F7aDQDot5Dor
ez9bp0tha/Otjlex85v4s1woe2ZDUQfBbsqz4Ac02lNNvTkv5rSzR3O6RLhlypXb
sQxNCbfTbCuS2nAlmF3h5UNUvQFiBGzinvGdwjwIMklxJnJjwsnnLrXSXF3eFSRI
SqiL8APWOVbA+0MouWTo7Ip1Lu6MNg==
=lsR+
-----END PGP SIGNATURE-----

--J53o0J3HzlurLspdrUpyTp0w8H1h4XyH7--
