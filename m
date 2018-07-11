Received: from eggs.gnu.org ([2001:4830:134:3::10]:52986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFGq-0004Qs-LA
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFGm-0001sN-Iw
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:35:04 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFGm-0001rw-DK
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:35:00 -0400
Received: by mail-qk0-x242.google.com with SMTP id u21-v6so13531744qku.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:35:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <BN7PR08MB4868C0F99A12534DE079C256C6410@BN7PR08MB4868.namprd08.prod.outlook.com>
	<20180711123612.GB31228@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ba93f2c-5519-367a-2f21-b4b6d2292579@amsat.org>
Date: Wed, 11 Jul 2018 10:34:54 -0300
MIME-Version: 1.0
In-Reply-To: <20180711123612.GB31228@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="mvYGaFrRwomIQsfQz6JoJwQq5yhXrwkG8"
Subject: Re: [Qemu-devel] [BUG] checkpatch.pl hangs on
 target/mips/msa_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mvYGaFrRwomIQsfQz6JoJwQq5yhXrwkG8
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Message-ID: <9ba93f2c-5519-367a-2f21-b4b6d2292579@amsat.org>
Subject: Re: [Qemu-devel] [BUG] checkpatch.pl hangs on
 target/mips/msa_helper.c
References: <BN7PR08MB4868C0F99A12534DE079C256C6410@BN7PR08MB4868.namprd08.prod.outlook.com>
 <20180711123612.GB31228@stefanha-x1.localdomain>
In-Reply-To: <20180711123612.GB31228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/11/2018 09:36 AM, Stefan Hajnoczi wrote:
> On Wed, Jul 04, 2018 at 03:35:18PM +0000, Aleksandar Markovic wrote:
>> If  checkpatch.pl is applied (using switch "-f") on file target/mips/m=
sa_helper.c, it will hang.
>>
>> There is a workaround for this particular file:
>>
>> These lines in msa_helper.c:
>>
>>         uint## BITS ##_t S =3D _S, T =3D _T;                          =
  \
>>         uint## BITS ##_t as, at, xs, xt, xd;                        \
>>
>> should be replaced with:
>>
>>         uint## BITS ## _t S =3D _S, T =3D _T;                         =
  \
>>         uint## BITS ## _t as, at, xs, xt, xd;                       \
>>
>> (a space is added after the second "##" in each line)
>>
>> The workaround is found by partial deleting and undeleting of the code=
 in msa_helper.c in binary search fashion.
>>
>> This workaround will soon be submitted by me as a patch within a serie=
s on misc MIPS issues.
>>
>> I took a look at checkpatch.pl code, and it looks it is fairly complic=
ated to fix the issue, since it happens in the code segment involving int=
ricate logic conditions.
>=20
> Thanks for figuring this out, Aleksandar.  Not sure if anyone else has
> the apetite to fix checkpatch.pl.

Anyone else but Paolo ;P

http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01250.html


--mvYGaFrRwomIQsfQz6JoJwQq5yhXrwkG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAltGB38ACgkQ4+MsLN6t
wN4byhAAvbvkkeO5iYCTTOrNo+DLt3sV62O/ETwRpJyQC8FXvTMFPBblfXQOnDoC
/xmcVMvlQkbY/bkoM+U1buK1WvJY2cAhzEZvWctsKCfYBkbxb5IyXlh9PCDWKOB8
z3QLiWYjkbrAd4XdcFDqBvTht2nlY53oQHimYhRSz/1gG5xYlvQfRrnTForbXeMe
MrveiWU3xRIdDLeweUx0gcv1AGnH1NvJkKnjQvg0JyGxB9v3QhNaD78Ynj9ZkE7g
JEpF+brDhQ3IR+Xwtky4m7x9OydOZa/c3usXmPI/ogqisydwtWPePLkf3qXzeti6
urjMb9Q3eBZ9aJSuYKyOrow6fCWIfJoS4sVdfLqA9dss84lOZ8j1cqJk27Hwv5tL
Wnfc4jQeCMre12jq1Y6QWRWPEEZYInafJNuBn4dGCUla5DDq1hwJbTCmQ2KkvLGl
zUqk4aT5WNpcl26ZpvP/bqeYT+vQTPcSqqU7zmw51G0Acj4C/GKkhg79O8bOt8Wk
2NbojmToP1wEZCUJY/9lY+WbF4YQ5eslHuE5fvtW1MV9lXktw1VqUnF4Yl5XBTwh
zVssCJOMBAlmvMb6nr25rwi5EeE8BJNROITybuP5AYBUxWFB9FVO2pFnrZEhb7TD
RXCD8cE7Pj6VgcBD2Iez9fd3vRXZdpgdcVbrwLUFTcfHBunt0Yo=
=3zQw
-----END PGP SIGNATURE-----

--mvYGaFrRwomIQsfQz6JoJwQq5yhXrwkG8--
