Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF355C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B22206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B22206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1d6-0004So-Ul
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jb1cE-0003es-0f
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:45:02 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:56360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jb1cC-0007Ei-Ap
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:45:01 -0400
Received: from player762.ha.ovh.net (unknown [10.110.115.164])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 505441D6F95
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:44:50 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 964B4128372D1;
 Tue, 19 May 2020 12:44:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003cfbe62b5-1fd8-4905-abaa-811a0817e4e2,3DCE2E61E2D7C1BA27EF92566E0C35A5904F621F)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 04/24] aspeed: Don't create unwanted "ftgmac100",
 "aspeed-mmi" devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Andrew Jeffery <andrew@aj.id.au>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-5-armbru@redhat.com>
 <9fc4a6e2-fa90-ba62-91cf-e22eb3ef4cdc@kaod.org>
 <eb1b203d-44ba-4b89-b96b-4e7bf993ac67@www.fastmail.com>
 <87v9ks5vg7.fsf@dusky.pond.sub.org>
 <9cfcba4e-1237-8eb9-7c83-490729f082fe@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6ad3605d-3233-378e-5c37-ed4afbacfc66@kaod.org>
Date: Tue, 19 May 2020 14:44:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9cfcba4e-1237-8eb9-7c83-490729f082fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15330534606601423827
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -83
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtjedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdludejmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephfevvdehieeftdevfeelleffgfehtdfgvdegteeijeetudejgedutdduudfhteeknecuffhomhgrihhnpehophgvnhhpohifvghrrdighiiinecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeivddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.53.149; envelope-from=clg@kaod.org;
 helo=2.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 08:44:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 1:42 PM, Philippe Mathieu-Daudé wrote:
> On 5/19/20 7:45 AM, Markus Armbruster wrote:
>> "Andrew Jeffery" <andrew@aj.id.au> writes:
>>
>>> On Mon, 18 May 2020, at 21:49, Cédric Le Goater wrote:
>>>> On 5/18/20 7:03 AM, Markus Armbruster wrote:
>>>>> These devices are optional, and controlled by @nb_nics.
>>>>> aspeed_soc_ast2600_init() and aspeed_soc_init() create the maximum
>>>>> supported number.  aspeed_soc_ast2600_realize() and
>>>>> aspeed_soc_realize() realize only the wanted number.  Works, although
>>>>> it can leave unrealized devices hanging around in the QOM composition
>>>>> tree.  Affects machines ast2500-evb, ast2600-evb, palmetto-bmc,
>>>>> romulus-bmc, swift-bmc, tacoma-bmc, and witherspoon-bmc.
>>>>>
>>>>> Make the init functions create only the wanted ones.  Visible in "info
>>>>> qom-tree"; here's the change for ast2600-evb:
>>>>>
>>>>>       /machine (ast2600-evb-machine)
>>>>>         [...]
>>>>>         /soc (ast2600-a1)
>>>>>           [...]
>>>>>           /ftgmac100[0] (ftgmac100)
>>>>>             /ftgmac100[0] (qemu:memory-region)
>>>>>      -    /ftgmac100[1] (ftgmac100)
>>>>>      -    /ftgmac100[2] (ftgmac100)
>>>>>      -    /ftgmac100[3] (ftgmac100)
>>>>>           /gpio (aspeed.gpio-ast2600)
>>>>>           [...]
>>>>>           /mii[0] (aspeed-mmi)
>>>>>             /aspeed-mmi[0] (qemu:memory-region)
>>>>>      -    /mii[1] (aspeed-mmi)
>>>>>      -    /mii[2] (aspeed-mmi)
>>>>>      -    /mii[3] (aspeed-mmi)
>>>>>           /rtc (aspeed.rtc)
>>>>>
>>>>> I'm not sure creating @nb_nics devices makes sense.  How many does the
>>>>> physical chip provide?
>>>>
>>>> The AST2400, AST2500 SoC have 2 macs and the AST2600 has 4. Each machine
>>>> define the one it uses, generally MAC0 but the tacoma board uses MAC3.
>>>>
>>>> Shouldn't the model reflect the real address space independently from
>>>> the NIC backends defined on the command line ?
> 
> If the SoC has N ftgmac100 peripherals, you need to mmio-map the N instances, 
> else your guest will get MEMTX_DECODE_ERROR trying to access it, regardless 
> command line NIC plugged.
 
yes. This is what I do with the patch attached below but I have another 
problem.

