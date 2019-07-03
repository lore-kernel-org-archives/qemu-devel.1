Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE123C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758232189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758232189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibLX-0005VN-GT
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hib1f-00022P-Be
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hib1e-0002ED-16
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:54:03 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:42745)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hib1d-0001NQ-Rl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:54:01 -0400
Received: from player772.ha.ovh.net (unknown [10.108.54.59])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id ADD8766C06
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 10:53:36 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id A610C77E3311;
 Wed,  3 Jul 2019 08:53:29 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-11-clg@kaod.org>
 <CAFEAcA_4E7b6qpHEaZaQRQO3TB5BJCLCRJ7jROAr7CeQsJ5wcw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b88cc8cf-6cf0-6611-28a9-64372eccbeef@kaod.org>
Date: Wed, 3 Jul 2019 10:53:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4E7b6qpHEaZaQRQO3TB5BJCLCRJ7jROAr7CeQsJ5wcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7858781350846237611
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrfedtgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.49.171
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

We have something better for this patch (getting rid of the reset=20
ordering issue). Can we still send you the fix this week ?

Thanks,

C.

