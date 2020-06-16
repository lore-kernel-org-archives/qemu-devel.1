Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D491C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D7220707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D7220707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFQP-0006aQ-Ne
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlFBj-0002Ev-PR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:15:55 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:51131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlFBh-0000Qc-HJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:15:55 -0400
Received: from player699.ha.ovh.net (unknown [10.108.54.72])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id A98AD16D2AD
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 19:15:50 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 2DA1C1369E315;
 Tue, 16 Jun 2020 17:15:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002311f1b4f-21d6-40ee-9a57-c76899b6b693,EBFB3A1CCBA6C973625B067ACEBAD7C75398389C)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 1/2] hw/misc/pca9552: Trace LED On/Off events
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200616094542.25415-1-f4bug@amsat.org>
 <20200616094542.25415-2-f4bug@amsat.org>
 <ce02c953-073a-3843-5830-930cc194117c@kaod.org>
Message-ID: <3181da82-6dcf-9826-5747-7601204faa9f@kaod.org>
Date: Tue, 16 Jun 2020 19:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ce02c953-073a-3843-5830-930cc194117c@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18322332138027584270
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudejtddguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuhffvfhfkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheevheejjefhtedvueeghfeiffduleeijeehteeuvdfgheeikeevffeghfeviefhnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.32.120.239; envelope-from=clg@kaod.org;
 helo=5.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 13:15:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After a closer look,

>> @@ -45,9 +46,15 @@ static void pca9552_update_pin_input(PCA9552State *s)
>>          switch (config) {
>>          case PCA9552_LED_ON:
>>              s->regs[input_reg] |= 1 << input_shift;
>> +            if (input_shift < s->nr_leds) {
This seems like a superfluous test.

>> +                trace_pca9552_led_set(input_shift, true);

This should be using 'i' and the output is not very concise : 

564609@1592326881.815616:pca9552_led_set LED#0 state:1
564609@1592326881.815660:pca9552_led_set LED#1 state:1
564609@1592326881.815669:pca9552_led_set LED#2 state:1
564609@1592326881.815677:pca9552_led_set LED#3 state:1
564609@1592326881.815706:pca9552_led_set LED#4 state:0
564609@1592326881.815715:pca9552_led_set LED#5 state:0
564609@1592326881.815727:pca9552_led_set LED#6 state:0
564609@1592326881.815740:pca9552_led_set LED#7 state:0
564609@1592326881.815748:pca9552_led_set LED#8 state:0
564609@1592326881.815759:pca9552_led_set LED#9 state:0
564609@1592326881.815767:pca9552_led_set LED#10 state:0
564609@1592326881.815779:pca9552_led_set LED#11 state:0
564609@1592326881.815790:pca9552_led_set LED#12 state:0
564609@1592326881.815802:pca9552_led_set LED#13 state:1
564609@1592326881.815813:pca9552_led_set LED#14 state:1
564609@1592326881.815826:pca9552_led_set LED#15 state:1

I would instead simply dump the contents of the PCA9552_INPUT registers : 

LEDS = 1111000000000101
LEDS = 1111000000000111
....

C.


>> +            }
>>              break;
>>          case PCA9552_LED_OFF:
>>              s->regs[input_reg] &= ~(1 << input_shift);
>> +            if (input_shift < s->nr_leds) {
>> +                trace_pca9552_led_set(input_shift, false);
>> +            }
>>              break;
>>          case PCA9552_LED_PWM0:
>>          case PCA9552_LED_PWM1:
>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> index 5561746866..ed80d0d1be 100644
>> --- a/hw/misc/trace-events
>> +++ b/hw/misc/trace-events
>> @@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>>  # grlib_ahb_apb_pnp.c
>>  grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
>> +
>> +# pca9552.c
>> +pca9552_led_set(unsigned id, bool state) "LED#%d state:%u"
>>
> 


