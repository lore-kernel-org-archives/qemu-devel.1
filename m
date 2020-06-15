Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41406C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3AD206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3AD206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkv3i-0004cQ-BI
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jkv2g-0003bt-Fn; Mon, 15 Jun 2020 15:45:14 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jkv2c-0007JX-J8; Mon, 15 Jun 2020 15:45:13 -0400
X-Originating-IP: 82.252.130.88
Received: from [192.168.1.155] (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2F62A60002;
 Mon, 15 Jun 2020 19:45:00 +0000 (UTC)
Subject: Re: [PATCH v5 2/3] hw/net/imx_fec: Allow phy not to be the first
 device on the mii bus.
To: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1591272275.git.jcd@tribudubois.net>
 <a6223b7b5c1564afc5fb3c2a9ad514bdb41be5a5.1591272275.git.jcd@tribudubois.net>
 <CAFEAcA_b0k4m29NqU82GC2xvjQXTVkYWQei8hrG2fxjQAcgc0g@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <53c48a6c-340c-d688-e935-c74ac519af84@tribudubois.net>
Date: Mon, 15 Jun 2020 21:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_b0k4m29NqU82GC2xvjQXTVkYWQei8hrG2fxjQAcgc0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=217.70.183.195; envelope-from=jcd@tribudubois.net;
 helo=relay3-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:45:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/06/2020 à 14:23, Peter Maydell a écrit :
> On Thu, 4 Jun 2020 at 13:39, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>> Up to now we were allowing only one PHY device and it had to be the
>> first device on the bus.
>>
>> The i.MX6UL has 2 Ethernet devices and can therefore have several
>> PHY devices on the bus (and not necessarilly as device 0).
>>
>> This patch allows for PHY devices on 2nd, 3rd or any position.
>>
>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
>> index eefedc252de..29e613699ee 100644
>> --- a/hw/net/imx_fec.c
>> +++ b/hw/net/imx_fec.c
>> @@ -280,11 +280,9 @@ static void imx_phy_reset(IMXFECState *s)
>>   static uint32_t imx_phy_read(IMXFECState *s, int reg)
>>   {
>>       uint32_t val;
>> +    uint32_t phy = reg / 32;
>>
>> -    if (reg > 31) {
>> -        /* we only advertise one phy */
>> -        return 0;
>> -    }
>> +    reg %= 32;
> This change means we now support multiple PHYs...

Yes, on the i.MX6UL there are 2 ENET devices but only one MDIO bus to 
acess the PHYs.

On the i.MX6UL evaluation board, PHY seems to be at offset/adress 1 and 2.

See linux/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi for details.

>
>>       switch (reg) {
>>       case 0:     /* Basic Control */
>> @@ -331,19 +329,18 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
>>           break;
>>       }
>>
>> -    trace_imx_phy_read(val, reg);
>> +    trace_imx_phy_read(val, phy, reg);
> ...but the only change we actually make is to trace the phy number.
> Surely if there is more than one phy then each phy needs to have
> its own state (phy_control/phy_status/phy_advertise/etc), rather
> than all these PHYs all sharing the same state under the hood?

Well there might be several PHYs on the MDIO bus but each PHY is used 
only by one ENET device. There is no plan for one ENET to use either 
PHY. It can only use one.

In Qemu (or at least in the FEC ethernet device emulator) the phy state 
is embedded in the ethernet device state.

>
> It also sounds from your commit message as if there isn't a
> large number of PHYs, but only perhaps two. In that case
> don't we need to fail attempts to access non-existent PHYs
> and only work with the ones which actually exist on any
> given board?

As stated on the particular i.MX6UL evaluation board there are 2 phys 
connected to the MDIO bus at adresse 1 and 2.

On another board the PHYs could be at different addresses or we might 
use only one MAC and therefore only one PHY.

So in order to be able to fail on bad PHY access we need to discriminate 
for each board which PHYs are actually present and at what address on 
the MDIO bus. We would also need to know which PHY is connected to which 
MAC.

I might have overlook something but so far there is no clear separate 
PHY and MAC implementation.

Usually the PHY is more or less part of the MAC implementation and there 
are no easy way to instantiate them separately then connect them with 
the required bus (MDIO and MAC).

I guess it might be feasible even if it sounds like overkill most of the 
time (you usually get one MAC connected to one PHY).

Is there such a qemu framework that would allow to connect multiple PHY 
to a single MDIO bus and then each PHY to a specific MAC device? Could 
you point me in the right direction ?

>
> thanks
> -- PMM



