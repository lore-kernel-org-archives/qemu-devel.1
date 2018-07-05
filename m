Received: from eggs.gnu.org ([2001:4830:134:3::10]:42518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fb3xe-0007FL-LS
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fb3xa-0001LM-MJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:06:14 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fb3xa-0001Bz-Bq
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:06:10 -0400
References: <cover.1530395710.git.jcd@tribudubois.net>
	<CAFEAcA8OPpt1ZVc7ryzeK6W=t+Prc-J3KYXqPpS5rdBJxs+zZg@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <44416ec7-bd4b-2f96-610a-c92ddf53a54d@tribudubois.net>
Date: Thu, 5 Jul 2018 15:06:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OPpt1ZVc7ryzeK6W=t+Prc-J3KYXqPpS5rdBJxs+zZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/3] i.MX: Add the i.MX6UL SOC and a
 reference board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Andrey Smirnov <andrew.smirnov@gmail.com>

Le 01/07/2018 à 12:44, Peter Maydell a écrit :
> On 30 June 2018 at 22:57, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>> This series adds the i.MX6UL SOC from NXP/Freescale and the reference
>> evaluation board.
>>
>> This series as tested by booting linux 4.18 (built using imx_v6_v7_defconfig)
>> on the emulated board (with the appropriate device tree).
>>
>> Jean-Christophe Dubois (3):
>>    i.MX6UL: Add i.MX6UL specific CCM device
>>    i.MX6UL: Add i.MX6UL SOC
>>    i.MX6UL: Add Freescale i.MX6 UltraLite 14x14 EVK Board
> Hi; thanks for this patchset. I've put it on my to-review queue,
> but since it's too late to get in for softfreeze for 3.0 I'm
> planning to prioritize release-related work so it may take
> me a little while to get back to it.
>
> thanks
> -- PMM
>
OK, take your time.

Also for the record, I believe the Qemu FEC/ENET device doesn't work 
with linux 4.18 on the i.MX6Q/DL sabrelite emulation.

JC
