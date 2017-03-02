Received: from eggs.gnu.org ([2001:4830:134:3::10]:55831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjZxc-0004vy-Q4
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjZxb-0002ks-Rv
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:16:36 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1b6205c-490d-5d7c-64c5-9eaa4d8b7175@redhat.com>
Date: Thu, 2 Mar 2017 17:16:23 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fFDlf71klog8dGaduk4JHN45j6UHACxi6"
Subject: Re: [Qemu-devel] [PATCH 03/15] sheepdog: Fix error handling
 sd_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fFDlf71klog8dGaduk4JHN45j6UHACxi6
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <a1b6205c-490d-5d7c-64c5-9eaa4d8b7175@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/15] sheepdog: Fix error handling
 sd_create()
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:43 PM, Markus Armbruster wrote:
> As a bdrv_create() method, sd_create() must set an error and return
> negative errno on failure.  It prints the error instead of setting it
> when connect_to_sdog() fails.  Fix that.
>=20
> While there, return the value of connect_to_sdog() like we do
> elsewhere, instead of -EIO.  No functional change, as
> connect_to_sdog() returns no other error code.
>=20
> Many more suspicious uses of error_report() and error_report_err()
> remain in other functions.  Left for another day.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fFDlf71klog8dGaduk4JHN45j6UHACxi6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuKfHAAoJEKeha0olJ0Nq2t8H/2qhIjM/nSlbWx79LcmFLjWP
UqMarH9DdoyCD2DaO5LCfUg14jKIPC8U98vLKDHi9xs/n+QenMQfL4/vRGD5Ray8
dSfkuNTxIU/SDmZfyeT1PqxtinPrxm7JCAD5Y3+c147ouj0hKpWai3CZ36jTk7t/
PmposMZEy5P8Yl1kYI35SQ9+2RHhONYuAkjB7/eQFQg7z7KSje/UUDjOOWgH2e1R
keP6yFhdqxFE3j1sJfheyJqq57q1/ZQX2hzEgwZzxEU4q1KmyrBB7S61gkBV9gZ3
iTKY6vQFWIqnI+oFuknzIjWDarT7xKpSD4QchtqJA7OXVk8ilx58bCG652WCs0w=
=k81k
-----END PGP SIGNATURE-----

--fFDlf71klog8dGaduk4JHN45j6UHACxi6--
