Received: from eggs.gnu.org ([2001:4830:134:3::10]:53827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftx5-0008Sj-FZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftx2-0000zk-O2
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:48:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cftx2-0000zY-G0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:48:48 -0500
References: <1487614915-18710-1-git-send-email-den@openvz.org>
	<1487614915-18710-3-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e55a8e9-0a5d-5602-7626-9c7976f6a49c@redhat.com>
Date: Mon, 20 Feb 2017 13:48:45 -0600
MIME-Version: 1.0
In-Reply-To: <1487614915-18710-3-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RfaTFwQnCt6kNWquaCN9CnvdXNg2BDKSB"
Subject: Re: [Qemu-devel] [PATCH 2/3] qapi: flatten GuestPanicInformation
 union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RfaTFwQnCt6kNWquaCN9CnvdXNg2BDKSB
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e55a8e9-0a5d-5602-7626-9c7976f6a49c@redhat.com>
Subject: Re: [PATCH 2/3] qapi: flatten GuestPanicInformation union
References: <1487614915-18710-1-git-send-email-den@openvz.org>
 <1487614915-18710-3-git-send-email-den@openvz.org>
In-Reply-To: <1487614915-18710-3-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 12:21 PM, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
>  qapi-schema.json  | 12 ++++++++++++
>  target/i386/cpu.c | 15 ++++++---------
>  vl.c              | 12 ++++++------
>  3 files changed, 24 insertions(+), 15 deletions(-)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index e9a6364..b142e15 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5872,6 +5872,16 @@
>    'data': [ 'pause', 'poweroff' ] }
> =20
>  ##
> +# @GuestPanicInformationType:
> +#
> +# An enumeration of the guest panic information types
> +#
> +# Since: 2.9
> +##
> +{ 'enum': 'GuestPanicInformationType',
> +  'data': [ 'hyper-v'] }

Perhaps 'hyperv' is better? It's the difference between
GUEST_PANIC_INFORMATION_TYPE_HYPER_V and
GUEST_PANIC_INFORMATION_TYPE_HYPERV. But that's bikeshedding, so no need
to change it.

Must go into 2.9, so we aren't baking in bad API.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--RfaTFwQnCt6kNWquaCN9CnvdXNg2BDKSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq0gdAAoJEKeha0olJ0Nq2q8IAJRdasAlZnT2p6gLk1m9OCRP
wrrly5niibfZNjHEI+13fcjXJu3cSFU6nADav9cBRio3TcD+uZC5i9t3ir5qV57t
Q0CwVG+GO6UQapfBIQuJlj46RV+bCcQNuLYc8hJk8xwjiqyhi7tICM8/NeW++0fG
/+V+v4X3WgTHpkoZHLHz69n2A9x/1O9jO07LoEDQ+PqUc4x6b3GehSWWSYvnoiz3
togWnk8mElbMoOteFI78ijsFcsHKU8Bhka4bpD9kyuzpELBADDxUBmkzJ9VroWOV
ZO5II2G3dwicox7jRHHRVfTfYV58utstxRH54FExP7XOSVi3rTsvhQT/cXc3G7U=
=uV+I
-----END PGP SIGNATURE-----

--RfaTFwQnCt6kNWquaCN9CnvdXNg2BDKSB--
