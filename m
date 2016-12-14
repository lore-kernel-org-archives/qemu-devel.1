Received: from eggs.gnu.org ([2001:4830:134:3::10]:45523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cHDip-0000Oy-Ps
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cHDij-0004qZ-Tx
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:52:07 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:49982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cHDij-0004qH-Ne
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:52:01 -0500
Received: from player793.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 5409A9EFB
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 18:51:58 +0100 (CET)
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<CAFEAcA96OTfgO9agwKT10XHAPLA1cfme7syA0wTAu5t=zKgyHQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2220d05d-a814-c5a0-2297-ea57e8cd8566@kaod.org>
Date: Wed, 14 Dec 2016 18:51:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA96OTfgO9agwKT10XHAPLA1cfme7syA0wTAu5t=zKgyHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/30] Aspeed SoC fixes and model
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 12/14/2016 06:12 PM, Peter Maydell wrote:
> On 29 November 2016 at 15:43, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>> Here is a collection of fixes and improvements on existing models for
>> the Aspeed SoCs
>=20
> I have taken into target-arm.next for 2.9 patches 2-13:
>=20
>>   m25p80: add support for the mx66l1g45g
>>   aspeed: QOMify the CPU object and attach it to the SoC
>>   aspeed: remove cannot_destroy_with_object_finalize_yet
>>   aspeed: attach the second SPI controller object to the SoC
>>   aspeed: extend the board configuration with flash models
>>   aspeed: add support for the romulus-bmc board
>>   aspeed: add a memory region for SRAM
>>   aspeed: add the definitions for the AST2400 A1 SoC
>>   aspeed: change SoC revision of the palmetto-bmc machine
>>   aspeed/scu: fix SCU region size
>>   aspeed/smc: improve segment register support
>>   aspeed/smc: set the number of flash modules for the FMC controller
>=20
> which should at least reduce the size of this patchset for the
> next round.

Thanks a lot, I was going to ask you that :)=20

I think I can simplify easily the vbar patch with the input
you just gave. I lost my way with the EL3 I guess.

The model option to the drive should be just dropped. However,=20
using -drive / -device to define the flash modules on the command=20
line introduces more changes as we need to take them into=20
account at reset time and not at init time anymore. I need to
think about it.

Marcin had some concerns on the way the patchset handles the=20
command mode modeling of the SMC controller. It can be improved=20
surely but I won't do that right now. So that's a couple of=20
patches for later.

I will take a look at the crash you spotted. Funny that I did
not see that.

The watchdog needs some review. It is nice to have as it gives
Linux reboot.

Alastair has an interesting RTC device we could plug on the=20
palmetto machine. I have a little TMP421 device on the waiting
stack after.

Thanks,


C.
