Received: from eggs.gnu.org ([2001:4830:134:3::10]:42301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ffmRl-0002ou-CD
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ffmRk-000431-J4
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:24:49 -0400
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-15-luc.michel@greensocs.com>
	<CAFEAcA__GVdga=VDuwiVq9XW4gBRxMECd2Xm_U8fDzH+aTkzOQ@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <3a34229f-a8c2-344b-2e67-7a3e2f330084@greensocs.com>
Date: Wed, 18 Jul 2018 15:24:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__GVdga=VDuwiVq9XW4gBRxMECd2Xm_U8fDzH+aTkzOQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9hDg4hFnsvnsFAuosku8Q4T5Kcj9IFBoW"
Subject: Re: [Qemu-devel] [PATCH v4 14/20] intc/arm_gic: Wire the vCPU
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9hDg4hFnsvnsFAuosku8Q4T5Kcj9IFBoW
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>
Message-ID: <3a34229f-a8c2-344b-2e67-7a3e2f330084@greensocs.com>
Subject: Re: [PATCH v4 14/20] intc/arm_gic: Wire the vCPU interface
References: <20180714171601.5734-1-luc.michel@greensocs.com>
 <20180714171601.5734-15-luc.michel@greensocs.com>
 <CAFEAcA__GVdga=VDuwiVq9XW4gBRxMECd2Xm_U8fDzH+aTkzOQ@mail.gmail.com>
In-Reply-To: <CAFEAcA__GVdga=VDuwiVq9XW4gBRxMECd2Xm_U8fDzH+aTkzOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2018 04:26 PM, Peter Maydell wrote:
> On 14 July 2018 at 18:15, Luc Michel <luc.michel@greensocs.com> wrote:
>> Add the read/write functions to handle accesses to the vCPU interface.=

>> Those accesses are forwarded to the real CPU interface, with the CPU i=
d
>> being converted to the corresponding vCPU id (vCPU id =3D CPU id +
>> GIC_NCPU).
>>
>> As for the CPU interface, we create a base region for the vCPU interfa=
ce
>> that fetches the current vCPU id using the current_cpu global variable=
, and
>> one mirror region per vCPU which maps to that specific vCPU id. This i=
s
>> required by the GIC architecture specification.
>=20
> Is it? The spec says the GICH registers need to be accessible
> like this, but not the vCPU (GICV) registers...
Sorry, I changed that in the patch but forgot to update the commit
message. I'll fix that.

Luc

>=20
> thanks
> -- PMM
>=20


--9hDg4hFnsvnsFAuosku8Q4T5Kcj9IFBoW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAltPP5gACgkQd8knW3Qn
Tr6XpA//aw5gIGDlGdVwxXv2FylRQQXKikuJ19/rfs5F3YCK3jnAYc2fh2HDkuYY
aI9fq4oFyA/LaapTsfVOI59oAptbt1QfTwZ/PjeyKoIBbAgtsUYb5FIvvuoBcDWn
Dltcvzcf9+LdM8AXxU17gRFFeig1Th1/QEt7QWVePZpP0kTkOGeAnEfwxkuN9UNb
NuT75xUzqBH6Y6G0XV++0A8z0c3PXxAtXeHm28cTdGZEXXPm9FDXkWGRrx8nc4lm
RRPYSVzMDk5B+LBgp53EkOqtLHbvsW6xoSBuh2yIMArmnV7QRyq/37eu7F7l/9Jg
i+3+Ju8BW89KWhPsbPBNnsJWQ9UKcikRq341faIi49KF5ZNs/PT4KECZX4BDQRDp
L8W/3M5nMCk55mxnwMXMOMhayVKUYZMzr9gsdcPGUCbn2D2ER8YsRE+//F8gl3CA
Qs5KLJ/Fn9fQ5jgSgTXgHoNv8DK4UDH07M6ZeOsvCeRp4UwNg/jAUSB0LTO5fTpS
a8q2DY6LXhFUHt1Usexq4zcKr5PPKoF7scPCYqW9U+Jz+uJqLkZtAuUUU2tL2FJL
zcANV9rOr0C3yQsno5zXVqwwmQH0OeTxUik4d1rDA9dGlSgHH8MSJrpEF6K/7oub
Y/QAmeesB/tMxGvfV5Dsh8Lg7EFOIV/AaWdK3Sfv/nKu1mcTRrM=
=nxvF
-----END PGP SIGNATURE-----

--9hDg4hFnsvnsFAuosku8Q4T5Kcj9IFBoW--
