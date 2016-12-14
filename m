Received: from eggs.gnu.org ([2001:4830:134:3::10]:58917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cHCxl-0007Nz-3b
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cHCxg-0006da-3p
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:03:29 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:52568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cHCxf-0006dJ-U3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:03:24 -0500
References: <20161214144713.11009-1-stefanha@redhat.com>
	<22da7375-6a66-0340-4208-b4d04b5ce49f@vivier.eu>
	<CAJSP0QW-zPDGrFoyE3XLd-SNKt261+AJPS5k1jxZyr8jNkvxXA@mail.gmail.com>
	<20161214160827.GA3872@noname.str.redhat.com>
	<3e1011ab-37bf-b244-11e5-9fd8df6678ce@vivier.eu>
	<20161214163142.GB3872@noname.str.redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <5f153b71-3f4c-b03e-9794-6ec2797d292d@weilnetz.de>
Date: Wed, 14 Dec 2016 18:03:16 +0100
MIME-Version: 1.0
In-Reply-To: <20161214163142.GB3872@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.8] po: add missing translations in de, fr, it,
 zh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Pino Toscano <ptoscano@redhat.com>

Am 14.12.2016 um 17:31 schrieb Kevin Wolf:
> Am 14.12.2016 um 17:17 hat Laurent Vivier geschrieben:
>> Le 14/12/2016 =E0 17:08, Kevin Wolf a =E9crit :
>>> Am 14.12.2016 um 16:58 hat Stefan Hajnoczi geschrieben:
>>> IIRC, it's actually a known problem with not consistently using a UTF=
-8
>>> locale, and we avoid changing some locale categories because that wou=
ld
>>> break things like floating point representation in JSON (because prin=
tf
>>> might end up using comma as the decimal separator).
>>
>> So the translation like the Chinese one is totally unusable?
>=20
> I just tried it:
>=20
> $ LANG=3Dzh_CN x86_64-softmmu/qemu-system-x86_64
>=20
> And yes, lots of question marks there...
>=20
> Kevin

It's good to know that there remains some work to be done after 2.8. :-)
This is not a regression, so IMHO the status quo is good enough for now.

Stefan
