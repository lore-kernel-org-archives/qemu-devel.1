Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1650C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9264120709
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9264120709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7uno-0004oW-RJ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 02:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k7unD-0004Jf-G3; Tue, 18 Aug 2020 02:08:19 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:40231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k7unA-0002SC-T7; Tue, 18 Aug 2020 02:08:19 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.47])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id C73375821804;
 Tue, 18 Aug 2020 08:08:05 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 08:08:05 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G001c87858a7-b678-4a6b-90d0-2387fafac297,
 5D4690BFF1A8204198846400511E4593F3B91EAC) smtp.auth=clg@kaod.org
Subject: Re: [PATCH] hw: add a number of SPI-flash's of m25p80 family
To: i.kononenko <i.kononenko@yadro.com>
References: <20200811203724.20699-1-i.kononenko@yadro.com>
 <528a1a29-8092-6d7b-8177-68d8a1c6b7b1@kaod.org>
 <7e669f8b-e4e2-884e-ae90-14546d6b3a73@yadro.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c6c73b3a-ea40-cec4-34bd-bfd0d8859cc6@kaod.org>
Date: Tue, 18 Aug 2020 08:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7e669f8b-e4e2-884e-ae90-14546d6b3a73@yadro.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: ab3c29ee-1c46-44cd-a13a-0e3b32d48381
X-Ovh-Tracer-Id: 8089872308167805734
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddthedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehuedtheeghfdvhedtueelteegvdefueektdefiefhffffieduuddtudfhgfevtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepihdrkhhonhhonhgvnhhkoheshigrughrohdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:08:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 7:16 PM, i.kononenko wrote:
> No, the ext ID wasn't be checked at a real HW.
> Just copied it from the U-boot official repository
> https://github.com/u-boot/u-boot/blob/789bfb52668ee609b2043de645e2f94bbd24fd1f/drivers/mtd/spi/spi-nor-ids.c#L183


OK.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> Do i need to take it from a real HW and compare?
No. That's fine :)

Thanks,

C. 


> 
> On 12.08.2020 10:27, Cédric Le Goater wrote:
>> On 8/11/20 10:37 PM, Igor Kononenko wrote:
>>> Support a following SPI flashes:
>>> * mx66l51235f
>>> * mt25ql512ab
>>>
>>> Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
>>> ---
>>>  hw/block/m25p80.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>> index 8227088441..bf1f833784 100644
>>> --- a/hw/block/m25p80.c
>>> +++ b/hw/block/m25p80.c
>>> @@ -219,6 +219,7 @@ static const FlashPartInfo known_devices[] = {
>>>      { INFO("mx25l12855e", 0xc22618,      0,  64 << 10, 256, 0) },
>>>      { INFO("mx25l25635e", 0xc22019,      0,  64 << 10, 512, 0) },
>>>      { INFO("mx25l25655e", 0xc22619,      0,  64 << 10, 512, 0) },
>>> +    { INFO("mx66l51235f", 0xc2201a,      0,  64 << 10, 1024, ER_4K | ER_32K) },
>>>      { INFO("mx66u51235f", 0xc2253a,      0,  64 << 10, 1024, ER_4K | ER_32K) },
>>>      { INFO("mx66u1g45g",  0xc2253b,      0,  64 << 10, 2048, ER_4K | ER_32K) },
>>>      { INFO("mx66l1g45g",  0xc2201b,      0,  64 << 10, 2048, ER_4K | ER_32K) },
>>> @@ -237,6 +238,7 @@ static const FlashPartInfo known_devices[] = {
>>>      { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
>>>      { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
>>>      { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>>> +    { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
>>
>> Have checked the extended ID on real HW ? 
>>
>> C. 
>>
>>>      { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>>>      { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>>>      { INFO_STACKED("mt25ql01g", 0x20ba21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
>>>
>>
> 


