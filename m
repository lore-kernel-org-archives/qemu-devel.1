Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B21C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 13:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C74720644
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="MbL+Hhix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C74720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htBUm-0005sR-H1
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 09:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1htBUH-0005MG-T4
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 09:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1htBUG-00020z-Ld
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 09:51:21 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:46356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1htBUD-0001w2-KT; Thu, 01 Aug 2019 09:51:18 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A0E7B96F50;
 Thu,  1 Aug 2019 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564667475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DEY8Rq+H+80IURsrwtuyl95l1hjeRxfSQ9fPSXIGQ0=;
 b=MbL+HhixyGVY66PEDOh9Ui1c8Hd95r10CRTx9Rvks3hJaUlbBBHPYjDvNw5vPS0VYr+Gvi
 F5AtCt9MHmr7FBU96fwaO6aof62Wha7wUSRWmFv6HXLxtr43n0fS6SZ44EqFTjty9zSOKJ
 trAtW01BcZ7PpL7up2uqLTodlLQqYbs=
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <6ea54e80-63cd-5759-337b-1eb1686453f5@greensocs.com>
 <e979936e-3545-87fb-eec6-e3a098785113@redhat.com>
 <CAP+75-XzR9bQAm6KVdF=QZ4Bs9yWw-OLt6cRXNM=j8d0BjSZmQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <dfbfb8a0-2a85-c62c-1ae8-9ed20cbeee1f@greensocs.com>
Date: Thu, 1 Aug 2019 15:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAP+75-XzR9bQAm6KVdF=QZ4Bs9yWw-OLt6cRXNM=j8d0BjSZmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564667476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DEY8Rq+H+80IURsrwtuyl95l1hjeRxfSQ9fPSXIGQ0=;
 b=dmJ3B4bBRJUOh9p+nARRl94e7hmaaeMaIIBcNvbcACmdLg3kDUNZDe7RDb/lAzJwwDjInj
 OPQLTsx6W+2U/GjWWa4W5l8F7+kPcCla8VDT0BGlKPU8I8VuzcAYmJTqB0aBrHK+XzDrBn
 5SwecNzil7S2qWkTIDPKWZ55Wz1mYW4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564667476; a=rsa-sha256; cv=none;
 b=CKCGaAJ4OItbjmqf7/VG6ipuaeAbQts/aPsTxiS40aJ13DfwBahnnmDVAH1laHJp9pvAPp
 hv4/kFT3RdCsjqLGIc/TUA/6UOcAN+szQ0+AvJh4ntFzYEegHO0UNy2S4OA7kMvG8OGeIZ
 XcQhvjmmh0GkWtSMCQxj1W9i8uS5U3k=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] RFC raspberry pi sd-card reset
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 7/31/19 5:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On Wed, Jul 31, 2019 at 5:43 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>> On 7/31/19 4:21 PM, Damien Hedde wrote:
>>> Concerning the reset on the raspi2/3 machine, I ran into an issue wit=
h
>>> the sd-card.
>>>
>>> Here follows a subset of the qbus/qdev tree of the raspi2&3 machine a=
s
>>> it is initialized:
>>>  + System
>>>    * bcm2835_gpio
>>>      + sd-bus
>>>        * sd-card
>>>    * bcm2835-sdhost
>>>      + bcm2835-sdhost-bus
>>>    * generic-sdhci
>>>      + sdhci-bus
>>>
>>> raspi_init does 2 things:
>>>  + it creates the soc
>>>  + then it explicitly creates the sd-card on the bcm2835_gpio's sd-bu=
s
>>>
>>> As it happens, the reset moves the sd-card on another bus: the
>>> sdhci-bus. More precisely the bcm2835_gpio reset method does it (the
>>> sd-card can be mapped on bcm2835-sdhost-bus or sdhci-bus depending on
>>> bcm2835_gpio registers, reset configuration corresponds to the sdhci-=
bus).
>>>
>>> Reset call order is the following (it follows children-before-parent =
order):
>>>  1 sd-card
>>>  2 sd-bus
>>>  3 bcm2835_gpio -> move the sd-card
>>>  4 bcm2835-sdhost-bus
>>>  5 bcm2835-sdhost
>>>  6 sd-card  (again)
>>>  7 sdhci-bus
>>>  8 generic-sdhci
>>>
>>> In the end, the sd-card is reset twice, which is no big-deal in itsel=
f.
>>
>> The machine cold reset implicitly cold resets the sd-card.
>>
>> IIRC the sd-bus shouldn't (cold/warm)-reset the sd-card.
>>
>> Only SDBusClass::set_inserted() can cold-reset the card.

I agree but it's something we cannot address until the reset propagation
is hard-coded to be qdev/qbus based.

>>
>>> But it only depends on the bcm2835_gpio tree being reset before the
>>> generic-sdhci (probably depends on the machine creation code).
>>>
>>> I checked and it seems this is the only platform where such things
>>> happen during master reset.
>>>
>>> IMO this is a bit hazardous because reset is based on the qdev/qbus
>>> tree (and with the multi-phase I'm working on, even if it still works=
,
>>> it's worse).
>>> I'm not sure what we should do to avoid this (and if there's is
>>> something to be done).
>>>
>>> The easiest solution would be to initialize the platform with the
>>> sd-card at the right initial place (I do not really understand why it=
 is
>>> created in the bcm2835_gpio in the first place since we move it just
>>> after). But it won't solve the issue if a reset is done afterwards.
>>>
>>> Or maybe we could move the sd-card on the proper bus in a machine
>>> reset code so that it's on the right place when we do the sysbus tree
>>> reset just after.
>>>
>>> What do you think ?
>>
>> There is only 1 bus, the SDHCI bus lines are muxed with the GPIO ones.
>>
>> bcm2835-sdhost-bus should not be child of bcm2835-sdhost, the sdbus
>> might be child of bcm2835-peripherals and shared by both sdhost and gp=
io
>> (as a link property?).
>=20
> There is a similar modelling issue with the AUX uart and SPI on this de=
vice.
>=20
>> I tried to do that 2 years ago. I thought I posted the series and Pete=
r
>> rejected it but can't find it, maybe we had an IRC chat. I won't have
>> time until next week to dig for it.

I was thinking of doing a work-around by defining the raspi machine
reset to something like that.

static void raspi_reset(MachineState *machine)
{
    SDBus *sdhci, *sdhost, *sdbus;
    /*
     * anticipate following reset and ensure the sd-card at its
     * end-of-reset place
     */
    sdhci =3D object_resolve_path("/path/to/sdhci");
    sdhost =3D object_resolve_path("/path/to/sdhost");
    sdbus =3D object_resolve_path("/path/to/sdbus");
    sdbus_reparent_card(sdbus, sdhci); // no-op if card is not on sdbus
    sdbus_reparent_card(sdhost, sdhci); //no-op if card is not on sdhost

    /* standard reset */
    qemu_devices_reset();
}

Damien

