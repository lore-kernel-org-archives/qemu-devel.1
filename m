Received: from eggs.gnu.org ([2001:4830:134:3::10]:39909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepo1-00087R-Eo
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepo0-0006N8-DX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:11:05 -0500
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-21-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b51fa4ed-874d-673f-e2e4-1cf24cd251f6@redhat.com>
Date: Fri, 17 Feb 2017 15:10:55 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-21-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L4el7tNp0HDfSiwAA6VSmeP8N2q3GIklK"
Subject: Re: [Qemu-devel] [PATCH 20/24] qemu-img: Wrap cvtnum() around
 qemu_strtosz()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L4el7tNp0HDfSiwAA6VSmeP8N2q3GIklK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <b51fa4ed-874d-673f-e2e4-1cf24cd251f6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 20/24] qemu-img: Wrap cvtnum() around
 qemu_strtosz()
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-21-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-img.c | 58 +++++++++++++++++++++++++++++++-----------------------=
----
>  1 file changed, 31 insertions(+), 27 deletions(-)


> @@ -3858,11 +3866,9 @@ static int img_dd_count(const char *arg,
>                          struct DdIo *in, struct DdIo *out,
>                          struct DdInfo *dd)
>  {
> -    char *end;
> +    dd->count =3D cvtnum(arg);

Hmm. cvtnum() accepts "1.5G", GNU dd does not. POSIX requires dd to
accept '1kx10k' to mean 10 mebibytes, and GNU dd accepts '10xM' as a
synonym, but cvtnum() does not accept all those corner cases.  POSIX
requires dd to treat '1b' as '512', while cvdnum() treats it as '1'.  I
sometimes wonder if our 'qemu-img dd' subcommand should be reusing the
numeric parsing that we use everywhere else, in spite of it meaning that
we are different than the POSIX quirks on what numbers are required to
be supported by dd.  But that's not the concern of this patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--L4el7tNp0HDfSiwAA6VSmeP8N2q3GIklK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp2bfAAoJEKeha0olJ0NqSSIH/jBB670FLMIUnaPu8k6w79O9
z4YUfGwNEPJxh/d1R7TnhCG1NtnXKL0m0PLNcxsOBJxAljYcsoFmJmVCqv8Qqa/w
IWF67nNa17NygVXklBIwDm91RJVfWyFFawpLmeFUXFfjzFyd1Co5hfEqsHVqdnnw
tQiy9wk96mcc7KsJOTQJiYyvQkzXCMNxnnq563Xa7qok/+BVVMlVUEmtvmyqwKmf
hbXJ+6n2t+W/SChoCqgk1W/SRxfdadNfLvvpqqrk7a0mqZBzzffpSn4cIHn6VIsC
BlilgSM52p0Jud7ZFzObPNeL4xEXJTCmasm2hXBDE3Jphac+aIWvLlNZU5i8kzw=
=aOBY
-----END PGP SIGNATURE-----

--L4el7tNp0HDfSiwAA6VSmeP8N2q3GIklK--
