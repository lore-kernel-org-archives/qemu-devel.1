Received: from eggs.gnu.org ([2001:4830:134:3::10]:38392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fXkCu-0006I9-1z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fXkCt-0002TO-9s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:24:16 -0400
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<d3c05355-4eda-f501-8f04-d808f416393a@web.de>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <3c8fa899-e420-15a0-a2af-8d92ca390a85@greensocs.com>
Date: Tue, 26 Jun 2018 11:24:00 +0200
MIME-Version: 1.0
In-Reply-To: <d3c05355-4eda-f501-8f04-d808f416393a@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zKodnuYuSGrEwEQDM9SmVJ0VPRCh8jBds"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] arm_gic: add virtualization
 extensions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zKodnuYuSGrEwEQDM9SmVJ0VPRCh8jBds
From: Luc Michel <luc.michel@greensocs.com>
To: Jan Kiszka <jan.kiszka@web.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com
Message-ID: <3c8fa899-e420-15a0-a2af-8d92ca390a85@greensocs.com>
Subject: Re: [PATCH v2 0/7] arm_gic: add virtualization extensions support
References: <20180619093124.24011-1-luc.michel@greensocs.com>
 <d3c05355-4eda-f501-8f04-d808f416393a@web.de>
In-Reply-To: <d3c05355-4eda-f501-8f04-d808f416393a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/25/2018 06:55 AM, Jan Kiszka wrote:
> On 2018-06-19 11:31, luc.michel@greensocs.com wrote:
>> From: Luc MICHEL <luc.michel@greensocs.com>
>>
>> This patch series add support for the virtualization extensions in the=

>> ARM GICv2 interrupt controller.
>>
>> The first two commits do some refactoring to prepare for the
>> implementation. Commits 3 and 4 are the actual implementation. The las=
t
>> commit updates the ZynqMP implementation to support virtualization.
>=20
> Is it enabled for the virt machine as well? Seems we are missing some
> mapping of GICV and GICH there.
>=20
> And what is the recommended way to get the ZynqMP model running? I've a=

> kernel that works on a ZCU102, but just passing it via -kernel to the
> QEMU model seems insufficient.
Hum, I think it should be enough. This is the way I run my tests with Xen=
:
qemu-system-aarch64 -M xlnx-zcu102,secure=3Don,virtualization=3Don \
                    -m 1024 \
                    -kernel xen-kernel -nographic -smp 1

--=20
Luc
>=20
> Jan
>=20


--zKodnuYuSGrEwEQDM9SmVJ0VPRCh8jBds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlsyBjAACgkQd8knW3Qn
Tr6e4Q//XoMOFLjSiLpUI9Ley1wkFmrakm/0EOG0aBE4rZheJy1EXpQc5AX3eAiG
s4oA2Cw6gwaSgGpKqLf3VUOA9/u0lfNSquJrQlEGhYKbZqQuxGfxn9cGpMDWQdmQ
pTXMoVHM6CuZSdLF77GYVYYg4X+kMBpVTkaE1qjNuCYccennAeg9RNlX8tUH1byR
uRdNJACJjz9hCDPhtEVYoh4t7NOYprV+dax1WBBrolTgTtXSArL6WSRJTgRA5Xy3
kEDd+L7iG9chK1PA959L2gCLSCFK21xhj/JAT4TjNvODcrJbHb4DYo8HG5i10Vsy
hhpwVo1JI+869EpnMb4FmjvKDVY1lcItAc1VPabzJiiD9qD6zv1BdcMV9ffgWgMa
wpq6yfuEZvxpRASHhDm9h2YQuel6jZ0PHyXLg7PBCp+akyx/zYZheHsXkAWNa9fm
43cAyIwpFKxuLO12SGO6R7yyy0CJfCRjkEZKzLShM6y5d2KNGdAbCMeBwZkhDRAv
dB08LtkO9XbSbHxBFJoBJvkDT1Vx6gY9NPwZzEn39iFzrQZfOwDiaudsBPjuJyXl
rY3yjEGJcgtwX1AOZr1ymu3zvQd3R1AOPdqV81mIFsBvsobMQmbsjhMn3uWcqHku
fMZBN8aqpTkQuOGERc/yGOaZl5rSGR7OP63dRuh6qeqQpJ22qSM=
=dT8Q
-----END PGP SIGNATURE-----

--zKodnuYuSGrEwEQDM9SmVJ0VPRCh8jBds--
