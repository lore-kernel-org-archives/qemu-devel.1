Received: from eggs.gnu.org ([2001:4830:134:3::10]:35166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhd7t-0004dU-N7
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fhd7q-0006eO-L3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:51:57 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:38834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fhd7q-0006dL-Bo
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:51:54 -0400
Received: from player738.ha.ovh.net (unknown [10.109.146.163])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id BFB5A18B66D
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 17:51:52 +0200 (CEST)
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<ce2458db-7b97-1672-48cf-b88c24d93157@kaod.org>
	<CAFEAcA88a15YJ86bK+3=OMG-2=URAgfXEjFoAx603YpCsw5X2w@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <286bff36-1137-ea8f-077c-270406ef433d@kaod.org>
Date: Mon, 23 Jul 2018 17:51:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88a15YJ86bK+3=OMG-2=URAgfXEjFoAx603YpCsw5X2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] accel/tcg: Support execution from MMIO
 and small MMU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On 07/23/2018 05:17 PM, Peter Maydell wrote:
> On 23 July 2018 at 15:57, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> On 07/10/2018 06:00 PM, Peter Maydell wrote:
>>> Note for the Xilinx folks: this patchset makes the mmio-exec
>>> testcase for running from the SPI flash pass. Cedric: you might
>>> like to test the aspeed image you had that relies on execution
>>> from an MMIO region too.
>>
>> I have added a memory region alias at 0x0 on the memory region where
>> the first flash device is mapped and all aspeed machines, palmetto,
>> romulus, witherspoon booted fine.
>>
>> More or less 4MB of data access is generated and the slowdown is hardl=
y
>> noticeable, around one second on a laptop.
>>
>> I wonder if I should add a bool option to the machine to activate
>> or not the feature ?
>=20
> I would tend to go with "not" -- if we need the feature then
> it's better to run slowly but correctly, and if we don't need
> the feature then it doesn't cost us any speed I think.


I have chosen a brutal activation (for the moment) :

  https://github.com/legoater/qemu/commit/10b08c5e8df385bba342f02fa044091=
6203b6fa8

I will send when your patchset is committed.

Images used for tests are here :=20

  https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3Dromulu=
s/lastSuccessfulBuild/artifact/deploy/images/romulus/flash-romulus

  https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3Dpalmet=
to/lastSuccessfulBuild/artifact/deploy/images/palmetto/flash-palmetto

  https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3Dwither=
spoon/lastSuccessfulBuild/artifact/deploy/images/witherspoon/obmc-phospho=
r-image-witherspoon.ubi.mtd

Thanks,

C.=20
