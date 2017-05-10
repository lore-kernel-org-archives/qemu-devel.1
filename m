Received: from eggs.gnu.org ([2001:4830:134:3::10]:39108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Y9V-0002BP-F1
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Y9S-00050h-DF
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:24:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8Y9S-0004zu-3R
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:24:02 -0400
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-2-f4bug@amsat.org>
	<0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2036e6f-5e10-ef4d-bf2b-f6704604bbbb@redhat.com>
Date: Wed, 10 May 2017 15:23:56 -0500
MIME-Version: 1.0
In-Reply-To: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SDX9XQflOmvvbKn4VLjQlIOF73dUAObt3"
Subject: Re: [Qemu-devel] [PATCH 1/8] coccinelle: add a script to optimize
 tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SDX9XQflOmvvbKn4VLjQlIOF73dUAObt3
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2036e6f-5e10-ef4d-bf2b-f6704604bbbb@redhat.com>
Subject: Re: [PATCH 1/8] coccinelle: add a script to optimize tcg op using
 tcg_gen_extract()
References: <20170510200535.13268-1-f4bug@amsat.org>
 <20170510200535.13268-2-f4bug@amsat.org>
 <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
In-Reply-To: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2017 03:19 PM, Richard Henderson wrote:
> On 05/10/2017 01:05 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> +-tcg_gen_shri_tl(ret, arg, ofs);
>> +-tcg_gen_andi_tl(ret, ret, len);
>> ++tcg_gen_extract_tl(ret, arg, ofs, len);
>=20
> You can't simply copy the and mask to the extract length.
>=20
> You need to verify it's all low bits and convert that to a count of the=

> low bits.  E.g. 0xff -> 8.

Coccinelle may still be able to do that, but it becomes a little less
obvious (and I'm not the expert to consult on what that would look like).=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SDX9XQflOmvvbKn4VLjQlIOF73dUAObt3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE3bcAAoJEKeha0olJ0NqYggIAKeBigvgu45eZmeiB4+IKTkM
x7Z6B3UeLbazQ29t37hyiqMsyK/9aJQzTXOqcVUgSaXhJDl6lRgSSF8qLwB9Bf08
eP/wMtECL50LxVStqCOUTfk2whxS4z/7dIzNO8JgkQAmOnetrPb1SHXap5vH7xPH
k6buWM0xsf8o4vk9/zEnukb0HjAAvssxZ9vvx1KzboN1IfOOnjJ0ULxlKcmH8Jzf
hQGWOGXjSjaBw8kpnvQFfinM/jgdguJZbBVQipLQ4RaBWrwB6Z4Khe1w/uzHh2ug
iqKeH30uZ3UJe9shE3DxAAPKRxuo/o8J1b21t2sFKuiZfVJ98+MqeiBfyfb7zl8=
=TbG9
-----END PGP SIGNATURE-----

--SDX9XQflOmvvbKn4VLjQlIOF73dUAObt3--
