Received: from eggs.gnu.org ([2001:4830:134:3::10]:48648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpMCf-0002AX-E8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpMCa-0003W0-I8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpMCa-0003VZ-8l
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:20:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FE5B81E1D
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 22:20:11 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-9-eblake@redhat.com>
	<0a344384-f482-5602-490a-928db53c46b5@redhat.com>
	<87zia9xyfo.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2316c879-7dc2-c121-1a41-41253c204925@redhat.com>
Date: Tue, 5 Sep 2017 17:20:05 -0500
MIME-Version: 1.0
In-Reply-To: <87zia9xyfo.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gpCgKw7xAmB3jRbKW4xsEHbd8hUsj9drn"
Subject: Re: [Qemu-devel] [PATCH v6 08/29] libqtest: Let socket_send()
 compute length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gpCgKw7xAmB3jRbKW4xsEHbd8hUsj9drn
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <2316c879-7dc2-c121-1a41-41253c204925@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 08/29] libqtest: Let socket_send() compute
 length
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-9-eblake@redhat.com>
 <0a344384-f482-5602-490a-928db53c46b5@redhat.com>
 <87zia9xyfo.fsf@dusky.pond.sub.org>
In-Reply-To: <87zia9xyfo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 04:54 AM, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 01.09.2017 20:03, Eric Blake wrote:
>>> Rather than make multiple callers call strlen(), it's easier if
>>> socket_send() itself can compute a length via strlen() if none
>>> was provided (caller passes -1).  Callers that can get at the
>>> length more efficiently are left that way.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  tests/libqtest.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> I have to say that I don't like this idea very much. socket_send()
>> should IMHO not know about the type of the data that should be sent,
>> i.e. it should not assume that the content is a zero-terminated string=
=2E
>=20
> I agree.

It doesn't assume that the content is zero-terminated unless you pass a
negative length.

>=20
>> This also could lead to some hard to detect bugs later in case somebod=
y
>> is calling the function like this:
>>
>>   size =3D someotherfunction();
>>   socket_send(fd, buf, size);
>>
>> ... and the someotherfunction() returned a negative error code instead=

>> of a correct size.
>>
>> So I'd like to suggest to simply drop this patch.
>=20
> A separate wrapper function for sending zero-terminated strings would b=
e
> fine with me.

I'm fine dropping the patch; computing the length in the callers is not
that much more onerous (there aren't that many), so I don't think
another wrapper is needed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gpCgKw7xAmB3jRbKW4xsEHbd8hUsj9drn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmvIxUACgkQp6FrSiUn
Q2qg4wf/ekmc45J323LRa6XiGuALNXQLWYv6PuYyEdsv0EiOcb/aHvNR+B7U5+h8
9dXb9QMU6LzLEYmQLdhDyF7AhoBX286E/HU2noc8yzODQSD5ZuFl19IzNvTHAEI7
APmXeo3aUdrucihB2UCfUXTrO4gDfozK5R4wHJ29Ht2zuIbV7/w3MrSpq8Apvjb+
yA63o2LZDEgTC8U/w94mEGXrFK+osDJbDbhmCuLHrqGS+Cm+UaioN8AjuD7PDi5e
iNdExxkrzVogwKs4roQP8q+5Wzbo/hBZraE01yJWUkQyoGDB+F6gdPQFbtDOuJYz
mFLdvY2OfQGFQgP2+2Fo8w4pVI7Pcg==
=O17e
-----END PGP SIGNATURE-----

--gpCgKw7xAmB3jRbKW4xsEHbd8hUsj9drn--
