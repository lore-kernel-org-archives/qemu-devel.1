Received: from eggs.gnu.org ([2001:4830:134:3::10]:53049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqiGE-00087u-1w
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqiGA-00058b-RK
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqiGA-00058K-JJ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:33:14 -0400
References: <20170322123655.32085-1-pasic@linux.vnet.ibm.com>
	<9f770dc9-f26c-796a-67a7-dc37997efc69@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e023b9b-a9d5-67bb-79e2-2f9cbd77b51d@redhat.com>
Date: Wed, 22 Mar 2017 10:33:12 -0500
MIME-Version: 1.0
In-Reply-To: <9f770dc9-f26c-796a-67a7-dc37997efc69@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a2sI5RJrbAWMTdXnVfH541dkS38WHRa2m"
Subject: Re: [Qemu-devel] [PATCH] cryptodev: fix asserting single queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a2sI5RJrbAWMTdXnVfH541dkS38WHRa2m
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>
Message-ID: <6e023b9b-a9d5-67bb-79e2-2f9cbd77b51d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cryptodev: fix asserting single queue
References: <20170322123655.32085-1-pasic@linux.vnet.ibm.com>
 <9f770dc9-f26c-796a-67a7-dc37997efc69@linux.vnet.ibm.com>
In-Reply-To: <9f770dc9-f26c-796a-67a7-dc37997efc69@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 09:56 AM, Halil Pasic wrote:
>=20
>=20
> On 03/22/2017 01:36 PM, Halil Pasic wrote:
>> We already check for queues =3D=3D 1 in cryptodev_builtin_init and whe=
n that
>> is not true raise an error. But before that error is reported the
>> assertion in cryptodev_builtin_cleanup kicks in (because object is bei=
ng
>> finalized and freed).
>>
>> Let's remove assert(queues =3D=3D 1) form cryptodev_builtin_cleanup as=
 it
>> does only harm and no good.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>=20
> Sorry guys, I forgot to give credit to the reporter.
>=20
> Reported-by: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

Reviewed-by: Eric Blake <eblake@redhat.com>

>> ---
>>  backends/cryptodev-builtin.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin=
=2Ec
>> index 82a068e..137c7a6 100644
>> --- a/backends/cryptodev-builtin.c
>> +++ b/backends/cryptodev-builtin.c
>> @@ -359,8 +359,6 @@ static void cryptodev_builtin_cleanup(
>>          }
>>      }
>>
>> -    assert(queues =3D=3D 1);
>> -
>>      for (i =3D 0; i < queues; i++) {
>>          cc =3D backend->conf.peers.ccs[i];
>>          if (cc) {
>>
>=20
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--a2sI5RJrbAWMTdXnVfH541dkS38WHRa2m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0pk4AAoJEKeha0olJ0Nq75MH/jZCzZ0Lxjh97c+0DKxhL0TA
08GDFG7HsntVBTjt+1fuCVPEG5L3risT1rWXs8/pvRNELe8CIasj1zGhWSobMbzf
gqynk3VKNTnsC8SYj0IgIziTxUyLlR5rbhRhyqef98MceViMV0XzRvsNoX6YQOxF
fxP7i7sOGfnldXv+BbWBZspK5p3lZ2yIf3Rr7FhYO5pS4G6ZQ42If3ozJkEKdziG
SS20/+WoHbssX2+XNBMIZE3N6BbeLKrPAnHiSAOwEfqAcGZchLg09Xkf1cIEwejo
jN6MVaY1vqh+bbq0nqCQTXEFWPVa77Y1sD2aldbmJrYFomsvAj8MJ0xJp3yJfOM=
=9/uH
-----END PGP SIGNATURE-----

--a2sI5RJrbAWMTdXnVfH541dkS38WHRa2m--
