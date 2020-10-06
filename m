Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B77C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15607206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15607206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrDP-000853-TI
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPrCO-0007HS-A8; Tue, 06 Oct 2020 13:56:28 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:58715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPrCK-0001if-Gc; Tue, 06 Oct 2020 13:56:28 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.55])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 58C7162B03AC;
 Tue,  6 Oct 2020 19:56:21 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 6 Oct 2020
 19:56:20 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005baa1ad17-2893-46bd-b75c-f88912534356,
 2331A23DC679A54E7C1604B88AF6A34BAE14B46D) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 6/6] spapr/xive: Introduce a new CAS value for the
 StoreEOI capability
To: Greg Kurz <groug@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201005165147.526426-7-clg@kaod.org> <20201006193909.617cc487@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <75092c78-6a20-4870-8c06-76aa93365418@kaod.org>
Date: Tue, 6 Oct 2020 19:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006193909.617cc487@bahia.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 0814dd7e-0652-4ad7-871f-6230e157a46d
X-Ovh-Tracer-Id: 12665529530668977059
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehgrhhouhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 12:58:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 7:39 PM, Greg Kurz wrote:
> On Mon, 5 Oct 2020 18:51:47 +0200
> Cédric Le Goater <clg@kaod.org> wrote:
> 
>> When the StoreEOI capability is set to "cas", let CAS decide when
>> StoreEOI should be advertised. StoreEOI is safe to use with a P10
>> compat machine because the OS enforces load-after-store ordering but
>> not with P9 compat.
>>
>> The question now is : should we make "cas" the default at the machine
>> level ?
>>
> 
> Hmm, spapr capabilities are knobs for the end user to provide a specific
> and consistent behavior to the guest... so the "let CAS decide depending
> on what the guest asked for" thing looks awkward... 

The guest doesn't ask for StoreEOI. The hypervisor will return StoreEOI
if the kernel is P10 compat and will not if it's P9 to make sure that
it can be migrated to a P9 host.  

> I mean that making
> "cas" the default at the machine level looks like you don't really want
> this to be a capability at all.

It means that you are not forcing a behaviour "off" or "on". It depends
on the guest support, P10 or P9, which is what we want as a default 
behavior to be in sync with pHyp.

> If the user asked for StoreEOI but the guest chose a compat mode that
> can't support it, QEMU should simply exit IMHO
It's not like XICS. A P8 compat can not run on XIVE. A P9 compat can use 
StoreEOI. So it should be considered more like a mitigation. But anyhow, 
the P9 systems currenly shipped never activate StoreEOI. So you will get 
the error.
 
> Or alternatively I guess you can just forget about the spapr capability
> and do all the checks (XIVE interrupt controller, KVM support, guest
> asked for P10) at CAS.

That's how I did in the fisrt patches but then you loose the ability to 
switch it off on P10 and switch on on P9. Which is good to have for tests 
and performance and for possible issues if we ever have to handle a source 
which has different charateristics. In that case, we would switch it off. 

Thanks,

C.


 
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr.h      |  1 +
>>  include/hw/ppc/spapr_xive.h |  1 +
>>  hw/intc/spapr_xive.c        |  9 +++++++++
>>  hw/ppc/spapr_caps.c         | 21 +++++++++++++++++----
>>  hw/ppc/spapr_hcall.c        |  7 +++++++
>>  5 files changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index b701c14b4e09..17e7d873e8dc 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -87,6 +87,7 @@ typedef enum {
>>  #define SPAPR_CAP_ON                    0x01
>>  
>>  /* Custom Caps */
>> +#define SPAPR_CAP_CAS                   0x02
>>  
>>  /* Generic */
>>  #define SPAPR_CAP_BROKEN                0x00
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 26c8d90d7196..8b8aa586e44f 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -75,6 +75,7 @@ void spapr_xive_map_mmio(SpaprXive *xive);
>>  
>>  int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
>>                               uint32_t *out_server, uint8_t *out_prio);
>> +void spapr_xive_enable_store_eoi(SpaprXive *xive, bool enable);
>>  
>>  /*
>>   * KVM XIVE device helpers
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 41f2719ff93a..f57a2681dd91 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -1802,3 +1802,12 @@ void spapr_xive_hcall_init(SpaprMachineState *spapr)
>>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
>>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>>  }
>> +
>> +void spapr_xive_enable_store_eoi(SpaprXive *xive, bool enable)
>> +{
>> +    if (enable) {
>> +        xive->source.esb_flags |= XIVE_SRC_STORE_EOI;
>> +    } else {
>> +        xive->source.esb_flags &= ~XIVE_SRC_STORE_EOI;
>> +    }
>> +}
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 9251badbdc27..c55e1fccb9bc 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -524,6 +524,13 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>>      }
>>  }
>>  
>> +SpaprCapPossible cap_storeeoi_possible = {
>> +    .num = 3,
>> +    .vals = { "off", "on", "cas" },
>> +    .help = "off - no StoreEOI, on - StoreEOI, "
>> +            "cas - negotiated at CAS (POWER10 compat only)",
>> +};
>> +
>>  static void cap_storeeoi_apply(SpaprMachineState *spapr, uint8_t val,
>>                                 Error **errp)
>>  {
>> @@ -550,6 +557,11 @@ static void cap_storeeoi_apply(SpaprMachineState *spapr, uint8_t val,
>>              return;
>>          }
>>  
>> +        /* CAS will decide to advertise StoreEOI (P10 compat kernels only) */
>> +        if (val == SPAPR_CAP_CAS) {
>> +            return;
>> +        }
>> +
>>          /*
>>           * load-after-store ordering is not enforced on POWER9 CPUs
>>           * and StoreEOI can be racy.
>> @@ -671,11 +683,12 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>      },
>>      [SPAPR_CAP_STOREEOI] = {
>>          .name = "storeeoi",
>> -        .description = "Implements XIVE StoreEOI feature",
>> +        .description = "Implements XIVE StoreEOI feature (off, on, cas)",
>>          .index = SPAPR_CAP_STOREEOI,
>> -        .get = spapr_cap_get_bool,
>> -        .set = spapr_cap_set_bool,
>> -        .type = "bool",
>> +        .get = spapr_cap_get_string,
>> +        .set = spapr_cap_set_string,
>> +        .type = "string",
>> +        .possible = &cap_storeeoi_possible,
>>          .apply = cap_storeeoi_apply,
>>      },
>>  };
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 607740150fa2..158b122b9192 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1804,6 +1804,13 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
>>  "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=xive or ic-mode=dual machine property");
>>              exit(EXIT_FAILURE);
>>          }
>> +
>> +        /* Advertise StoreEOI for a P10 compat guest. */
>> +        if (spapr_get_cap(spapr, SPAPR_CAP_STOREEOI) == SPAPR_CAP_CAS) {
>> +            bool enable = ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0,
>> +                                           cpu->compat_pvr);
>> +            spapr_xive_enable_store_eoi(spapr->xive, enable);
>> +        }
>>      } else {
>>          if (!spapr->irq->xics) {
>>              error_report(
> 


