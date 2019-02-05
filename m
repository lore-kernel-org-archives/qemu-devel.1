Received: from eggs.gnu.org ([209.51.188.92]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqqoJ-0003tF-Pc
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 21:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqqoI-00033o-W7
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 21:50:07 -0500
References: <20190205022502.11654-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0888ceaa-f0e0-7ffc-03e1-b223bb65fd69@redhat.com>
Date: Mon, 4 Feb 2019 20:50:01 -0600
MIME-Version: 1.0
In-Reply-To: <20190205022502.11654-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HDgKmNrdjzeRA4hmJXq4Yf8LG8bWSrCYu"
Subject: Re: [Qemu-devel] [PATCH v3] checkpatch: Flag suspicious attribution
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, philmd@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HDgKmNrdjzeRA4hmJXq4Yf8LG8bWSrCYu
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, philmd@redhat.com
Message-ID: <0888ceaa-f0e0-7ffc-03e1-b223bb65fd69@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] checkpatch: Flag suspicious attribution
 lines
References: <20190205022502.11654-1-eblake@redhat.com>
In-Reply-To: <20190205022502.11654-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/4/19 8:25 PM, Eric Blake wrote:
> Flag commit attribution tags that are unusual (often because they
> were a typo), but only as a warning (because sometimes a humorous
> or otherwise useful tag is intentionally supplied).
>=20
> This picks the 6 most popular tags, each with 700 or more uses (well,
> S-o-b was already checked for case-sensitivity and typos, leaving
> only 5 new tags being checked), as determined by:
> $ git log | sed -n 's/^ *\([A-Za-z-]*-[bB][yY]:\).*/\1/p' | \
>   sort | uniq -c | sort -k1,1n | tail

[-_][bB][yY] finds an additional:

      2 Reviewed_by:

Should I try to flag those as well, in v4 (note - the current
Signed-off-by tests do not flag Signed_off_by as invalid, so the patch
does get a bit bigger if we want to catch it)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HDgKmNrdjzeRA4hmJXq4Yf8LG8bWSrCYu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxY+dkACgkQp6FrSiUn
Q2rglAf/d2VkThRJfXBsMBr0/kQCTfKiiQixDxG58ouCJb0KKpryY9AptLWBqTYH
X1fUCfqZMEy27Wv5Bx6PAfISedRtDruracKmEeaHdcj5YWXL5HVbM0QX3gVA0qHn
R1fgKWRM53ge4zYGcovKQJafLDh8PmLGFTY0ALLuMldiqvnkB1WCKRN0Ixzb0csd
oEoU+xEPsY8nL9BTJJqQF7R7Par3+NPSRtb08KAM34NPhphkm9hRbAUkSgE7+fab
715R1SFZKNGY7voxL3Jq74rhc/Fcy7hpdOQiZydHZ8D/2qI2wP1eKGpSGa4wqq2u
SR3aGND8lQv7oOqHxFMX5XwBEiAOXg==
=5ggp
-----END PGP SIGNATURE-----

--HDgKmNrdjzeRA4hmJXq4Yf8LG8bWSrCYu--
