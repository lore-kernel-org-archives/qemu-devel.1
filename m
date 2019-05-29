Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7DAC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 10:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C452070D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 10:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C452070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51291 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVvtV-0002Ji-EE
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 06:33:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVvsd-0001vZ-Ir
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVvsT-0001Lp-Vy
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:32:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVvsS-0001Kr-BY
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:32:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so4020308wmh.0
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 03:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qTS2dk3Ee7pKqxeYjSdQvIkMicG8DfjuNYuqBJf5+KQ=;
	b=DWWO7n3vG+GRAhWacXmIXUu7JPRPbJcf8firlG5KW1QTLpojeyroi7RdQbSo+GZrJ+
	uSIcQaiHs42zNONp3BfpSE+KOa5WWEnzzAf9njksXEHbPK8R8AD98FXLPH+EQPHf3BZA
	1ohPkUjmaPkiqMgiWghU4CDB3l4Lgn1xqMr/jLI6DxbtvaOTkYvr8t5tSlmh4hEvNHhz
	6+6EzLKbUKaFSHsGMJXIEucCiuSjcjn789KSee7GMfC+qX2QqP56nHoYHOhzUNHHIzJp
	seri3SMKOnqLXZlLMbhiKWzHG9vajzzLIVBqonBn5E0ZIKMl1lOmz6pXntaFGbCL6S7e
	Xskg==
X-Gm-Message-State: APjAAAXaDbYvsauIeH8wq9gf2LPRgF+HaksDmF4ePhfXlU5NWc+PKCrP
	cJ3sMznTjfk5R25OZwQ2jRVrmg==
X-Google-Smtp-Source: APXvYqwQtj2XG8tiJpvPVO1i7tiznoLVWjUJ2fITeJU3vYxuE/gTDQ3firSUWT38f01nlWLYlcn5wQ==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr5901888wmc.60.1559125930862;
	Wed, 29 May 2019 03:32:10 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	x6sm23847988wru.36.2019.05.29.03.32.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 03:32:10 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
	<3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
	<016edc53-278e-cc58-0061-d2c5de80afd2@de.ibm.com>
	<1ddf0d83-ce0c-f1c9-065d-ff88ddb9293b@redhat.com>
	<60d1bf3d-659c-d199-6592-d3659702d754@redhat.com>
	<d38b05af-effc-97a1-0b4a-a0d44a13f769@de.ibm.com>
	<CAFEAcA9K+d+LM5SfDrX0Ljwq8zWQdmJAM4R4cdHhF+tM1F13LQ@mail.gmail.com>
	<87v9xw1gi4.fsf@dusky.pond.sub.org>
	<CAFEAcA-eCdmqgM1vSd2Ju4j9mqnrMZ_Knr4oQEsczLM4Wq_Pdw@mail.gmail.com>
	<871s0hiyhq.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <97bf0e0e-3c3c-0d1c-0501-ef78955fd7b3@redhat.com>
