Received: from eggs.gnu.org ([2001:4830:134:3::10]:47804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7N1A-0001YB-JY
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7N15-0001JB-MG
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:55:24 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:51410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7N15-0001Ip-FS
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:55:19 -0400
Received: from player697.ha.ovh.net (unknown [10.109.146.132])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4009C1F60AF
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:55:18 +0200 (CEST)
References: <20180921161939.822-1-clg@kaod.org>
	<20180921161939.822-9-clg@kaod.org>
	<CAFEAcA8W0ixkfje4NSx-+kdw4rNh44JgNTu2OhDD_p91nHK7hw@mail.gmail.com>
	<f18e92fa-7b49-04b6-0adb-4f1a84668168@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ba569f61-6c94-4a22-3f1b-f8ac72499fd7@kaod.org>
Date: Tue, 2 Oct 2018 17:55:09 +0200
MIME-Version: 1.0
In-Reply-To: <f18e92fa-7b49-04b6-0adb-4f1a84668168@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/11] aspeed/smc: add support for DMAs
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

With the links,

[ ... ]

>> Otherwise, patch looks good, though I don't know enough about
>> the device/SoC to review those details.
> 
> For the moment the only use of these registers is in the Aspeed custom 
> u-boot of the SDK : 

https://github.com/openbmc/u-boot/blob/v2016.07-aspeed-openbmc/arch/arm/mach-aspeed/platform_g5.S#L2314
 
> or in the rewrite I proposed in mainline :

http://patchwork.ozlabs.org/patch/972868/


C.
