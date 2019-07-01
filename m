Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA21AC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B261120659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B261120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxO5-0003aN-0p
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44080)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhwWD-0005L3-7j
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhwWB-0001c5-DX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:38:52 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:57377)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhwW6-0001Q3-Hx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:38:49 -0400
Received: from player772.ha.ovh.net (unknown [10.108.42.5])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id EE5A41FA907
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 15:38:23 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 4966F76A2393;
 Mon,  1 Jul 2019 13:38:18 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-11-clg@kaod.org>
 <CAFEAcA_4E7b6qpHEaZaQRQO3TB5BJCLCRJ7jROAr7CeQsJ5wcw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7833b289-52b8-f90f-509d-a81eb7b03164@kaod.org>
Date: Mon, 1 Jul 2019 15:38:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4E7b6qpHEaZaQRQO3TB5BJCLCRJ7jROAr7CeQsJ5wcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 922956451259714475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeigdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.33.73
Subject: Re: [Qemu-devel] [PATCH v2 10/21] aspeed/timer: Provide
 back-pressure information for short periods
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
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/2019 14:59, Peter Maydell wrote:
> On Tue, 18 Jun 2019 at 17:54, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> From: Andrew Jeffery <andrew@aj.id.au>
>>
>> First up: This is not the way the hardware behaves.
>>
>> However, it helps resolve real-world problems with short periods being
>> used under Linux. Commit 4451d3f59f2a ("clocksource/drivers/fttmr010:
>> Fix set_next_event handler") in Linux fixed the timer driver to
>> correctly schedule the next event for the Aspeed controller, and in
>> combination with 5daa8212c08e ("ARM: dts: aspeed: Describe random numb=
er
>> device") Linux will now set a timer with a period as low as 1us.
>>
>> Configuring a qemu timer with such a short period results in spending
>> time handling the interrupt in the model rather than executing guest
>> code, leading to noticeable "sticky" behaviour in the guest.
>>
>> The behaviour of Linux is correct with respect to the hardware, so we
>> need to improve our handling under emulation. The approach chosen is t=
o
>> provide back-pressure information by calculating an acceptable minimum
>> number of ticks to be set on the model. Under Linux an additional read
>> is added in the timer configuration path to detect back-pressure, whic=
h
>> will never occur on hardware. However if back-pressure is observed, th=
e
>> driver alerts the clock event subsystem, which then performs its own
>> next event dilation via a config option - d1748302f70b ("clockevents:
>> Make minimum delay adjustments configurable")
>>
>> A minimum period of 5us was experimentally determined on a Lenovo
>> T480s, which I've increased to 20us for "safety".
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
>> --- a/hw/misc/aspeed_scu.c
>> +++ b/hw/misc/aspeed_scu.c
>> @@ -423,6 +423,12 @@ static void aspeed_scu_realize(DeviceState *dev, =
Error **errp)
>>                            TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
>>
>>      sysbus_init_mmio(sbd, &s->iomem);
>> +
>> +    /*
>> +     * Reset on realize to ensure the APB clock value is calculated i=
n time for
>> +     * use by the timer model, which is reset before the SCU.
>> +     */
>> +    aspeed_scu_reset(dev);
>=20
> This looks wrong. QEMU should always be resetting devices
> after realize and before actually running anything.

Ah yes ... We need to rework SCU with class data to provide a cleaner=20
model for all SoCs. AST2600 will require it anyhow.=20

Thanks,

C.=20
>=20
>>  }
>=20
> thanks
> -- PMM
>=20


