Received: from eggs.gnu.org ([209.51.188.92]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1yFe-0004yh-KO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1yFc-0005Ci-I7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:00:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1yFY-00059V-PI
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:00:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28337DC90E
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 19:00:11 +0000 (UTC)
References: <20190227135523.16952-1-berrange@redhat.com>
	<20190227135523.16952-2-berrange@redhat.com>
	<CAMxuvayzG5RtsEoM+wwPuuKq0wTqEsn9CSvft-itvaDZ-89XRw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13b80ff8-77ae-e6ba-65b4-37897f8fc5c0@redhat.com>
Date: Thu, 7 Mar 2019 13:00:05 -0600
MIME-Version: 1.0
In-Reply-To: <CAMxuvayzG5RtsEoM+wwPuuKq0wTqEsn9CSvft-itvaDZ-89XRw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5mKO4oYTdPyxYYHqC7tCVDjJnTxsZQEXC"
Subject: Re: [Qemu-devel] [PATCH 1/1] chardev: add support for authorization
 for TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5mKO4oYTdPyxYYHqC7tCVDjJnTxsZQEXC
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13b80ff8-77ae-e6ba-65b4-37897f8fc5c0@redhat.com>
Subject: Re: [PATCH 1/1] chardev: add support for authorization for TLS
 clients
References: <20190227135523.16952-1-berrange@redhat.com>
 <20190227135523.16952-2-berrange@redhat.com>
 <CAMxuvayzG5RtsEoM+wwPuuKq0wTqEsn9CSvft-itvaDZ-89XRw@mail.gmail.com>
In-Reply-To: <CAMxuvayzG5RtsEoM+wwPuuKq0wTqEsn9CSvft-itvaDZ-89XRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 12:51 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20

>> +++ b/qapi/char.json
>> @@ -248,6 +248,11 @@
>>  # @addr: socket address to listen on (server=3Dtrue)
>>  #        or connect to (server=3Dfalse)
>>  # @tls-creds: the ID of the TLS credentials object (since 2.6)
>> +# @tls-authz: the ID of the QAuthZ authorization object against which=

>> +#             the client's x509 distinguished name will validated. Th=
is
>=20
> will be? (not a native speaker, but sounds weird to me)

Yes, 'be' is missing.


>> @@ -2568,6 +2568,11 @@ and specifies the id of the TLS credentials to =
use for the handshake. The
>>  credentials must be previously created with the @option{-object tls-c=
reds}
>>  argument.
>>
>> +@option{tls-auth} provides the ID of the QAuthZ authorization object =
against
>> +which the client's x509 distinguished name will validated. This objec=
t is only
>=20
> same
>=20
>> +resolved at time of use, so can be deleted and recreated on the fly w=
hile the
>> +chardev server is active. If missing, it will default to denying acce=
ss.
>=20
> Why not have "(since 4.0)"  here?

We haven't been using it in .hx doc anywhere else (which in turn feeds
the man page and online documentation); only the QMP descriptions have
used the tag. Uniformly using it in the .hx file might make sense, but
as a much bigger cleanup task separate from this patch that just
preserves existing style.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5mKO4oYTdPyxYYHqC7tCVDjJnTxsZQEXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBajUACgkQp6FrSiUn
Q2rIXgf+KZxgpxImN1atvJkTolhQRtTEZXxTF1lM23lKdIYv4YUB7CtYKBcvajJF
8W0/VYqYjKzYzppFYEUd0LJVphdzAAKe1GaJd136AhQQ4ZH/CS37h7ubDAkDV6GC
xfwho7PUqU8019d91xvpkrLsWaHFNlB+7ngVWJQoK932L53zhjS2A2xDQPq9V03Z
8GiNcKN9zowvSP6hSV5vOBirQrxXVNGQgpZqdvYCa8mT/ORMneMVRxUIjtQcD6+7
XmtATVS+nz82R6FTykHh2Q9HIGK+wO8pM/9wVl4dg+WdV/tOcYgmeNiicMUrimUp
qRNJis1hlFEqLETPqoC5PJINXP3xrQ==
=DSuq
-----END PGP SIGNATURE-----

--5mKO4oYTdPyxYYHqC7tCVDjJnTxsZQEXC--