Get a witherspoon-tacoma flash image :

    https://openpower.xyz/job/openbmc-build/distro=ubuntu,label=builder,target=witherspoon-tacoma/lastSuccessfulBuild/artifact/deploy/images/witherspoon-tacoma/flash-witherspoon-tacoma

Run :

    qemu-system-arm -M tacoma-bmc -nic user -drive file=./flash-witherspoon-tacoma,format=raw,if=mtd -nographic -nodefaults -serial mon:stdio
    qemu-system-arm: warning: nic ftgmac100.0 has no peer
    qemu-system-arm: warning: nic ftgmac100.1 has no peer
    qemu-system-arm: warning: nic ftgmac100.3 has no peer
    
    
    U-Boot 2019.04 (May 06 2020 - 04:20:01 +0000)
    
    SOC: AST2600-A1 
    LPC Mode: SIO:Enable : SuperIO-2e
    Eth: MAC0: RMII/NCSI, MAC1: RMII/NCSI, MAC2: RMII/NCSI, MAC3: RMII/NCSI
    Model: Tacoma
    DRAM:  already initialized, 1008 MiB
    ...

How do I deal with the "no peer" warnings ? 

Thanks,

C.


From a3c2772eca8a541158345e6f219ce524f1bc017b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 19 May 2020 14:39:55 +0200
Subject: [PATCH] arm/aspeed: Rework NIC attachment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed.h     |  1 +
 include/hw/arm/aspeed_soc.h |  1 +
 hw/arm/aspeed.c             |  5 +++++
 hw/arm/aspeed_ast2600.c     |  9 +++++++--
 hw/arm/aspeed_soc.c         | 10 ++++++++--
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 18521484b90e..7e71152b3554 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -39,6 +39,7 @@ typedef struct AspeedMachineClass {
     const char *fmc_model;
     const char *spi_model;
     uint32_t num_cs;
+    uint32_t nic_mask;
     void (*i2c_init)(AspeedBoardState *bmc);
 } AspeedMachineClass;
 
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 914115f3ef77..32e9a232a049 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -55,6 +55,7 @@ typedef struct AspeedSoCState {
     AspeedSDMCState sdmc;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
+    uint32_t nic_mask;
     AspeedMiiState mii[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
     AspeedGPIOState gpio_1_8v;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6f8f4b88f8ab..338b5db20cf9 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -283,6 +283,8 @@ static void aspeed_machine_init(MachineState *machine)
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), amc->num_cs, "num-cs",
                             &error_abort);
+    object_property_set_int(OBJECT(&bmc->soc), amc->nic_mask, "nic-mask",
+                            &error_abort);
     object_property_set_link(OBJECT(&bmc->soc), OBJECT(&bmc->ram_container),
                              "dram", &error_abort);
     if (machine->kernel_filename) {
@@ -556,12 +558,14 @@ static int aspeed_soc_num_cpus(const char *soc_name)
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
     mc->init = aspeed_machine_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
     mc->default_ram_id = "ram";
+    amc->nic_mask = 1; /* First NIC */
 
     aspeed_machine_class_props_init(oc);
 }
@@ -698,6 +702,7 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
     amc->fmc_model = "mx66l1g45g";
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
+    amc->nic_mask  = 0x4; /* third NIC */
     amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
     mc->default_ram_size = 1 * GiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 114b94f8f44d..0e303c3018e7 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -247,6 +247,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     Error *err = NULL, *local_err = NULL;
     qemu_irq irq;
+    NICInfo *nd = &nd_table[0];
 
     /* IO space */
     create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
@@ -462,8 +463,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
-        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
+    for (i = 0; i < sc->macs_num; i++) {
+        if ((s->nic_mask & (1 << i)) && nd->used) {
+            qemu_check_nic_model(nd, TYPE_FTGMAC100);
+            qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), nd);
+            nd++;
+        }
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 984d29087dce..cc4f6769e763 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -234,6 +234,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     Error *err = NULL, *local_err = NULL;
+    NICInfo *nd = &nd_table[0];
 
     /* IO space */
     create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
@@ -405,8 +406,12 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* Net */
-    for (i = 0; i < nb_nics && i < sc->macs_num; i++) {
-        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
+    for (i = 0; i < sc->macs_num; i++) {
+        if ((s->nic_mask & (1 << i)) && nd->used) {
+            qemu_check_nic_model(nd, TYPE_FTGMAC100);
+            qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), nd);
+            nd++;
+        }
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
@@ -455,6 +460,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 }
 static Property aspeed_soc_properties[] = {
+    DEFINE_PROP_UINT32("nic-mask", AspeedSoCState, nic_mask, 0x1),
     DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.25.4


