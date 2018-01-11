Received: from eggs.gnu.org ([2001:4830:134:3::10]:35308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZj0A-0002iB-2f
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZj08-0006ar-RE
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:59:02 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-5-eblake@redhat.com>
	<d9f7043e-450a-6cd3-dc66-8799cf018027@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7381e42b-2a92-63f7-3acf-b0f41b662a41@redhat.com>
Date: Thu, 11 Jan 2018 13:58:51 -0600
MIME-Version: 1.0
In-Reply-To: <d9f7043e-450a-6cd3-dc66-8799cf018027@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xok5HUy2nbSTi4rMMRx0EdLkb90xM7s5v"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] nbd/server: Add va_list form of
 nbd_negotiate_send_rep_err()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xok5HUy2nbSTi4rMMRx0EdLkb90xM7s5v
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7381e42b-2a92-63f7-3acf-b0f41b662a41@redhat.com>
Subject: Re: [PATCH v2 4/6] nbd/server: Add va_list form of
 nbd_negotiate_send_rep_err()
References: <20180110230825.18321-1-eblake@redhat.com>
 <20180110230825.18321-5-eblake@redhat.com>
 <d9f7043e-450a-6cd3-dc66-8799cf018027@virtuozzo.com>
In-Reply-To: <d9f7043e-450a-6cd3-dc66-8799cf018027@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 12:05 PM, Vladimir Sementsov-Ogievskiy wrote:
> 11.01.2018 02:08, Eric Blake wrote:
>> This will be useful for the next patch.
>>
>> Based on a patch by Vladimir Sementsov-Ogievskiy
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 nbd/server.c | 24 ++++++++++++++++++------
>> =C2=A0 1 file changed, 18 insertions(+), 6 deletions(-)
>>

>> -static int GCC_FMT_ATTR(4, 5)
>> -nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Error **errp, const char *fmt, ...)
>> +static int GCC_FMT_ATTR(4, 0)
>> +nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Error **errp, const char *fmt, va_list va)
>=20
> Hmm you placed fmt and va after errp. Previously we discussed one
> exclusion from "errp should be last" -
> "...", variable number of arguments. So, it is new exclusion (or I
> missed something?).. Looks good for me,
> anyway, as it corresponds to "errp, fmt, ..." notation.

Indeed, it is precisely because I value consistency between 'fmt, ...'
and 'fmt, va_list' higher than 'errp last' that I rearranged things from
your patch into the form I used.  Or worded another way, even though
va_list is only one argument in name, I treat it the same as the
variable number of arguments that warrants the exception to the errp
last rule of thumb.

>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

Thanks; I think this series is now ready for staging on my NBD queue;
although my next pull request won't be until after the weekend.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xok5HUy2nbSTi4rMMRx0EdLkb90xM7s5v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpXwfsACgkQp6FrSiUn
Q2rrewf/Y1/E94nQcDcjYoMQeOalZB6eqfq4dYLkpMqvnMs/ZMALP3EkUJu4Rdou
/2nPALFPTWDAM1E2c18qZ472KMoPV5DLKwJ779/dRJYDsZOw2rYf0byG8MPko0pz
T5O46kRX62KCrQxIOgs4gcMvK0zzNGuI8WHKaearkKd5kZMdZ0mnWlDno73e9Kee
vAceabK7Oa0n5A7iic+jOJXezcAEfEOZB/gkZd0gvYViJHYZFAz6YOF/HiaFZZW3
X6C/kkqAaAmAniNHxWInB13FV0vL+VT/cYD+N4VLYuBCVEJPI2BRhG4KXqd1wLJs
9Kx6ZzJiC1m60q1lmSvQgta6jg6Wyg==
=OkN8
-----END PGP SIGNATURE-----

--Xok5HUy2nbSTi4rMMRx0EdLkb90xM7s5v--
