Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA4FC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E8B20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E8B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04g4-0005VF-22
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1j04ee-00047c-Jq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1j04ed-00006b-1U
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:30:48 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:59354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1j04ec-0008Vu-RZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:30:46 -0500
Received: from player789.ha.ovh.net (unknown [10.110.103.168])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 9DA9D1223F2
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 15:30:44 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 81C40F282A61;
 Fri,  7 Feb 2020 14:30:35 +0000 (UTC)
Subject: Re: [PATCH] hw/arm: ast2400/ast2500: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>
References: <20200206183437.3979-1-linux@roeck-us.net>
 <e9f490fe-34d3-6830-832c-155f6fa63482@kaod.org>
 <1605922b-2aa0-dd8e-720a-031e74bc9872@roeck-us.net>
 <CACPK8XdADQwGnsX=YR0n_zm_WMv532bAmR3O-CfyJ23ytT9bpA@mail.gmail.com>
 <ebcfceea-2f70-7e88-0996-b072ec81f59e@roeck-us.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c4d751a8-1f7e-4adf-c883-c69112185626@kaod.org>
Date: Fri, 7 Feb 2020 15:30:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ebcfceea-2f70-7e88-0996-b072ec81f59e@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 8400339208267205440
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrheehgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehkvghrnhgvlhhtvghsthhsrdhorhhgpdhoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.172
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
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 3:21 PM, Guenter Roeck wrote:
> On 2/7/20 5:09 AM, Joel Stanley wrote:
>> On Fri, 7 Feb 2020 at 12:58, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 2/7/20 12:16 AM, C=C3=A9dric Le Goater wrote:
>>>> On 2/6/20 7:34 PM, Guenter Roeck wrote:
>>>>> Initialize EHCI controllers on AST2400 and AST2500 using the existi=
ng
>>>>> TYPE_PLATFORM_EHCI. After this change, booting ast2500-evb into Lin=
ux
>>>>> successfully instantiates a USB interface.
>>>>>
>>>>> ehci-platform 1e6a3000.usb: EHCI Host Controller
>>>>> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus nu=
mber 1
>>>>> ehci-platform 1e6a3000.usb: irq 21, io mem 0x1e6a3000
>>>>> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
>>>>> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, =
bcdDevice=3D 5.05
>>>>> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumbe=
r=3D1
>>>>> usb usb1: Product: EHCI Host Controller
>>>>
>>>> Cool. Have you tried to plug any devices ?
>>>>
>>>
>>> Yes, booting from USB drive works just fine. I already added it to my
>>> test suite at kerneltests.org.
>>
>> Nice!
>>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>
>>>> This looks good. Could you add the AST2600 also ?
>>>>
>>>
>>> I thought about that, but how would I test it ? None of the ast2600
>>> systems in the Linux kernel enables it. The devicetree include file f=
or
>>> ast2600 doesn't even have an entry for it. I could cook something up,
>>> but that would not reflect real hardware.
>>
>> FYI, there are patches on the linux-aspeed list to enable USB:
>>
>> =C2=A0 https://patchwork.ozlabs.org/project/linux-aspeed/list/?series=3D=
156260
>>
>> They have not yet been merged into the kernel, but I will merge the
>> device tree changes once -rc1 is out.
>>
>=20
> Excellent. With the above series, and after enabling ehci1 for ast2600-=
evb
> and adding the necessary code to qemu, I get
>=20
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-platform: EHCI generic platform driver
> ehci-platform 1e6a3000.usb: EHCI Host Controller
> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number=
 1
> ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
> usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd
>=20
> and I can mount a USB drive. Is that good enough for a follow-up patch,
> or should I wait until the code finds its way into the Linux kernel ?

I don't think we need to wait for Linux to be ready to add support in QEM=
U.

Thanks,
C.=20
=20

