Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBBEC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FFC20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FFC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07aw-0001aN-Lq
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1j07aN-00015V-W9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1j07aM-0006Kh-Tt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:38:35 -0500
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:36653)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1j07aM-0006DH-NU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:38:34 -0500
Received: from player779.ha.ovh.net (unknown [10.108.42.174])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 978011AC723
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 18:38:32 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id A648FF1A8494;
 Fri,  7 Feb 2020 17:38:24 +0000 (UTC)
Subject: Re: [PATCH] hw/arm: ast2600: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>
References: <20200207144954.13634-1-linux@roeck-us.net>
 <c0bcd37a-0745-69ec-471f-be54c8e5a54e@kaod.org>
 <20200207170726.GA24635@roeck-us.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6e266552-f6e2-e335-1e78-3b037041f9b4@kaod.org>
Date: Fri, 7 Feb 2020 18:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207170726.GA24635@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11571999244111874880
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrheehgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.96.102
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 6:07 PM, Guenter Roeck wrote:
> On Fri, Feb 07, 2020 at 04:47:09PM +0100, C=C3=A9dric Le Goater wrote:
>> On 2/7/20 3:49 PM, Guenter Roeck wrote:
>>> Initialize EHCI controllers on AST2600 using the existing
>>> TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb
>>> into Linux successfully instantiates a USB interface after
>>> the necessary changes are made to its devicetree files.
>>>
>>> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>>> ehci-platform: EHCI generic platform driver
>>> ehci-platform 1e6a3000.usb: EHCI Host Controller
>>> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus numb=
er 1
>>> ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
>>> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
>>> usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hc=
d
>>> usb 1-1: new high-speed USB device number 2 using ehci-platform
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>  hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>
>>> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
>>> index 931887ac68..a528251c8d 100644
>>> --- a/hw/arm/aspeed_ast2600.c
>>> +++ b/hw/arm/aspeed_ast2600.c
>>> @@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D=
 {
>>>      [ASPEED_FMC]       =3D 0x1E620000,
>>>      [ASPEED_SPI1]      =3D 0x1E630000,
>>>      [ASPEED_SPI2]      =3D 0x1E641000,
>>> +    [ASPEED_EHCI1]     =3D 0x1E6A1000,
>>> +    [ASPEED_EHCI2]     =3D 0x1E6A3000,
>>>      [ASPEED_MII1]      =3D 0x1E650000,
>>>      [ASPEED_MII2]      =3D 0x1E650008,
>>>      [ASPEED_MII3]      =3D 0x1E650010,
>>> @@ -77,6 +79,8 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
>>>      [ASPEED_ADC]       =3D 78,
>>>      [ASPEED_XDMA]      =3D 6,
>>>      [ASPEED_SDHCI]     =3D 43,
>>> +    [ASPEED_EHCI1]     =3D 5,
>>> +    [ASPEED_EHCI2]     =3D 9,
>>
>> There is a conflict here with commit a29e3e127077 ("hw/arm: ast2600: W=
ire=20
>> up the eMMC controller") which is mainline already=20
>>
> Ah, sorry, I had tested this on top of v4.2. Fortunately it is only
> a context conflict. Should I resend ?

yes. keep my S-o-b.

There are a few aspeed changes in 5.0 and some more on the list but all=20
patches apply cleanly. It will Peter's life easier. =20

Thanks,

C.=20

=20

