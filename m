Received: from eggs.gnu.org ([2001:4830:134:3::10]:39178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fO0VW-0007X1-FM
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fO0VT-0008Jc-ER
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:47:14 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fO0VT-0008Ir-6w
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:47:11 -0400
Received: from player734.ha.ovh.net (unknown [10.109.105.93])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 2C328100A2D
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:47:09 +0200 (CEST)
References: <20180530075002.4618-1-clg@kaod.org>
	<CAFEAcA_a+nduAKWhLiwoKvoybL+cKN=51xV5M9f-VatPdbnf6w@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ffdef472-0cd0-25f1-9972-47a96e159766@kaod.org>
Date: Wed, 30 May 2018 14:47:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_a+nduAKWhLiwoKvoybL+cKN=51xV5M9f-VatPdbnf6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] aspeed: add MMIO exec support to the
 FMC controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>

On 05/30/2018 02:40 PM, Peter Maydell wrote:
> On 30 May 2018 at 08:49, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> Hello,
>>
>> When MMIO execution support is active, these changes let the Aspeed
>> SoC machine boot directly from CE0. As there is still some
>> issues, the feature is disabled by default and should be activated
>> with :
>>
>>         -global driver=3Daspeed.smc,property=3Dmmio-exec,value=3Dtrue
>=20
> I'd really rather not add another mmio-exec device until
> we've sorted out making it actually work properly...

OK. I will keep it for later. The FW of the witherspoon machine is=20
a very good mmio-exec torture test.=20

Thanks,

C.=20
