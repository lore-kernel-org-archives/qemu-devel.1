Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE874C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43CC23128
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43CC23128
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gHr-0006xZ-Pn
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3gHF-0006Jb-5s; Thu, 06 Aug 2020 09:49:49 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:51339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3gHD-0004JJ-0p; Thu, 06 Aug 2020 09:49:48 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.2])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 9CC304DB0CEA;
 Thu,  6 Aug 2020 15:49:43 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 15:49:42 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G001ac1e7be0-fb11-4190-810b-4d83ddf1ba2f,
 96EDEDBD7B7627A0205C40E9E2B74F8D513A659B) smtp.auth=clg@kaod.org
Subject: Re: [PATCH for-5.2 04/19] aspeed/scu: Fix valid access size on AST2400
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell
 <peter.maydell@linaro.org>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-5-clg@kaod.org>
 <4a41f234-ab81-d078-0fcd-c1b20fceb1e9@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bd58f180-1c18-c998-5fa7-da41177deb02@kaod.org>
Date: Thu, 6 Aug 2020 15:49:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4a41f234-ab81-d078-0fcd-c1b20fceb1e9@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 84e0f196-ed16-4d38-a499-96a76aa49294
X-Ovh-Tracer-Id: 754071466221407081
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehfgegsuhhgsegrmhhsrghtrdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 09:21:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, erik-smit <erik.lucas.smit@gmail.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:32 PM, Philippe Mathieu-Daudé wrote:
> On 8/6/20 3:20 PM, Cédric Le Goater wrote:
>> The read access size of the SCU registers can be 1/2/4 bytes and write
>> is 4 bytes. Set the min access size to 1 byte to cover both read and
>> write operations on the AST2400 but keep the min access size of the
>> other SoCs to 4 bytes as this is an unusual access size.
> 
> From your description it seems you need to implement .valid.accepts().

Ah yes. 

Can this come as a follow up ? because this patch is enabling
support for the Supermicro X11 BMC machine.

Thanks,

C. 


> 
>>
>> This fixes support for some old firmware doing 2 bytes reads on the
>> AST2400 SoC.
>>
>> Reported-by: erik-smit <erik.lucas.smit@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  hw/misc/aspeed_scu.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
>> index ec4fef900e27..764222404bef 100644
>> --- a/hw/misc/aspeed_scu.c
>> +++ b/hw/misc/aspeed_scu.c
>> @@ -328,9 +328,10 @@ static const MemoryRegionOps aspeed_ast2400_scu_ops = {
>>      .read = aspeed_scu_read,
>>      .write = aspeed_ast2400_scu_write,
>>      .endianness = DEVICE_LITTLE_ENDIAN,
>> -    .valid.min_access_size = 4,
>> -    .valid.max_access_size = 4,
>> -    .valid.unaligned = false,
>> +    .valid = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 4,
>> +    },
>>  };
>>  
>>  static const MemoryRegionOps aspeed_ast2500_scu_ops = {
>>
> 


