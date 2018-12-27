Received: from eggs.gnu.org ([208.118.235.92]:53316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcbG3-0001z1-5A
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 14:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcbFy-0002oX-U5
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 14:23:51 -0500
Received: from mail-eopbgr710133.outbound.protection.outlook.com
	([40.107.71.133]:15501
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gcbFy-0002n0-JN
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 14:23:46 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 27 Dec 2018 19:23:25 +0000
Message-ID: <BN6PR2201MB12515E6A3326FD0F6A769E06C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
	<20181217200444.14812-2-aleksandar.markovic@rt-rk.com>
	<48756599-1566-8b46-b742-40cea97bce15@wavecomp.com>,
	<32edc91d04374cfd8fb50bc26c9bd320@EX13D12UEA003.ant.amazon.com>
	<BN6PR2201MB1251B2C0C45E6E2BE91E60EEC6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<8a875112d29047afbf2d5f83a96d6230@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <8a875112d29047afbf2d5f83a96d6230@EX13D12UEA003.ant.amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/6] target/mips: MXU: Add missing
 opcodes/decoding for LX* instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Janeczek, Craig" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Janeczek, Craig <jancraig@amazon.com>
> Sent: Thursday, December 27, 2018 7:50 PM
> To: Aleksandar Markovic; Stefan Markovic; Aleksandar Markovic; qemu-devel=
@nongnu.org
> Subject: RE: [PATCH 1/6] target/mips: MXU: Add missing opcodes/decoding f=
or LX* instructions
>=20
> Yes built a binary testing these instructions and ran it against HW along=
 with a qemu binary with your > patches. The opcodes align with what I ment=
ioned in the email.
>=20

I truly appreciate your help.

Just to clarify details, beside correcting comments, does this mean that th=
is code segment:

/*
 * MXU pool 16
 */
enum {
    OPC_MXU_D32SARW  =3D 0x00,
    OPC_MXU_S32ALN   =3D 0x01,
    OPC_MXU_S32ALNI  =3D 0x02,
    OPC_MXU_S32NOR   =3D 0x03,
    OPC_MXU_S32AND   =3D 0x04,
    OPC_MXU_S32OR    =3D 0x05,
    OPC_MXU_S32XOR   =3D 0x06,
    OPC_MXU_S32LUI   =3D 0x07,
};

should be corrected to be:

/*
 * MXU pool 16
 */
enum {
    OPC_MXU_D32SARW  =3D 0x00,
    OPC_MXU_S32ALN   =3D 0x01,
    OPC_MXU_S32ALNI  =3D 0x02,
    OPC_MXU_S32LUI   =3D 0x03,
    OPC_MXU_S32NOR   =3D 0x04,
    OPC_MXU_S32AND   =3D 0x05,
    OPC_MXU_S32OR    =3D 0x06,
    OPC_MXU_S32XOR   =3D 0x07,
};

and all things will line up for "pool 16"?

Sincerely,
Aleksandar

> -----Original Message-----
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> Subject: Re: [PATCH 1/6] target/mips: MXU: Add missing opcodes/decoding f=
or LX* instructions
>=20
> > > @@ -1663,12 +1663,21 @@ enum {
> > >    *          =81                               20..18
> > >    *          =86=80 100111 =80 OPC_MXU__POOL16 =80=88=80 000 =80 OPC=
_MXU_D32SARW
> > >    *          =81                            =86=80 001 =80 OPC_MXU_S=
32ALN
> > > - *          =86=80 101000 =80 OPC_MXU_LXB      =86=80 010 =80 OPC_MX=
U_S32ALNI
> > > - *          =86=80 101001 =80 <not assigned>   =86=80 011 =80 OPC_MX=
U_S32NOR
> > > - *          =86=80 101010 =80 OPC_MXU_S16LDD   =86=80 100 =80 OPC_MX=
U_S32AND
> > > - *          =86=80 101011 =80 OPC_MXU_S16STD   =86=80 101 =80 OPC_MX=
U_S32OR
> > > - *          =86=80 101100 =80 OPC_MXU_S16LDI   =86=80 110 =80 OPC_MX=
U_S32XOR
> > > - *          =86=80 101101 =80 OPC_MXU_S16SDI   =84=80 111 =80 OPC_MX=
U_S32LUI
> > > + *          =81                            =86=80 010 =80 OPC_MXU_S3=
2ALNI
> > > + *          =81                            =86=80 011 =80 OPC_MXU_S3=
2NOR
> > > + *          =81                            =86=80 100 =80 OPC_MXU_S3=
2AND
> > > + *          =81                            =86=80 101 =80 OPC_MXU_S3=
2OR
> > > + *          =81                            =86=80 110 =80 OPC_MXU_S3=
2XOR
> > > + *          =81                            =84=80 111 =80 OPC_MXU_S3=
2LUI
> > The opcodes for pool 16 do not look correct. I think the minor bits sho=
uld look like the following.
> >
> > =88=80 000 =80 OPC_MXU_D32SARW
> > =86=80 001 =80 OPC_MXU_S32ALN
> > =86=80 010 =80 OPC_MXU_S32ALNI
> > =86=80 011 =80 OPC_MXU_S32LUI
> > =86=80 100 =80 OPC_MXU_S32NOR
> > =86=80 101 =80 OPC_MXU_S32AND
> > =86=80 110 =80 OPC_MXU_S32OR
> > =84=80 111 =80 OPC_MXU_S32XOR
> >
>=20
> Hi, Craig!
>=20
> My primary source for opcodes was the latest Ingenic documentation, from =
Ingenic's site: (dated June > 2017)
>=20
> ftp://ftp.ingenic.com/SOC/M200/X1000_M200_XBurst_ISA_MXU_PM.pdf
>=20
> and on page 109 there is a table in the middle of the page that contains =
codes that are in agreement > with what is currently in QEMU.
>=20
> However, I searched more, and in a repository that seems to be derived fr=
om Android NDK r9d binutils > tree, in file
>=20
> https://github.com/apportable/binutils/blob/master/opcodes/mxu-opc.c
>=20
> opcodes are as you said.
>=20
> I guess the definitive answer would be to involve tests on hardware, no?
>=20
> Thanks for bringing this up!
>=20
> Aleksandar
>=20
>=20
> > > + *          =81
> > > + *          =81                               7..5
> > > + *          =86=80 101000 =80 OPC_MXU__POOL17 =80=88=80 000 =80 OPC_=
MXU_LXB
> > > + *          =81                            =86=80 001 =80 OPC_MXU_LX=
H
> > > + *          =86=80 101001 =80 <not assigned>   =86=80 011 =80 OPC_MX=
U_LXW
> > > + *          =86=80 101010 =80 OPC_MXU_S16LDD   =86=80 100 =80 OPC_MX=
U_LXBU
> > > + *          =86=80 101011 =80 OPC_MXU_S16STD   =84=80 101 =80 OPC_MX=
U_LXHU
> > > + *          =86=80 101100 =80 OPC_MXU_S16LDI
> > > + *          =86=80 101101 =80 OPC_MXU_S16SDI
> > >    *          =86=80 101110 =80 OPC_MXU_S32M2I
> > >    *          =86=80 101111 =80 OPC_MXU_S32I2M
> > >    *          =86=80 110000 =80 OPC_MXU_D32SLL
