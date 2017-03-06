Received: from eggs.gnu.org ([2001:4830:134:3::10]:48847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvBR-0004n9-BL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvBN-0004vc-59
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:08:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckvBM-0004vX-SM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:08:21 -0500
References: <20170306071721.26708-1-ppandit@redhat.com>
	<20170306071721.26708-3-ppandit@redhat.com>
	<988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1376d6af-da2d-eb9c-75f0-13e5c597b820@redhat.com>
Date: Mon, 6 Mar 2017 10:08:18 -0600
MIME-Version: 1.0
In-Reply-To: <988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bcF5lqHXAnPs4LUFwrpC8ha2HWxK5faS8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: allocate heap memory
 for execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>, Jann Horn <jannh@google.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bcF5lqHXAnPs4LUFwrpC8ha2HWxK5faS8
From: Eric Blake <eblake@redhat.com>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio
 <riku.voipio@iki.fi>, Prasad J Pandit <pjp@fedoraproject.org>,
 Jann Horn <jannh@google.com>
Message-ID: <1376d6af-da2d-eb9c-75f0-13e5c597b820@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: allocate heap memory for
 execve arguments
References: <20170306071721.26708-1-ppandit@redhat.com>
 <20170306071721.26708-3-ppandit@redhat.com>
 <988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
In-Reply-To: <988a673c-01cd-0c1e-133c-22e299653502@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 09:53 AM, Eric Blake wrote:
> On 03/06/2017 01:17 AM, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> Arguments passed to execve(2) call from user program could
>> be large, allocating stack memory for them via alloca(3) call
>> would lead to bad behaviour. Use 'g_malloc0' to allocate memory
>> for such arguments.
>>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>  linux-user/syscall.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> Is this patch alone (without 1/2) sufficient to solve the problem?  If
> so, then drop 1/2.
>=20
>>
>> Update per: replace alloca() with g_malloc0()
>>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00750.ht=
ml
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 86a4a9c..404fb0b 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7800,8 +7800,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
>=20
> What version of qemu are you patching?  Line 7800 of current master is
> nowhere near 'case TARGET_NR_execve:' (line 7899)
>=20
>>                  ret =3D -TARGET_E2BIG;
>>                  break;
>>              }
>=20
> and current master has 'goto efault' rather than directly setting ret a=
t
> this point.

Okay, I see that this context came from patch 1/2. Sorry for the noise
(I was trying to review this patch in isolation, since I've already
argued that 1/2 is probably not necessary).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--bcF5lqHXAnPs4LUFwrpC8ha2HWxK5faS8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvYlyAAoJEKeha0olJ0NqUckIAKE0VSAIOhblMMi5qFs+HxGD
grJ+vawcSXc9Hm47uhiRAujAtIkyh6ZBPeh0pNZM2qzZlacZpqU3GHpQt/3GVAD9
VjMb8w34fSbmXXPCafoCH99ReeGfWLqB+eMT94JlxrEHzGfXLk34DT43EnMoiZnq
QVBNB4vY5D1+glcUjS3sVxEdbDRntzwAhrsm1DV9PAmTG4ttoUbjlwz6FXsFpsWM
7GhM+DUh8D06bL1v3S/AJATBeZ3a0D9OYlUoCqCkRhfML2qB0tnhLCSoe/t1ovm2
KqfHVjkxHjljpO1IuF4bEiCPJHyoIMWseTOy2dwFWeIyNra3dlowICaGGPqRI8c=
=P/IK
-----END PGP SIGNATURE-----

--bcF5lqHXAnPs4LUFwrpC8ha2HWxK5faS8--
