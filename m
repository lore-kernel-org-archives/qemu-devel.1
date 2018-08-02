Received: from eggs.gnu.org ([2001:4830:134:3::10]:48355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fl7UX-00006D-Lr
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fl7UU-0005PS-Ky
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:53:45 -0400
Date: Thu, 2 Aug 2018 07:53:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180802065339.GC13481@stefanha-x1.localdomain>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-8-stefanha@redhat.com>
	<0c2c23f3-5ec9-5446-17ca-683d267d0f4c@amsat.org>
	<6c1020b8.17461.164de2dc109.Coremail.suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <6c1020b8.17461.164de2dc109.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 7/7] Add QTest testcase for
 the Intel Hexadecimal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: philippe =?iso-8859-1?Q?mathieu-daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org, jim@groklearning.com, mail@steffen-goertz.de, ilg@livius.net, alistair@alistair23.me, sundeep.lkml@gmail.com, qemu.ml@steffen-goertz.de, qemu-arm@nongnu.org, joel@jms.id.au, stefanha@redhat.com, jusual@mail.ru


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 28, 2018 at 07:58:17AM +0800, Su Hang wrote:
> > > +#define BIN_SIZE 146
> > > +
> > > +static unsigned char pre_store[BIN_SIZE] =3D {
> > > +    4,   208, 159, 229, 22,  0,   0,   235, 254, 255, 255, 234, 152,=
 16,  1,
> > > +    0,   4,   176, 45,  229, 0,   176, 141, 226, 12,  208, 77,  226,=
 8,   0,
> > > +    11,  229, 6,   0,   0,   234, 8,   48,  27,  229, 0,   32,  211,=
 229, 44,
> > > +    48,  159, 229, 0,   32,  131, 229, 8,   48,  27,  229, 1,   48, =
 131, 226,
> > > +    8,   48,  11,  229, 8,   48,  27,  229, 0,   48,  211, 229, 0,  =
 0,   83,
> > > +    227, 244, 255, 255, 26,  0,   0,   160, 225, 0,   208, 139, 226,=
 4,   176,
> > > +    157, 228, 30,  255, 47,  225, 0,   16,  31,  16,  0,   72,  45, =
 233, 4,
> > > +    176, 141, 226, 8,   0,   159, 229, 230, 255, 255, 235, 0,   0,  =
 160, 225,
> > > +    0,   136, 189, 232, 132, 0,   1,   0,   0,   16,  31,  16,  72, =
 101, 108,
> > > +    108, 111, 32,  119, 111, 114, 108, 100, 33,  10,  0};
> >=20
> > Can this be:
> >=20
> >   0x04, 0xd0, 0x9f, 0xe5,   0x16, 0x00, 0x00, 0xeb,   0xfe, 0xff, 0xff,
> > 0xea,
> >   0x98, 0x10, 0x01, 0x00,   0x04, 0xb0, 0x2d, 0xe5,   0x00, 0xb0, 0x8d,
> > 0xe2,
> >   0x0c, 0xd0, 0x4d, 0xe2,   0x08, 0x00, 0x0b, 0xe5,   0x06, 0x00, 0x00,
> > 0xea,
> >   0x08, 0x30, 0x1b, 0xe5,   0x00, 0x20, 0xd3, 0xe5,   0x2c, 0x30, 0x9f,
> > 0xe5,
> >   0x00, 0x20, 0x83, 0xe5,   0x08, 0x30, 0x1b, 0xe5,   0x01, 0x30, 0x83,
> > 0xe2,
> >   0x08, 0x30, 0x0b, 0xe5,   0x08, 0x30, 0x1b, 0xe5,   0x00, 0x30, 0xd3,
> > 0xe5,
> >   0x00, 0x00, 0x53, 0xe3,   0xf4, 0xff, 0xff, 0x1a,   0x00, 0x00, 0xa0,
> > 0xe1,
> >   0x00, 0xd0, 0x8b, 0xe2,   0x04, 0xb0, 0x9d, 0xe4,   0x1e, 0xff, 0x2f,
> > 0xe1,
> >   0x00, 0x10, 0x1f, 0x10,   0x00, 0x48, 0x2d, 0xe9,   0x04, 0xb0, 0x8d,
> > 0xe2,
> >   0x08, 0x00, 0x9f, 0xe5,   0xe6, 0xff, 0xff, 0xeb,   0x00, 0x00, 0xa0,
> > 0xe1,
> >   0x00, 0x88, 0xbd, 0xe8,   0x84, 0x00, 0x01, 0x00,   0x00, 0x10, 0x1f,
> > 0x10,
> >   'H',  'e',  'l',  'l',    'o',  ' ',  'w',  'o',    'r',  'l',  'd', =
 '!',
> >   '\n', '\0'
> > };
> >=20
> > ?
>=20
> Yes, good suggestion. Your version is clearer and more readable for human=
s.

Okay, I will make the change in v4.

Stefan

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbYqpzAAoJEJykq7OBq3PIucsH/i/6nbBSxRUzHrEqowxUtaIC
SILGnmKDnPlxA26G427khVm8q7YFM3A5C3NZfaw79c8Atf3PlPIpTNUeBT0LlwkE
sldce5/f0wJK6nsH7W8jfozuqWIX5e0PTj01TgD76Qmf12j7e5OCsQ+4fGIwSdml
HQz3/dr714sv5fKP2hUoCEcMFY3A+YywUFuXLkIlF3/D6XnQ4qwD6sryVEdPZtdD
XQBpjwNK0+bzR/nBHtVpAmKh/O6SzSbIb62B7bJgsvvOEu4RgmPbhh6oakuPsGaj
kML5dLwbMBLenUSjWIMgsdGVtmXZWSyH6ChFpl9Xu8Ye3zBiQiiEtqRILouAj4M=
=npAU
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
