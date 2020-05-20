Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88405C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 07:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501F220756
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 07:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501F220756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbIks-0001Pk-HV
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 03:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jbIk0-0000qX-Tv
 for qemu-devel@nongnu.org; Wed, 20 May 2020 03:02:12 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:48044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jbIjy-0003mn-PL
 for qemu-devel@nongnu.org; Wed, 20 May 2020 03:02:12 -0400
Received: from player794.ha.ovh.net (unknown [10.108.42.5])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id E12198CE0D
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:02:06 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id 2734AF87A851;
 Wed, 20 May 2020 07:01:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00391ad6bee-5893-4ba0-95a1-907b9925b5e3,208050372AC47BB4B8F4DF084FF080F941447DBD)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH] arm/aspeed: Rework NIC attachment
To: Markus Armbruster <armbru@redhat.com>
References: <20200519161957.1056027-1-clg@kaod.org>
 <87zha3t8qg.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3ead6228-b61b-ca8b-6ebc-dd9299f1a334@kaod.org>
Date: Wed, 20 May 2020 09:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87zha3t8qg.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15415258577191602979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -77
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtkedgudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculddvfedmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeiuddvhfefjeegjeeiheeftddtveekjefghffgffeuvdffleeiveefteekgefggeenucffohhmrghinhepohhpvghnphhofigvrhdrgiihiidpohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.50.32; envelope-from=clg@kaod.org;
 helo=7.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 03:02:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:34 AM, Markus Armbruster wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> The AST2400 and AST2500 SoCs have two MACs but only the first MAC0 is
>> active on the Aspeed machines using these SoCs. The AST2600 has four
>> MACs. The AST2600 EVB machine activates MAC1, MAC2 and MAC3 and the
>> Tacoma BMC machine activates MAC2.
>>
>> Introduce a bit-field property "macs-mask" under the Aspeed SoC model
>> to link the active MACs of the machine being started with the available
>> network devices.
>>
>> Inactive MACs will have no peer and QEMU will warn the user with :
>>
>>     qemu-system-arm: warning: nic ftgmac100.0 has no peer
>>     qemu-system-arm: warning: nic ftgmac100.1 has no peer
>>     qemu-system-arm: warning: nic ftgmac100.3 has no peer
> 
> I can't reproduce this warning.  What's your exact command line?

Get a witherspoon-tacoma flash image :

    $ wget https://openpower.xyz/job/openbmc-build/distro=ubuntu,label=builder,target=witherspoon-tacoma/lastSuccessfulBuild/artifact/deploy/images/witherspoon-tacoma/flash-witherspoon-tacoma

Run :

    $ qemu-system-arm -M tacoma-bmc -nic user -drive file=./flash-witherspoon-tacoma,format=raw,if=mtd -nographic -nodefaults -serial mon:stdio
    qemu-system-arm: warning: nic ftgmac100.0 has no peer
    qemu-system-arm: warning: nic ftgmac100.1 has no peer
    qemu-system-arm: warning: nic ftgmac100.3 has no peer
    
