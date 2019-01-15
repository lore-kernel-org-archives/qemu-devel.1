Received: from eggs.gnu.org ([209.51.188.92]:34567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjR44-0003ZF-4g
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjR43-00079D-10
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:55:44 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-11-eblake@redhat.com>
	<e24c7f01-a203-c6ce-ac95-77cb74c590df@virtuozzo.com>
	<c0ab928c-3efc-41fd-f16f-6a6b4e465e9a@redhat.com>
	<52cbe9ac-0b58-e545-4b50-ab03fee642d4@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12a8e60d-8357-06d0-d689-ecc7a5f63435@redhat.com>
Date: Tue, 15 Jan 2019 09:55:28 -0600
MIME-Version: 1.0
In-Reply-To: <52cbe9ac-0b58-e545-4b50-ab03fee642d4@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pxqBGJI2irBfHvgB8Tyj3ABisi6hJRykJ"
Subject: Re: [Qemu-devel] [PATCH v3 10/19] nbd/client: Split out
 nbd_send_one_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pxqBGJI2irBfHvgB8Tyj3ABisi6hJRykJ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <12a8e60d-8357-06d0-d689-ecc7a5f63435@redhat.com>
Subject: Re: [PATCH v3 10/19] nbd/client: Split out
 nbd_send_one_meta_context()
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-11-eblake@redhat.com>
 <e24c7f01-a203-c6ce-ac95-77cb74c590df@virtuozzo.com>
 <c0ab928c-3efc-41fd-f16f-6a6b4e465e9a@redhat.com>
 <52cbe9ac-0b58-e545-4b50-ab03fee642d4@virtuozzo.com>
In-Reply-To: <52cbe9ac-0b58-e545-4b50-ab03fee642d4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 9:52 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> -nbd_opt_meta_request(const char *context, const char *export) "Requ=
esting to set meta context %s for export %s"
>>>> +nbd_opt_meta_request(const char *optname, const char *context, cons=
t char *export) "Requesting %s %s for export %s"
>>>
>>> Hmm, you forget nbd_opt_lookup()
>>
>> Where? The updated trace point at [2] has nbd_opt_lookup() for
>> determining optname.
>=20
> Your morning is my evening)
>=20
> Yes, it's ok, and in the next patch too. But you usually trace both num=
ber + lookup-string,
> and here only string. Is there a reason to?

I didn't see any added value in tracing the number, since the trace
point can only happen on one of two opt values (the number is more
important when the opt value can be anything, including one that does
not have a corresponding string name compiled in).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--pxqBGJI2irBfHvgB8Tyj3ABisi6hJRykJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+AnAACgkQp6FrSiUn
Q2q2LAgAgSSacb0jcay0YL5KTORAiYvrpq+aiBBgiNOi3SiDp4jo2rE18DPAiZ/w
RRz4l4BiGCngUFLf6vRtwVGWFrG8PCgjmnY56fOQTMNzHGxosRPnnxb8Op2CS+aG
bwoSTx8NTkz9a0grwzoUKTn2C+/9v7j2T0LeR64gKvt2KNpe8LsJFClwuV64UDlB
XK31A27WCbIqV4LPGAxWKXtztOUIzvyV43+HCy4T8wyU7G+5D0mS7rIpIhK6fhHf
JXOgFW00mODa2Pkaj3+yUt66rQ7rGpo054bg48AulT/fJ7bcCintcL2Q+4oxY/Ny
hTEz3ZZBskVt+hhcwPlZb9OxN0pOvg==
=KUcx
-----END PGP SIGNATURE-----

--pxqBGJI2irBfHvgB8Tyj3ABisi6hJRykJ--
