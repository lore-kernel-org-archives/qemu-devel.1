Received: from eggs.gnu.org ([2001:4830:134:3::10]:42828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhglD-0004Wj-DO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhgl8-00035Z-QD
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:40:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhgl8-00034N-Gu
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:40:10 -0400
References: <20170815163959.6632-1-f4bug@amsat.org>
	<20170815163959.6632-2-f4bug@amsat.org>
	<a2773ebe-e841-4f3f-0234-d89e48811336@redhat.com>
	<4837e428-461c-ef00-b584-42e4c22e8fc7@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b25c2fb-6f18-37e3-b7dd-56b9d59c22ca@redhat.com>
Date: Tue, 15 Aug 2017 13:40:05 -0500
MIME-Version: 1.0
In-Reply-To: <4837e428-461c-ef00-b584-42e4c22e8fc7@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FlRb2rCICerPxkORjLijvN7nrNVnRjTeX"
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] libqtest: add qtest_accel() to
 avoid warnings when kvm is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FlRb2rCICerPxkORjLijvN7nrNVnRjTeX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b25c2fb-6f18-37e3-b7dd-56b9d59c22ca@redhat.com>
Subject: Re: [RFC PATCH 1/2] libqtest: add qtest_accel() to avoid warnings
 when kvm is not available
References: <20170815163959.6632-1-f4bug@amsat.org>
 <20170815163959.6632-2-f4bug@amsat.org>
 <a2773ebe-e841-4f3f-0234-d89e48811336@redhat.com>
 <4837e428-461c-ef00-b584-42e4c22e8fc7@amsat.org>
In-Reply-To: <4837e428-461c-ef00-b584-42e4c22e8fc7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 01:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/15/2017 03:13 PM, Eric Blake wrote:
>> On 08/15/2017 11:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> only warn once about it.
>>>
>>> - kernel without kvm:
>>>
>>>      # make check-qtest-x86_64
>>>        GTESTER check-qtest-x86_64
>>>      Could not access KVM kernel module: No such device
>>>      qemu-system-x86_64: failed to initialize KVM: No such device
>>>      qemu-system-x86_64: Back to tcg accelerator
>>
>> How does this differ from what commit 2f6b38d1 was trying to do?
>=20
> I'd say 2f6b38d1 is for common end-user usage while this is for
> QA/testers usage. If you run N qtests with the same machine arguments,
> having this warning displayed only once is enough and allow you to focu=
s
> on the tests output.

I guess my question is: Are we still getting a warning output even with
2f6b38d1 applied?  If so, why, because the point of that commit was to
avoid the warning.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FlRb2rCICerPxkORjLijvN7nrNVnRjTeX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTQAUACgkQp6FrSiUn
Q2piNAf/QE5F01FBrDOzzH0F2o0DY00dKPlMd+XbnQzXHQmG5eern3pglGqb3pYl
DNspR+YIfzZSeMHkCS+2wpC2D/J1UwC8o8tiguw3RlAdgHr9medoLAdWAQWLKH+D
5FSYLI1THBWuHLfs42Bf5j3+uuXayklvxE38tModlGUeNQFmWh8pmhVHiyxZuBFs
yIe27/Ae4ggnHmE/fMaGXWSbf1ltUDb/P3zZ73RZbPyNWN8/9iP9bWQoojCMQ+by
hSI2Jx64TgKsMQ0l1wvi1+1cpOep9zVtqfs80ZYRLEFKhBoKaQd8y5QqkYZXBXSj
RCE4SPDV97ZzxH/oRZC02D+Av1YRgA==
=+6Xr
-----END PGP SIGNATURE-----

--FlRb2rCICerPxkORjLijvN7nrNVnRjTeX--