Date: Wed, 29 May 2019 12:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <871s0hiyhq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/19 8:08 AM, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Mon, 27 May 2019 at 08:52, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>> Suggestions for how to restructure reset so this doesn't
>>>> happen are welcome... "reset follows the bus hierarchy"
>>>> works well in some places but is a bit weird in others
>>>> (for SoC containers and the like "follow the QOM
>>>> hierarchy" would make more sense, but I have no idea
>>>> how to usefully transition to a model where you could
>>>> say "for these devices, follow QOM tree for reset" or
>>>> what an API for that would look like).
>>>
>>> Here's a QOM composition tree for the ARM virt machine (-nodefaults
>>> -device e1000) as visible in qom-fuse under /machine, with irq and
>>> qemu:memory-region ommitted for brevity:
>>
>> virt is a bit of an outlier because as a purely-virtual
>> machine it has no "SoC" -- it's just a bag of devices
>> at the machine level. It would be interesting to
>> also look at a machine that's emulating something
>> closer to real hardware (eg one of the aspeed machines,
>> or mps2-an521).
> 
> Here you go: witherspoon-bmc (aspeed SoC) with -nodefaults and -device
> m25p80 -device m25p80,id=qdev-id.  The -device are purely for
> illustrating how user-plugged devices get added to the two trees.  I'm
> not claiming they make sense.
> 
> QOM composition tree as visible in qom-fuse under /machine, with irq and
> qemu:memory-region ommitted for brevity:
> 
>     machine  witherspoon-bmc-machine
>       +-- peripheral  container
>       |     +-- qdev-id  m25p80
>       +-- peripheral-anon  container
>       |     +-- device[0]  m25p80
>       +-- soc  ast2500-a1
>       |     +-- cpu  arm1176-arm-cpu
>       |     +-- fmc  aspeed.smc.ast2500-fmc
>       |     |     +-- spi  SSI
>       |     +-- ftgmac100  ftgmac100
>       |     +-- i2c  aspeed.i2c
>       |     |     +-- aspeed.i2c.0  i2c-bus
>       |     |     .
>       |     |     .   more i2c-bus
>       |     |     .
>       |     |     +-- aspeed.i2c.13  i2c-bus
>       |     +-- scu  aspeed.scu
>       |     +-- sdmc  aspeed.sdmc
>       |     +-- spi[0]  aspeed.smc.ast2500-spi1
>       |     |     +-- spi  SSI
>       |     +-- spi[1]  aspeed.smc.ast2500-spi2
>       |     |     +-- spi  SSI
>       |     +-- timerctrl  aspeed.timer
>       |     +-- vic  aspeed.vic
>       |     +-- wdt[0]  aspeed.wdt
>       |     +-- wdt[1]  aspeed.wdt
>       |     +-- wdt[2]  aspeed.wdt
>       +-- unattached  container
>             +-- device[0]  unimplemented-device
>             +-- device[1]  mx25l25635e
>             +-- device[2]  mx25l25635e
>             +-- device[3]  mx66l1g45g
>             +-- device[4]  pca9552
>             +-- device[5]  tmp423
>             +-- device[6]  tmp423
>             +-- device[7]  tmp105
>             +-- device[8]  ds1338
>             +-- device[9]  smbus-eeprom
>             +-- device[10]  pca9552
>             +-- sysbus  System
> 
> Observations (same as for ARM virt, more or less):
> 
> * Where ARM virt had its onboard components as direct children of
>   machine, witherspoon-bmc-machine has them wrapped in soc ast2500-a1.
> 
> * machine additionally has a few containers: peripheral,
>   peripheral-anon, unattached.
> 
> * machine/peripheral and machine/peripheral-anon contain the -device
>   with and without ID, respectively.
> 
> * machine/unattached contains everything else created by code without an
>   explicit parent device.  Some (all?) of them should perhaps be direct
>   children of machine or (unlike ARM virt) soc instead.
> 
> qdev tree shown by info qtree:
> 
>     bus: main-system-bus
>       type System
>       dev: unimplemented-device, id ""
>         size = 2097152 (0x200000)
>         name = "aspeed_soc.io"
>         mmio 000000001e600000/0000000000200000
>       dev: ftgmac100, id ""
>         gpio-out "sysbus-irq" 1
>         aspeed = true
>         mac = "52:54:00:12:34:56"
>         netdev = ""
>         mmio 000000001e660000/0000000000002000
>       dev: aspeed.wdt, id ""
>         silicon-rev = 67175171 (0x4010303)
>         mmio 000000001e785040/0000000000000020
>       dev: aspeed.wdt, id ""
>         silicon-rev = 67175171 (0x4010303)
>         mmio 000000001e785020/0000000000000020
>       dev: aspeed.wdt, id ""
>         silicon-rev = 67175171 (0x4010303)
>         mmio 000000001e785000/0000000000000020
>       dev: aspeed.sdmc, id ""
>         silicon-rev = 67175171 (0x4010303)
>         ram-size = 536870912 (0x20000000)
>         max-ram-size = 1073741824 (0x40000000)
>         mmio 000000001e6e0000/0000000000001000
>       dev: aspeed.smc.ast2500-spi2, id ""
>         gpio-out "sysbus-irq" 2
>         num-cs = 1 (0x1)
>         mmio 000000001e631000/0000000000000100
>         mmio 0000000038000000/0000000008000000
>         bus: spi
>           type SSI
>           dev: m25p80, id "qdev-id"
>             gpio-in "ssi-gpio-cs" 1
>             nonvolatile-cfg = 36863 (0x8fff)
>             spansion-cr1nv = 0 (0x0)
>             spansion-cr2nv = 8 (0x8)
>             spansion-cr3nv = 2 (0x2)
>             spansion-cr4nv = 16 (0x10)
>             drive = ""
>           dev: m25p80, id ""
>             gpio-in "ssi-gpio-cs" 1
>             nonvolatile-cfg = 36863 (0x8fff)
>             spansion-cr1nv = 0 (0x0)
>             spansion-cr2nv = 8 (0x8)
>             spansion-cr3nv = 2 (0x2)
>             spansion-cr4nv = 16 (0x10)
>             drive = ""
>       dev: aspeed.smc.ast2500-spi1, id ""
>         gpio-out "sysbus-irq" 2
>         num-cs = 1 (0x1)
>         mmio 000000001e630000/0000000000000100
>         mmio 0000000030000000/0000000008000000
>         bus: spi
>           type SSI
>           dev: mx66l1g45g, id ""
>             gpio-in "ssi-gpio-cs" 1
>             nonvolatile-cfg = 36863 (0x8fff)
>             spansion-cr1nv = 0 (0x0)
>             spansion-cr2nv = 8 (0x8)
>             spansion-cr3nv = 2 (0x2)
>             spansion-cr4nv = 16 (0x10)
>             drive = ""
>       dev: aspeed.smc.ast2500-fmc, id ""
>         gpio-out "sysbus-irq" 3
>         num-cs = 2 (0x2)
>         mmio 000000001e620000/0000000000000100
>         mmio 0000000020000000/0000000010000000
>         bus: spi
>           type SSI
>           dev: mx25l25635e, id ""
>             gpio-in "ssi-gpio-cs" 1
>             nonvolatile-cfg = 36863 (0x8fff)
>             spansion-cr1nv = 0 (0x0)
>             spansion-cr2nv = 8 (0x8)
>             spansion-cr3nv = 2 (0x2)
>             spansion-cr4nv = 16 (0x10)
>             drive = ""
>           dev: mx25l25635e, id ""
>             gpio-in "ssi-gpio-cs" 1
>             nonvolatile-cfg = 36863 (0x8fff)
>             spansion-cr1nv = 0 (0x0)
>             spansion-cr2nv = 8 (0x8)
>             spansion-cr3nv = 2 (0x2)
>             spansion-cr4nv = 16 (0x10)
>             drive = ""
>       dev: aspeed.i2c, id ""
>         gpio-out "sysbus-irq" 1
>         mmio 000000001e78a000/0000000000001000
>         bus: aspeed.i2c.13
>           type i2c-bus
>         ... more i2c-bus
>         bus: aspeed.i2c.0
>           type i2c-bus
>       dev: aspeed.timer, id ""
>         gpio-out "sysbus-irq" 8
>         mmio 000000001e782000/0000000000001000
>       dev: aspeed.vic, id ""
>         gpio-out "sysbus-irq" 2
>         gpio-in "" 51
>         mmio 000000001e6c0000/0000000000020000
>       dev: aspeed.scu, id ""
>         silicon-rev = 67175171 (0x4010303)
>         hw-strap1 = 4044018182 (0xf10ad206)
>         hw-strap2 = 0 (0x0)
>         hw-prot-key = 0 (0x0)
>         mmio 000000001e6e2000/0000000000001000
> 
> Observations (same as for ARM virt):
> 
> * machine's containers are not in the qtree.
> 
> * Composition tree node arm1176-arm-cpu is not in the qtree.  That's
>   because it isn't connected to a qbus.
> 
>   Same for pca9552, tmp423, tmp105, ds1338, smbus-eeprom, I guess.

