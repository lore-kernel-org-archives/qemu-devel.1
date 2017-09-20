Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duYvG-0000xJ-RE
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duYvC-0002MA-7A
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:55:50 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:43592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duYvB-0002Kq-Pd
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:55:46 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5CFBFAC957
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 08:55:44 +0200 (CEST)
References: <20170919112645.8574-1-clg@kaod.org>
	<20170919112645.8574-5-clg@kaod.org>
	<3bb3924d-a7c9-26b3-50a2-8a10ef2585e5@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ad7f410e-2eff-278e-a767-2a6600e1601e@kaod.org>
Date: Wed, 20 Sep 2017 08:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <3bb3924d-a7c9-26b3-50a2-8a10ef2585e5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/5] misc: add pca9552 LED
 blinker model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>

On 09/19/2017 03:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 09/19/2017 08:26 AM, C=C3=A9dric Le Goater wrote:
>> Specs are available here :
>>
>> =C2=A0=C2=A0 https://www.nxp.com/docs/en/data-sheet/PCA9552.pdf
>>
>> This is a simple model supporting the basic registers for led and GPIO
>> mode. The device also supports two blinking rates but not the model
>> yet.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>> =C2=A0 default-configs/arm-softmmu.mak |=C2=A0=C2=A0 1 +
>> =C2=A0 hw/misc/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 hw/misc/pca9552.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 212 ++++++++++++++++++++++++++++++=
++++++++++
>> =C2=A0 include/hw/misc/pca9552.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 32 ++++++
>=20
> I'd rather move it to hw/display/

The device is not related to displays. It is just an I2C expander=20
chip. I would leave it under misc/

C.=20

>=20
>> =C2=A0 4 files changed, 246 insertions(+)
>> =C2=A0 create mode 100644 hw/misc/pca9552.c
>> =C2=A0 create mode 100644 include/hw/misc/pca9552.h
