Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B41C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB22C222DD
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB22C222DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX49k-0001Gv-SH
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX48n-0000Yf-M9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX48m-0002Wj-Ho
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:06:01 -0500
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:56154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX48m-0002Vt-BE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:06:00 -0500
Received: from player772.ha.ovh.net (unknown [10.109.159.69])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0CF0B21383B
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:05:57 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 6361BC44350D;
 Tue, 19 Nov 2019 14:05:50 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] arm/aspeed: Watchdog and SDRAM fixes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191113221301.8768-1-joel@jms.id.au>
 <CAFEAcA8AL6865u8KaY3HjRH19mTP=JUJ3FAgf9VezJYPOEbmBg@mail.gmail.com>
 <3dbfb0eb-4ecb-35b4-9c8d-dec3fd6f083f@kaod.org>
 <CAFEAcA82Nf=2tEyfgX5=_pi19C7PC8YODX2XCC=NafT6SUP38Q@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7c64292d-26f6-ba1f-3300-e15e0afb6bad@kaod.org>
Date: Tue, 19 Nov 2019 15:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82Nf=2tEyfgX5=_pi19C7PC8YODX2XCC=NafT6SUP38Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 17781618704199027520
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.36.253
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/2019 14:44, Peter Maydell wrote:
> On Thu, 14 Nov 2019 at 14:17, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>> We are preparing, and reviewing, the initial 5.0 patchset
>> which will contain the I2C pool buffer model plus the fixes
>> Joel and I sent.
>=20
> OK. I currently have in my 'maybe I should do something with this'
> list these patchsets:
> aspeed/i2c: Add support for pool and DMA transfer modes
> arm/aspeed: Watchdog and SDRAM fixes
> aspeed: AST2600 SMC fixes and tacoma-bmc machine
> aspeed: rework inter model link properties
>=20
> (I had a quick scan through and there's nothing in any of
> them that looked odd to me, though I haven't done a detailed
> review). Should I just assume that you'll send out a rollup
> patchset with all of those once 5.0 is out ? Alternatively
> I could apply them to the target-arm.for-5.0 branch I'm
> currently keeping, which will become the first target-arm
> pullreq once 5.0 reopens, if you prefer (and if you've
> got on-list reviewed-by tags for them all).

I have a larger list of patches with reviewed-by :=20

C=C3=A9dric Le Goater - aspeed: Change the "nic" property definition
C=C3=A9dric Le Goater - aspeed: Change the "scu" property definition
PanNengyuan - gpio: fix memory leak in aspeed_gpio_init()
C=C3=A9dric Le Goater - aspeed: Add support for the tacoma-bmc board
C=C3=A9dric Le Goater - aspeed: Remove AspeedBoardConfig array and use As=
peedMachineClass
C=C3=A9dric Le Goater - aspeed/smc: Add AST2600 timings registers
C=C3=A9dric Le Goater - aspeed/smc: Do not map disabled segment on the AS=
T2600
C=C3=A9dric Le Goater - aspeed/smc: Restore default AHB window mapping at=
 reset
Joel Stanley - watchdog/aspeed: Fix AST2600 frequency behaviour
Joel Stanley - watchdog/aspeed: Improve watchdog timeout message
Joel Stanley - aspeed/scu: Fix W1C behavior
Joel Stanley - aspeed/sdmc: Make ast2600 default 1G
C=C3=A9dric Le Goater - aspeed/i2c: Add trace events
C=C3=A9dric Le Goater - aspeed/i2c: Add support for DMA transfers
C=C3=A9dric Le Goater - aspeed: Add a DRAM memory region at the SoC level
C=C3=A9dric Le Goater - aspeed/i2c: Check SRAM enablement on AST2500
C=C3=A9dric Le Goater - aspeed/i2c: Add support for pool buffer transfers


Tests run fine on travis.

I will send them this afternoon.

Thanks,
C.=20