That is odd:

static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
{
    AspeedSoCState *soc = &bmc->soc;

    i2c_create_slave(
        aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3),
        TYPE_PCA9552, 0x60);
    ...

DeviceState *i2c_create_slave(I2CBus *bus, const char *name, ...
{
    DeviceState *dev;

    dev = qdev_create(&bus->qbus, name);
    ...

static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
{
    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
    AspeedI2CState *s = ASPEED_I2C(dev);

    for (i = 0; i < ASPEED_I2C_NR_BUSSES; i++) {
        s->busses[i].bus = i2c_init_bus(dev, name);
        ...

I2CBus *i2c_init_bus(DeviceState *parent, const char *name)
{
    I2CBus *bus;

    bus = I2C_BUS(qbus_create(TYPE_I2C_BUS, parent, name));
    ...

static const TypeInfo i2c_bus_info = {
    .name = TYPE_I2C_BUS,
    .parent = TYPE_BUS,
    ...

> * In the qtree, every other inner node is a qbus.  These are *leaves* in
>   the composition tree.  The qtree's vertex from qbus to qdev is a
>   *link* in the composition tree.
> 
>   Example: main-system-bus -> scu is
>       machine/unattached/sysbus/child[0] ->
>       ../../../machine/soc/scu.
> 
>   Example: main-system-bus -> unimplemented-device is
>       machine/unattached/sysbus/child[12] ->
>       ../../../machine/unattached/device[12].
> 
>   Example: main-system-bus/aspeed.smc.ast2500-spi1/spi -> mx66l1g45g is
>       machine/soc/spi\[0\]/spi/child[0] ->
>       ../../../../machine/unattached/device[3].
> 
>   Example: main-system-bus/aspeed.smc.ast2500-spi2/spi -> m25p80
>       (the one without a qdev ID) is
>       machine/soc/spi\[1\]/spi/child[0] ->
>       ../../../../machine/peripheral-anon/device[0]
> 
>   Example: main-system-bus/aspeed.smc.ast2500-spi2/spi -> m25p80
>       (the one with qdev ID "qdev-id") is
>       machine/soc/spi\[1\]/spi/child[1] ->
>       ../../../../machine/peripheral/qdev-id
> 

