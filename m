Received: from eggs.gnu.org ([2001:4830:134:3::10]:57447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW3lj-0007oz-8F
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW3li-0000f7-4E
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:48:43 -0400
References: <20170713010555.6769-1-eblake@redhat.com>
	<20170713010555.6769-15-eblake@redhat.com>
	<6559006f-9b07-a969-aca0-036477dc52c6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f6250a1-6fac-25b6-5b22-56a3e0f2df85@redhat.com>
Date: Fri, 14 Jul 2017 11:48:30 -0500
MIME-Version: 1.0
In-Reply-To: <6559006f-9b07-a969-aca0-036477dc52c6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7lFutaHxMkD1IKLGpCfTmMxFfPnsNiuTM"
Subject: Re: [Qemu-devel] [PATCH v5 14/18] qcow2: Switch qcow2_measure() to
 byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7lFutaHxMkD1IKLGpCfTmMxFfPnsNiuTM
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <6f6250a1-6fac-25b6-5b22-56a3e0f2df85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 14/18] qcow2: Switch qcow2_measure() to
 byte-based iteration
References: <20170713010555.6769-1-eblake@redhat.com>
 <20170713010555.6769-15-eblake@redhat.com>
 <6559006f-9b07-a969-aca0-036477dc52c6@redhat.com>
In-Reply-To: <6559006f-9b07-a969-aca0-036477dc52c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 01:49 PM, John Snow wrote:
>=20
>=20
> On 07/12/2017 09:05 PM, Eric Blake wrote:
>> This is new code, but it is easier to read if it makes passes over
>> the image using bytes rather than sectors (and will get easier in
>> the future when bdrv_get_block_status is converted to byte-based).
>>
>> While at it, fix a bug in the computation of nb_sectors using MAX
>> rather than MIN and thus always passing INT_MAX (thankfully, the
>> bug was harmless, as bdrv_get_block_status_above() clamps its
>> answers according to image size).
>>
>=20
> Well, unless ssize was >=3D 2^40, and then it wouldn't have chosen
> INT_MAX, right!?

But then it would have wrapped the value around while assigning it to
'int nb_sectors'.  I suppose for some very-interesting size images, you
could get nb_sectors to turn into a negative value?  At any rate, it's
good the bug was short-lived.

>=20
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7lFutaHxMkD1IKLGpCfTmMxFfPnsNiuTM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaPXeAAoJEKeha0olJ0NqdEcH/3XKe8ShfQEUwhJDbp+vDlD+
t+hPwr+OwTu2+pfpNOP5HCVN2/shGwYbyJDz5VeKFLSwbcXNaL8epQw0IPBhdZN4
QpI5su47TsbGZ9sxT3usMzBQ5WIjTTtVSfJSvqte6zYrsm2o8JOcNB9Oz+R8n1ti
31rSE0AVk/0+BW/ceOyxaX/xkZNDX9P9uHlVs3UfctRsfdD0yWtynKBroHQYTS0e
blQT9z3HLwjNLh6J1imLGVUK0shIYBcrM129zP+2PVASaP8VpuPhaVa6AIHlvqP5
d1RLsseseeJbH4u2+7rZUVUkR1v4xoF50zgy5Mo8rCVP/t+4T9eLZ7VMa6jbg8w=
=L3AK
-----END PGP SIGNATURE-----

--7lFutaHxMkD1IKLGpCfTmMxFfPnsNiuTM--
