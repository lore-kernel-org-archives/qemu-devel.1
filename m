Received: from eggs.gnu.org ([2001:4830:134:3::10]:59316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQCFt-0007J4-W3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQCFq-00027R-3I
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:10 -0400
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:38729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQCFp-00026r-Se
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:06 -0400
Received: from player732.ha.ovh.net (unknown [10.109.120.11])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 35BC2161373
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 15:44:04 +0200 (CEST)
References: <20180530075002.4618-1-clg@kaod.org>
	<CAFEAcA_a+nduAKWhLiwoKvoybL+cKN=51xV5M9f-VatPdbnf6w@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e4840353-abf9-868f-20f1-3f07d13b84c8@kaod.org>
Date: Tue, 5 Jun 2018 15:43:57 +0200
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

Could we still take patch 1-2 which are good model cleanups
for the flash controller ?=20

Thanks,

C.=20
