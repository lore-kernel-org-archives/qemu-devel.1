Received: from eggs.gnu.org ([208.118.235.92]:46662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcadk-0002SG-Rc
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 13:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcadg-0002on-M3
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 13:44:16 -0500
Received: from mail-eopbgr700093.outbound.protection.outlook.com
	([40.107.70.93]:53020
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gcadg-0002oU-Ge
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 13:44:12 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 27 Dec 2018 18:44:08 +0000
Message-ID: <BN6PR2201MB1251B2C0C45E6E2BE91E60EEC6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
	<20181217200444.14812-2-aleksandar.markovic@rt-rk.com>
	<48756599-1566-8b46-b742-40cea97bce15@wavecomp.com>,
	<32edc91d04374cfd8fb50bc26c9bd320@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <32edc91d04374cfd8fb50bc26c9bd320@EX13D12UEA003.ant.amazon.com>
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

> > @@ -1663,12 +1663,21 @@ enum {
> >    *          =81                               20..18
> >    *          =86=80 100111 =80 OPC_MXU__POOL16 =80=88=80 000 =80 OPC_M=
XU_D32SARW
> >    *          =81                            =86=80 001 =80 OPC_MXU_S32=
ALN
> > - *          =86=80 101000 =80 OPC_MXU_LXB      =86=80 010 =80 OPC_MXU_=
S32ALNI
> > - *          =86=80 101001 =80 <not assigned>   =86=80 011 =80 OPC_MXU_=
S32NOR
> > - *          =86=80 101010 =80 OPC_MXU_S16LDD   =86=80 100 =80 OPC_MXU_=
S32AND
> > - *          =86=80 101011 =80 OPC_MXU_S16STD   =86=80 101 =80 OPC_MXU_=
S32OR
> > - *          =86=80 101100 =80 OPC_MXU_S16LDI   =86=80 110 =80 OPC_MXU_=
S32XOR
> > - *          =86=80 101101 =80 OPC_MXU_S16SDI   =84=80 111 =80 OPC_MXU_=
S32LUI
> > + *          =81                            =86=80 010 =80 OPC_MXU_S32A=
LNI
> > + *          =81                            =86=80 011 =80 OPC_MXU_S32N=
OR
> > + *          =81                            =86=80 100 =80 OPC_MXU_S32A=
ND
> > + *          =81                            =86=80 101 =80 OPC_MXU_S32O=
R
> > + *          =81                            =86=80 110 =80 OPC_MXU_S32X=
OR
> > + *          =81                            =84=80 111 =80 OPC_MXU_S32L=
UI
> The opcodes for pool 16 do not look correct. I think the minor bits shoul=
d look like the following.
>=20
> =88=80 000 =80 OPC_MXU_D32SARW
> =86=80 001 =80 OPC_MXU_S32ALN
> =86=80 010 =80 OPC_MXU_S32ALNI
> =86=80 011 =80 OPC_MXU_S32LUI
> =86=80 100 =80 OPC_MXU_S32NOR
> =86=80 101 =80 OPC_MXU_S32AND
> =86=80 110 =80 OPC_MXU_S32OR
> =84=80 111 =80 OPC_MXU_S32XOR
>=20

Hi, Craig!

My primary source for opcodes was the latest Ingenic documentation, from
Ingenic's site: (dated June 2017)

ftp://ftp.ingenic.com/SOC/M200/X1000_M200_XBurst_ISA_MXU_PM.pdf

and on page 109 there is a table in the middle of the page that contains
codes that are in agreement with what is currently in QEMU.

However, I searched more, and in a repository that seems to be derived from
Android NDK r9d binutils tree, in file

https://github.com/apportable/binutils/blob/master/opcodes/mxu-opc.c

opcodes are as you said.

I guess the definitive answer would be to involve tests on hardware, no?

Thanks for bringing this up!

Aleksandar


> > + *          =81
> > + *          =81                               7..5
> > + *          =86=80 101000 =80 OPC_MXU__POOL17 =80=88=80 000 =80 OPC_MX=
U_LXB
> > + *          =81                            =86=80 001 =80 OPC_MXU_LXH
> > + *          =86=80 101001 =80 <not assigned>   =86=80 011 =80 OPC_MXU_=
LXW
> > + *          =86=80 101010 =80 OPC_MXU_S16LDD   =86=80 100 =80 OPC_MXU_=
LXBU
> > + *          =86=80 101011 =80 OPC_MXU_S16STD   =84=80 101 =80 OPC_MXU_=
LXHU
> > + *          =86=80 101100 =80 OPC_MXU_S16LDI
> > + *          =86=80 101101 =80 OPC_MXU_S16SDI
> >    *          =86=80 101110 =80 OPC_MXU_S32M2I
> >    *          =86=80 101111 =80 OPC_MXU_S32I2M
> >    *          =86=80 110000 =80 OPC_MXU_D32SLL