> 
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>
>>  To be applied on top of patch "arm/aspeed: Compute the number of CPUs
>>  from the SoC definition" 
>>  
>>  http://patchwork.ozlabs.org/project/qemu-devel/patch/20200519091631.1006073-1-clg@kaod.org/
>>  
>>  include/hw/arm/aspeed.h     |  1 +
>>  include/hw/arm/aspeed_soc.h |  6 ++++++
>>  hw/arm/aspeed.c             |  6 ++++++
>>  hw/arm/aspeed_ast2600.c     | 11 ++++++++---
>>  hw/arm/aspeed_soc.c         | 10 ++++++++--
>>  5 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
>> index 18521484b90e..842dff485f5b 100644
>> --- a/include/hw/arm/aspeed.h
>> +++ b/include/hw/arm/aspeed.h
>> @@ -39,6 +39,7 @@ typedef struct AspeedMachineClass {
>>      const char *fmc_model;
>>      const char *spi_model;
>>      uint32_t num_cs;
>> +    uint32_t macs_mask;
>>      void (*i2c_init)(AspeedBoardState *bmc);
>>  } AspeedMachineClass;
>>  
>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>> index 914115f3ef77..fdb9e05bc47c 100644
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -34,6 +34,11 @@
>>  #define ASPEED_CPUS_NUM  2
>>  #define ASPEED_MACS_NUM  4
>>  
>> +#define ASPEED_MAC0_ON   (1 << 0)
>> +#define ASPEED_MAC1_ON   (1 << 1)
>> +#define ASPEED_MAC2_ON   (1 << 2)
>> +#define ASPEED_MAC3_ON   (1 << 3)
>> +
>>  typedef struct AspeedSoCState {
>>      /*< private >*/
>>      DeviceState parent;
>> @@ -55,6 +60,7 @@ typedef struct AspeedSoCState {
>>      AspeedSDMCState sdmc;
>>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
>>      FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
>> +    uint32_t macs_mask;
> 
> What's the purpose of this member?  When and how would it be different
> from AspeedMachineClass's macs_mask?

Each machine activates a different set of MACs even if using the same SoC.
So, the SoC macs_mask is overiden when the machine initializes the SoC in 
aspeed_machine_init().

That said, I think the default SoC macs_mask should be all MACS, a value 
of 0xFFFFFFFF would be fine, and not only the first MAC as this patch does.


> 
>>      AspeedMiiState mii[ASPEED_MACS_NUM];
>>      AspeedGPIOState gpio;
>>      AspeedGPIOState gpio_1_8v;
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 6f8f4b88f8ab..79c683864d7e 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -283,6 +283,8 @@ static void aspeed_machine_init(MachineState *machine)
>>                              &error_abort);
>>      object_property_set_int(OBJECT(&bmc->soc), amc->num_cs, "num-cs",
>>                              &error_abort);
>> +    object_property_set_int(OBJECT(&bmc->soc), amc->macs_mask, "macs-mask",
>> +                            &error_abort);
>>      object_property_set_link(OBJECT(&bmc->soc), OBJECT(&bmc->ram_container),
>>                               "dram", &error_abort);
>>      if (machine->kernel_filename) {
>> @@ -556,12 +558,14 @@ static int aspeed_soc_num_cpus(const char *soc_name)
>>  static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>>  
>>      mc->init = aspeed_machine_init;
>>      mc->no_floppy = 1;
>>      mc->no_cdrom = 1;
>>      mc->no_parallel = 1;
>>      mc->default_ram_id = "ram";
>> +    amc->macs_mask = ASPEED_MAC0_ON;
>>  
>>      aspeed_machine_class_props_init(oc);
>>  }
>> @@ -680,6 +684,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
>>      amc->fmc_model = "w25q512jv";
>>      amc->spi_model = "mx66u51235f";
>>      amc->num_cs    = 1;
>> +    amc->macs_mask  = ASPEED_MAC1_ON | ASPEED_MAC2_ON | ASPEED_MAC3_ON;
>>      amc->i2c_init  = ast2600_evb_i2c_init;
>>      mc->default_ram_size = 1 * GiB;
>>      mc->default_cpus = mc->min_cpus = mc->max_cpus =
>> @@ -698,6 +703,7 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
>>      amc->fmc_model = "mx66l1g45g";
>>      amc->spi_model = "mx66l1g45g";
>>      amc->num_cs    = 2;
>> +    amc->macs_mask  = ASPEED_MAC2_ON;
>>      amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
>>      mc->default_ram_size = 1 * GiB;
>>      mc->default_cpus = mc->min_cpus = mc->max_cpus =
>> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
>> index 114b94f8f44d..fa85122f6d78 100644
>> --- a/hw/arm/aspeed_ast2600.c
>> +++ b/hw/arm/aspeed_ast2600.c
>> @@ -247,6 +247,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>>      AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>      Error *err = NULL, *local_err = NULL;
>>      qemu_irq irq;
>> +    NICInfo *nd = &nd_table[0];
>>  
>>      /* IO space */
>>      create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
>> @@ -462,8 +463,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>>      }
>>  
>>      /* Net */
>> -    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
>> -        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
>> +    for (i = 0; i < sc->macs_num; i++) {
>> +        if ((s->macs_mask & (1 << i)) && nd->used) {
>> +            qemu_check_nic_model(nd, TYPE_FTGMAC100);
>> +            qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), nd);
>> +            nd++;
>> +        }
>>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
>>                                   &err);
>>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
>> @@ -471,7 +476,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>>          error_propagate(&err, local_err);
>>          if (err) {
>>              error_propagate(errp, err);
>> -           return;
>> +            return;
>>          }
>>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>>                          sc->memmap[ASPEED_ETH1 + i]);
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index 984d29087dce..d2c6a5760790 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -234,6 +234,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>>      AspeedSoCState *s = ASPEED_SOC(dev);
>>      AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>      Error *err = NULL, *local_err = NULL;
>> +    NICInfo *nd = &nd_table[0];
>>  
>>      /* IO space */
>>      create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
>> @@ -405,8 +406,12 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>>      }
>>  
>>      /* Net */
>> -    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
>> -        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
>> +    for (i = 0; i < sc->macs_num; i++) {
>> +        if ((s->macs_mask & (1 << i)) && nd->used) {
>> +            qemu_check_nic_model(nd, TYPE_FTGMAC100);
>> +            qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), nd);
>> +            nd++;
>> +        }
>>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
>>                                   &err);
>>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
>> @@ -455,6 +460,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>>                         aspeed_soc_get_irq(s, ASPEED_SDHCI));
>>  }
>>  static Property aspeed_soc_properties[] = {
>> +    DEFINE_PROP_UINT32("macs-mask", AspeedSoCState, macs_mask, 0x1),
>>      DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
>>                       MemoryRegion *),
>>      DEFINE_PROP_END_OF_LIST(),
> 


