Received: from eggs.gnu.org ([2001:4830:134:3::10]:48894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30ts-0001uf-TG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30tp-0007Cj-MY
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:53:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d30tp-0007CU-D8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:53:01 -0400
References: <faa27752-45a9-e6f3-d6fc-cad8254c4f31@web.de>
	<20170425134259.GH21129@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7cc0ade-e37f-0c06-afdb-dbcf69a72e6c@redhat.com>
Date: Tue, 25 Apr 2017 08:52:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170425134259.GH21129@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gqjbwvjhKEtTQlieF03DoMlhDll8wbuhj"
Subject: Re: [Qemu-devel] [PATCH v2] crypto_gen_random() now also works on
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Geert Martin Ijewski <gm.ijewski@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gqjbwvjhKEtTQlieF03DoMlhDll8wbuhj
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Geert Martin Ijewski <gm.ijewski@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Message-ID: <a7cc0ade-e37f-0c06-afdb-dbcf69a72e6c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] crypto_gen_random() now also works on
 windows
References: <faa27752-45a9-e6f3-d6fc-cad8254c4f31@web.de>
 <20170425134259.GH21129@redhat.com>
In-Reply-To: <20170425134259.GH21129@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 08:42 AM, Daniel P. Berrange wrote:
> On Mon, Apr 24, 2017 at 07:51:49PM +0200, Geert Martin Ijewski wrote:
>> If no crypto library is included in the build QEMU uses
>> qcrypto_random_bytes() to generate random data. That function tried to=
 open
>> /dev/urandom or /dev/random and if openeing neither file worked it err=
ored
>> out.
>>

>> +int qcrypto_random_init(Error **errp)
>> +{
>> +#ifdef _WIN32
>> +    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL,
>> +                             CRYPT_SILENT | CRYPT_VERIFYCONTEXT)) {
>> +        error_setg_errno(errp, GetLastError(),
>> +                         "Unable to create cryptographic provider");
>=20
> Unfortunately the return value of 'GetLastError()' isn't an errno
> so we can't use error_setg_errno here.
>=20
> Just use error_setg, and report the error value with a '(code=3D%u)'
> substitution at the end of the error message.
>=20

Or, use error_setg_win32(), which is designed for this purpose.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gqjbwvjhKEtTQlieF03DoMlhDll8wbuhj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/1S6AAoJEKeha0olJ0NqPVAH+gLsK2ckeFdjyeq0Ra79dy1F
m+T6snTV4egRerR7dD63Uv9NCWx3dab7+B/B8vdyMZdfnXGotPTmLcBWqjTuIPZ1
g78lQpYRXroh23swzc57UTxHeDu+LNHBZgEM2yXNR/ZoHRml3M0R6/PG5H/8lW0g
exI22XGxuDV5LTnxXrb9vS9+kK98xHyBeNKCqYl4nv69o4v0Ar6dV7865Jt6yk6g
aBYsDgfzFGJ/pPOq5uHNZDXu5LFHH1v+Fn5gGl19/FgJiQq9YWlz/LMSfGCkWO1c
q2/2vTzNSUO8CEVwaev76m9IUleDCMPJu+KCfJxJ/5CMQOvKX1mHejmapmyy8jg=
=Wgwf
-----END PGP SIGNATURE-----

--gqjbwvjhKEtTQlieF03DoMlhDll8wbuhj--
