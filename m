Received: from eggs.gnu.org ([2001:4830:134:3::10]:55165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYyQ5-00052r-UQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYyQ4-0002e5-Tg
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:14:41 -0500
References: <20180108030946.14991-1-famz@redhat.com>
	<8c75f873-421d-4e26-d555-ad30b350ea1d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76ded786-48fb-de4d-5513-c6ec30a8a2a8@redhat.com>
Date: Tue, 9 Jan 2018 12:14:27 -0600
MIME-Version: 1.0
In-Reply-To: <8c75f873-421d-4e26-d555-ad30b350ea1d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dg7akIU3npv86di8aojq9HW1zbcS1YbLW"
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't check uninitialized local
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dg7akIU3npv86di8aojq9HW1zbcS1YbLW
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Message-ID: <76ded786-48fb-de4d-5513-c6ec30a8a2a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't check uninitialized local
 variable
References: <20180108030946.14991-1-famz@redhat.com>
 <8c75f873-421d-4e26-d555-ad30b350ea1d@redhat.com>
In-Reply-To: <8c75f873-421d-4e26-d555-ad30b350ea1d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2018 12:05 PM, Paolo Bonzini wrote:
> On 08/01/2018 04:09, Fam Zheng wrote:
>> After the out label there is a check on iTask.task but it is not
>> initialized yet.
>>
>> Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  block/iscsi.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index 5c0a9e55b6..1cb8cc93c5 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -659,8 +659,7 @@ static int64_t coroutine_fn iscsi_co_get_block_sta=
tus(BlockDriverState *bs,
>>      int64_t ret;
>> =20
>>      if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsil=
un)) {
>> -        ret =3D -EINVAL;
>> -        goto out;
>> +        return -EINVAL;
>>      }
>> =20
>>      /* default to all sectors allocated */
>>
>=20
> Queued, thanks.

I thought we wanted Peter's version, not Fam's.
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01237.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Dg7akIU3npv86di8aojq9HW1zbcS1YbLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVBoMACgkQp6FrSiUn
Q2qRFwf+IKZdCkzaoOUatLagVII1JCVFzsM/B5zHTL1QQdvPHllDuL34LZus9uzu
94dhV/+DcDdvPBG+aS6wZMJjNvwrYaZeiH1/cgiNqS9e5jKEK/oy3pJff2S3r5GZ
IXom1ThpKYgVklv03LcehAxnFzDQbfN9KVeXhAKjpArnlP9/6rVe2URt7UfbsTNY
9MPlWPsO+N2HA8o16szPH2lD87Sy1yXPmo/4T4Due4uKctuoJnd7BEmrURBPottD
uvgMTstwNvB14e/2WacVITWQBcQPMQkd3mbymlsOQvHMQ8lqEJkkyg3eN2Lv5kOH
CiSGSjlJVOocvJ0g39GsUygGbI+PAQ==
=WGUh
-----END PGP SIGNATURE-----

--Dg7akIU3npv86di8aojq9HW1zbcS1YbLW--
