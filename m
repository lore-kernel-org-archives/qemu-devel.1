Received: from eggs.gnu.org ([2001:4830:134:3::10]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwjN-0001VJ-KK
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwjI-0006oy-25
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:09:01 -0400
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d139f3b-a437-03ca-c1b5-91d48d78a920@redhat.com>
Date: Mon, 18 Sep 2017 09:08:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170916185123.29255-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7FnjSQ5TNxDLAMgeG03cmKN0nEAnxFRCh"
Subject: Re: [Qemu-devel] [PATCH v5 2/6] qapi/qlist: Add qlist_append_null()
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7FnjSQ5TNxDLAMgeG03cmKN0nEAnxFRCh
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <0d139f3b-a437-03ca-c1b5-91d48d78a920@redhat.com>
Subject: Re: [PATCH v5 2/6] qapi/qlist: Add qlist_append_null() macro
References: <20170916185123.29255-1-mreitz@redhat.com>
 <20170916185123.29255-3-mreitz@redhat.com>
In-Reply-To: <20170916185123.29255-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2017 01:51 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qapi/qmp/qlist.h | 3 +++
>  1 file changed, 3 insertions(+)

Please update scripts/coccinelle/qobject.cocci to also cover this (since
we updated it for qdict_put_null() in 0f9afc2).

With that addition,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7FnjSQ5TNxDLAMgeG03cmKN0nEAnxFRCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/03AACgkQp6FrSiUn
Q2oqzQf/YItfbFN7TQebPgiuzqOF7XAogWEr44L73GP3Bgj+aKuV49YeRoVcFnoR
gWHwU85NI3yQ01HDDvYY6WUkDH9RK39sEr4F13NOW+vj504xXbaIbwzPlmCt0Llv
xWHmDovxSCDQZMm4IxHYgqbYcY6eYH/M8v5tfH523UrOTlfnvBJT9dvnuGZTrC6G
ADYQ8agJW8vzdrS/gr4E/b4affMThPM/R3UAYD+Oj+Ys5SEq4cIyGY2Jr5modPqu
TvgF8qvwZhH0KVBZ/snCOdDzUFV71lHQWY3r7yQ85CzfGjqPq1a/orLLwX8Ig0wa
nwSv5vK33FVLqvywo60Z0qH4ns19Ww==
=BhUD
-----END PGP SIGNATURE-----

--7FnjSQ5TNxDLAMgeG03cmKN0nEAnxFRCh--
