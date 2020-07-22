Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A3DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87C720792
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87C720792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9iu-0005FI-1B
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jy9iB-0004NB-E7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:02:47 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:43026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jy9i8-0003en-Ih
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:02:47 -0400
Received: from player694.ha.ovh.net (unknown [10.110.171.31])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0AA70245CAB
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 10:02:40 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 67478147C80F7;
 Wed, 22 Jul 2020 08:02:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003b8dcc5c9-405a-425c-a740-ac54d9b080a4,6D33408670610A794F884C13CBBF375E647FF3E1)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 2/4] m25p80: Improve command handling for Jedec commands
To: Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>
References: <20200206183219.3756-1-linux@roeck-us.net>
 <20200206183219.3756-2-linux@roeck-us.net>
 <eb21047a-aa9f-eb39-af8a-b5858e01fee5@kaod.org>
 <0ae638a0-6e74-c32b-a5bb-6a89ae5b819f@roeck-us.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <83f26c3b-cc7e-585a-1eae-2d7d9adb30af@kaod.org>
Date: Wed, 22 Jul 2020 10:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0ae638a0-6e74-c32b-a5bb-6a89ae5b819f@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17482973755703593875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrgeekgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefueeufeevleevleelleejuedtieevtefgteelgfeiieffgfettefhudeigfdtieenucffohhmrghinhepshhuphgvrhhmihgtrhhordgtohhmnecukfhppedtrddtrddtrddtpdejkedrvddtvddrudefvddrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.179.66; envelope-from=clg@kaod.org;
 helo=19.mo4.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 04:02:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Erik Smit <erik.lucas.smit@gmail.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 9:57 PM, Guenter Roeck wrote:
> On 7/21/20 10:36 AM, Cédric Le Goater wrote:
>> Hello,
>>
>> On 2/6/20 7:32 PM, Guenter Roeck wrote:
>>> When requesting JEDEC data using the JEDEC_READ command, the Linux kernel
>>> always requests 6 bytes. The current implementation only returns three
>>> bytes, and interprets the remaining three bytes as new commands.
>>> While this does not matter most of the time, it is at the very least
>>> confusing. To avoid the problem, always report up to 6 bytes of JEDEC
>>> data. Fill remaining data with 0.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> v2: Split patch into two parts; improved decription
>>>
>>>  hw/block/m25p80.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>> index 5ff8d270c4..53bf63856f 100644
>>> --- a/hw/block/m25p80.c
>>> +++ b/hw/block/m25p80.c
>>> @@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>>          for (i = 0; i < s->pi->id_len; i++) {
>>>              s->data[i] = s->pi->id[i];
>>>          }
>>> +        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
>>> +            s->data[i] = 0;
>>> +        }
>>
>> This is breaking an old firmware (Linux version 2.6.28.9) for a SuperMicro
>> board : 
>>
>> 	https://www.supermicro.com/en/products/motherboard/X11SSL-F 
>>
>> which expects the flash ID to repeat. Erik solved the problem with the patch 
>> below and I think it makes sense to wrap around. Anyone knows what should be 
>> the expected behavior ? 
>>
> 
> No idea what the expected behavior is, but I am fine with the code below
> if it works.

I checked on a few real systems and indeed the mx25l25635e behaves
differently.

AST2400

[    5.594176] aspeed-smc 1e620000.spi: reading JEDEC ID 20:BA:19:10:00:00
[    5.602226] aspeed-smc 1e620000.spi: n25q256a (32768 Kbytes)
...
[    6.174052] aspeed-smc 1e630000.spi: reading JEDEC ID C2:20:19:C2:20:19
[    6.181682] aspeed-smc 1e630000.spi: mx25l25635e (32768 Kbytes)

AST2500

[    1.641317] aspeed-smc 1e620000.spi: reading JEDEC ID EF:40:19:00:00:00
[    1.648174] aspeed-smc 1e620000.spi: w25q256 (32768 Kbytes)
...
[    1.179214] aspeed-smc 1e630000.spi: reading JEDEC ID EF:40:19:00:00:00
[    1.186737] aspeed-smc 1e630000.spi: w25q256 (32768 Kbytes)

AST2600

[    1.020255] aspeed-smc 1e620000.spi: reading JEDEC ID EF:40:20:00:00:00
[    1.027830] aspeed-smc 1e620000.spi: w25q512jv (65536 Kbytes)
...
[    1.884171] aspeed-smc 1e630000.spi: reading JEDEC ID EF:40:19:00:00:00
[    1.890937] aspeed-smc 1e630000.spi: w25q256 (32768 Kbytes)


I think we need a special case for it.

C. 

