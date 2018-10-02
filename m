Received: from eggs.gnu.org ([2001:4830:134:3::10]:45760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mva-0004CW-K7
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7MvU-0007EB-Hn
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:36 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:34770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7MvQ-0007BS-G6
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:29 -0400
Received: from player693.ha.ovh.net (unknown [10.109.146.82])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B9B1ADB2BF
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:49:19 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180921161939.822-1-clg@kaod.org>
	<20180921161939.822-5-clg@kaod.org>
	<CAFEAcA_NmJO1OiE51ypZXek6D-_hqtBX+Gi2=kzEBtZ5fzo_Mg@mail.gmail.com>
Message-ID: <b3cbd561-8c23-8dd1-ff66-9c9f8a3ad4bf@kaod.org>
Date: Tue, 2 Oct 2018 17:49:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NmJO1OiE51ypZXek6D-_hqtBX+Gi2=kzEBtZ5fzo_Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/11] hw/arm/aspeed: add a
 'execute-in-place' property to boot directly from CE0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/2/18 12:49 PM, Peter Maydell wrote:
> On 21 September 2018 at 17:19, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>> The overhead for the OpenBMC firmware images using the a custom U-Boot
>> is around 2 seconds, which is fine, but with a U-Boot from mainline,
>> it takes an extra 50 seconds or so to reach Linux. A quick survey on
>> the number of reads performed on the flash memory region gives the
>> following figures :
>>
>>   OpenBMC U-Boot      922478 (~ 3.5 MBytes)
>>   Mainline U-Boot   20569977 (~ 80  MBytes)
>>
>> QEMU must be trashing the TCG TBs and reloading text very often. Some
>> addresses are read more than 250.000 times. Until we find a solution
>> to improve boot time, execution from MMIO is not activated by default.
>>
>> Setting this option also breaks migration compatibility.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


The DRAM training in mainline u-boot is also significantly slower on=20
real HW. I haven't spotted the exact area but the code is jumping back
and forth.  This patch should help tracking the culprit.
  =20
Thanks,

C.
