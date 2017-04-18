Received: from eggs.gnu.org ([2001:4830:134:3::10]:44002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0TA5-0001BY-K0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0TA4-0003ae-P1
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:27:17 -0400
References: <20170314023933.12118-1-famz@redhat.com>
	<20170314023933.12118-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <811911cd-a8c9-90d2-2186-33f4db0a9af1@redhat.com>
Date: Tue, 18 Apr 2017 08:27:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170314023933.12118-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pj31OkJnxG8VEUgLb16HeJHnUrEi4e3i4"
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] qemu-io: Add --unsafe-read option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pj31OkJnxG8VEUgLb16HeJHnUrEi4e3i4
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <811911cd-a8c9-90d2-2186-33f4db0a9af1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] qemu-io: Add --unsafe-read option
References: <20170314023933.12118-1-famz@redhat.com>
 <20170314023933.12118-4-famz@redhat.com>
In-Reply-To: <20170314023933.12118-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 09:39 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-io.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>=20
> @@ -108,6 +112,7 @@ static void open_help(void)
>  " -r, -- open file read-only\n"
>  " -s, -- use snapshot file\n"
>  " -n, -- disable host cache, short for -t none\n"
> +" -U, -- accept unsafe opening of the image even if it's in use by ano=
ther process\n"

Long line (exceeds 80 columns of output); can we shorten it?  Maybe

 -U, allow unsafe reads when another process is writing

You did get 'qemu-io -c "help open"' adjusted, but I don't see where you
adjusted 'qemu-io --help'.  Since both places gained a -U, you still
need more documentation. But at least there is no man page to worry
about here.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Pj31OkJnxG8VEUgLb16HeJHnUrEi4e3i4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9hQoAAoJEKeha0olJ0NqYD8H/iAlgcgJ4bWTMujHVwv/Oi7F
+iWBqxJ6jV+U2b6TFbGSM5iy3F+qspFU69tMMwgulGHgu8nMzytI5ssJM337v2j7
Z2TnwrARPZ4s0PZDPjCv8PQneKm+kgg43hxAubaBfpDwbyCUwevkfLaBobSKoLOI
rcZW6NHjZizV9IMJg4c0SrOLcmXUrbe3GKuiOXlP0VZVgj76IbdGyvNzolLurc/w
6INndRena7mHCStneZxf609td2A/BdLLQ2wDvbfr1n8H1zax/o89MJZB+hH1fDef
TyAeXa6/lD+7EPWnc80i9wlrvniCvkKWG6zs7GycOFLWG/0KNYKodcHveHStdl0=
=L38S
-----END PGP SIGNATURE-----

--Pj31OkJnxG8VEUgLb16HeJHnUrEi4e3i4--
