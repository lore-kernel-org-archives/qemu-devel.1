Received: from eggs.gnu.org ([2001:4830:134:3::10]:59796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgCqh-0006mv-J1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgCqd-0001oH-Mq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:59:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgCqd-0001o6-Gq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:59:27 -0500
References: <1487674859-26249-1-git-send-email-armbru@redhat.com>
	<1487674859-26249-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <244e4f3a-32e8-7a7b-e26f-2226c080e364@redhat.com>
Date: Tue, 21 Feb 2017 09:59:21 -0600
MIME-Version: 1.0
In-Reply-To: <1487674859-26249-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ucHKlrkD5KqEtFKL0ecMJgrxKacbbGwf2"
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: Clean up after commit 3d344c2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ucHKlrkD5KqEtFKL0ecMJgrxKacbbGwf2
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com
Message-ID: <244e4f3a-32e8-7a7b-e26f-2226c080e364@redhat.com>
Subject: Re: [PATCH 1/2] qapi: Clean up after commit 3d344c2
References: <1487674859-26249-1-git-send-email-armbru@redhat.com>
 <1487674859-26249-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487674859-26249-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 05:00 AM, Markus Armbruster wrote:
> Drop unused QIV_STACK_SIZE and unused qobject_input_start_struct()
> parameter errp.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qobject-input-visitor.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ucHKlrkD5KqEtFKL0ecMJgrxKacbbGwf2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrGPaAAoJEKeha0olJ0NqoC0H/2WWTWN7UaK1M/NmnFnOl1yV
7xq4B55eyTmz4LjiCZGS8IEW09g7j2nlYpHWUyyTt37U2yHshKgu3KbVlm3/wr9p
JYxNQCY85Rnmc2U6UCBsfLNlAYO6cWwTTVBMMnT00o2dgM+q0kC6dCUTfU0itUZM
qXfIP2uTSrLV9HfFfY05JM+LoF2opFzX8kluqUYA32/M073Hms71j1jZsvaAffPN
+e9UAzQUv24GQHNs5ZI/FdM/PMaySUh+GIJ8K/3/uHKNRXjkqx6zffyf1jo+DAK0
A4bsxFJaSnOtJ3Q3nHd6w2jgQPug336YeKMLc3jEME3MOXQzocJsTOiQoaY7MpM=
=Jqv1
-----END PGP SIGNATURE-----

--ucHKlrkD5KqEtFKL0ecMJgrxKacbbGwf2--
