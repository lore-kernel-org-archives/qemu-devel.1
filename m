Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD45C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF3F2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="uViZi+I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF3F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PHK-0007Q3-SL
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i8PEJ-0006Rk-Jh
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i8PEH-0004LB-N5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:33:47 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:37286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i8PEC-0004G6-UY; Thu, 12 Sep 2019 09:33:41 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id BD6DB96F52;
 Thu, 12 Sep 2019 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1568295218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09RLHT4nhLz4EnrC+eDZoEnwmDFz+6ZANyFrhbtUzmE=;
 b=uViZi+I/YKDMTmkhTZhjLjQdRrYLsLe9sdqYZpJqt2K8eGUJ/BgkUIoNHGBLBQwqLFjkZm
 EZPUhesvCsEjHeU1bv0ST5TykZnXNJUD5OZ7dgnomu6Ybod3Vbassf6NNdisAJWe74oX4U
 mtP8qi3qJxn5/fYdPEagC8jAX+NfpbM=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190904162247.24095-1-damien.hedde@greensocs.com>
 <CAFEAcA89q8mwNyhivbrCcTP7c208dbwmVBjF2mmOT5s+dyQ4sQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <4b100cde-d739-8cf5-4732-0a53d213a623@greensocs.com>
Date: Thu, 12 Sep 2019 15:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89q8mwNyhivbrCcTP7c208dbwmVBjF2mmOT5s+dyQ4sQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1568295218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09RLHT4nhLz4EnrC+eDZoEnwmDFz+6ZANyFrhbtUzmE=;
 b=438SRY3abflE84JlDFpp61irAYQFkFZT8zTE4ccWaY6Hdi+hzCfjpei+FtTXHQXihTDnQC
 E5f1tY+AQKgv/NTXrFH9v6JAi2TMAp+TpDJWvzsDkcrfiloANzBtxGc3TzjuUgJd0VYbnx
 iSk50nl0GRCHEv3UGrIh5znhd6elxY4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1568295218; a=rsa-sha256; cv=none;
 b=FV5FZjVOWga01pC64HveS8E6NxtaAUaMyp8Aq4BpotfMleSD7s0F5G8CnUEi3jEYML/cHs
 Ac917gThhLhBv40bu7jFd7MTZJb1GUQEJkOa9XXEKSn8SQaqXHxpb4GKTAwGJ5+euFeLhG
 35ztb3pUNuTmD7u4Vw3Ity43TDJaZBw=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH] hw/arm/raspi: avoid reparenting the sd
 card during qbus tree reset
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/6/19 12:36 PM, Peter Maydell wrote:
> On Wed, 4 Sep 2019 at 17:23, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> In the raspi machine, the sd card can be on several sd bus (in reality
>> there is one bus but several controllers). It is initially created in
>> the "sd-bus" child in the gpio peripheral. Then is moved (parent bus
>> changes) during machine reset in the "sdhci-bus". It can be moved again
>> by software between the "sdhci-bus" and another bus ("bcm2835-sdhost-bus").
>> Here's the corresponding qbus tree of the raspi machine:
>>  + sysbus
>>    * bcm2835_gpio
>>      + sd-bus
>>        * sd-card
>>    * bcm2835-sdhost
>>      + bcm2835-sdhost-bus
>>    * generic-sdhci
>>      + sdhci-bus
>>
>> During the initial machine reset, the sd card is moved. Since reset is
>> based on qbus tree, moving the card during the reset seems odd (it changes
>> the qbus tree). In this case, because of the order the qbus tree is
>> walked, the sd card ends up being reset twice; the effective reset order call
>> follows:
>>  1 sd-card
>>  2 sd-bus
>>  3 bcm2835_gpio        -> move the sd-card to sdhci_bus
>>  4 bcm2835-sdhost-bus
>>  5 bcm2835-sdhost
>>  6 sd-card             (again)
>>  7 sdhci-bus
>>  8 generic-sdhci
>>
>> This patch adds a raspi machine reset method which moves the sd card
>> to the sdhci-bus before doing the whole reset (which will try to do the
>> move too). By anticipating the move we avoid changing the qdev tree while
>> resetting it.
>>
>> In consequence the step 1 is skipped in the previous list: when reset starts
>> the sd-card is already not a child of bcm2835_gpio.
> 
> The solution proposed in this patch pushes something that should
> really be the business just of the SoC model out to the machine
> model level; it would be nice to be able to avoid that.

The problem is sysbus is the only common "reset" ancestor of all
sd-card-buses. So we don't really have a lot of places to do this.

I could move the proposed code to the reset method of
bcm2835_peripherals which creates the bcm3825_gpio, bcm2835-sdhost and
generic-sdhci so we don't have to seek these.
It will works because the reset of bcm2835_peripherals is called before
the others.
But in terms of reset/qdev hiearchy, the 'bcm2835_peripherals' it at the
same level of bcm2835_gpio.

The reset order would be:

1 bcm2835_peripherals -> move the sd-card to sdhci_bus.
2   sd-bus
3 bcm2835_gpio
4   bcm2835-sdhost-bus
5 bcm2835-sdhost
6     sd-card
7   sdhci-bus
8 generic-sdhci

Would that be an acceptable solution ?

--
Thanks
Damien

