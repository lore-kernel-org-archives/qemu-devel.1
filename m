Received: from eggs.gnu.org ([2001:4830:134:3::10]:41946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duJu7-0007ZF-Mz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duJu6-0005CV-MN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duJu6-0005CJ-Dy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:53:38 -0400
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-4-marcandre.lureau@redhat.com>
	<09b52e82-484e-a840-7300-0fcd0f40d1d7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cfea9897-c831-acef-08b8-d7053c7760e2@redhat.com>
Date: Tue, 19 Sep 2017 09:53:28 -0500
MIME-Version: 1.0
In-Reply-To: <09b52e82-484e-a840-7300-0fcd0f40d1d7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qolpSXICun10tflO6dQDDJwi8hF33HW97"
Subject: Re: [Qemu-devel] [PATCH 03/27] libvhost-user: improve
 vu_queue_pop() doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qolpSXICun10tflO6dQDDJwi8hF33HW97
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com
Message-ID: <cfea9897-c831-acef-08b8-d7053c7760e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/27] libvhost-user: improve vu_queue_pop()
 doc
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
 <20170823162004.27337-4-marcandre.lureau@redhat.com>
 <09b52e82-484e-a840-7300-0fcd0f40d1d7@redhat.com>
In-Reply-To: <09b52e82-484e-a840-7300-0fcd0f40d1d7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 08:43 AM, Paolo Bonzini wrote:
> On 23/08/2017 18:19, Marc-Andr=C3=A9 Lureau wrote:
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  contrib/libvhost-user/libvhost-user.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-=
user/libvhost-user.h
>> index 53ef222c0b..9b9b00e191 100644
>> --- a/contrib/libvhost-user/libvhost-user.h
>> +++ b/contrib/libvhost-user/libvhost-user.h
>> @@ -351,7 +351,8 @@ void vu_queue_notify(VuDev *dev, VuVirtq *vq);
>>   * @vq: a VuVirtq queue
>>   * @sz: the size of struct to return (must be >=3D VuVirtqElement)
>>   *
>> - * Returns: a VuVirtqElement filled from the queue or NULL.
>> + * Returns: a VuVirtqElement filled from the queue or NULL. The
>> + * returned element must be free() by the caller.
>=20
> Maybe free()-d or freed.

Is it actually free(), or g_free()?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qolpSXICun10tflO6dQDDJwi8hF33HW97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBL2gACgkQp6FrSiUn
Q2oOeQf+OFNJhKxC8OFDEosXZfEjbo2gESkwuULk5jDM4wuxaGrtlCvbE/giFtLz
4bl/Z1njBpy67hAKPGYCOeuEpZ7XMRa8Jyg/IZJz2pKRD9gBnbZRqzIhHVrmpA7R
x3NpzMKcsXDdYeDx4XyFAysrdqJxbpXezMNJwwm2Tirw8AbZZYfAe7FvSwYWYq+P
x/rhA8NWCmUvlFvp50SmnYNaSVG2kdO/hVsUFgLrT0TqLvNTRfKHt+2Cub6YJYGd
89Vy6IzvaguJuT9st0B03Nw7mK8C3g1IfnSBTdL9fRBdw7EaJNnix33WNF/aCD6k
c7ddqhFuCd+st3WfzWsfV6X0WJ7ZdQ==
=zxLw
-----END PGP SIGNATURE-----

--qolpSXICun10tflO6dQDDJwi8hF33HW97--
