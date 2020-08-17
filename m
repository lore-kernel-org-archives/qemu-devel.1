Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1261AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81FE20657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="jQIBuizU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81FE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ilr-00041I-2v
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.kononenko@yadro.com>)
 id 1k7iko-00032q-9X; Mon, 17 Aug 2020 13:17:02 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:36032 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.kononenko@yadro.com>)
 id 1k7ikk-0004Fj-Qt; Mon, 17 Aug 2020 13:17:01 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 3617D531B5;
 Mon, 17 Aug 2020 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:user-agent:date:date
 :message-id:from:from:references:subject:subject:received
 :received:received; s=mta-01; t=1597684613; x=1599499014; bh=NSw
 duyWJdvn12+0tZFjaoLSQSQXjWRScBAzW8SEw47Q=; b=jQIBuizU6vGKiKc99Ni
 L02X3g0Fh1I7tIeDbfU8f9zn99c12UW0vTaHYw6BfMMaOKwIBfNCzjeRchKr2rS3
 dVYh3NkdMRZH1u1BHuC49Yy1xog+IwGKcNqLgxCQtztuA54kCCF+mO03KZJ1m6FW
 W1K3Nk99n757n5hBKSF1vnvY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mf7p0wfzWbGP; Mon, 17 Aug 2020 20:16:53 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 81DE85177E;
 Mon, 17 Aug 2020 20:16:53 +0300 (MSK)
Received: from [172.17.4.22] (172.17.4.22) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 17
 Aug 2020 20:16:53 +0300
Subject: Re: [PATCH] hw: add a number of SPI-flash's of m25p80 family
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20200811203724.20699-1-i.kononenko@yadro.com>
 <528a1a29-8092-6d7b-8177-68d8a1c6b7b1@kaod.org>
From: i.kononenko <i.kononenko@yadro.com>
Message-ID: <7e669f8b-e4e2-884e-ae90-14546d6b3a73@yadro.com>
Date: Mon, 17 Aug 2020 20:16:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <528a1a29-8092-6d7b-8177-68d8a1c6b7b1@kaod.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.4.22]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=i.kononenko@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 13:16:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No, the ext ID wasn't be checked at a real HW.
Just copied it from the U-boot official repository
https://github.com/u-boot/u-boot/blob/789bfb52668ee609b2043de645e2f94bbd24fd1f/drivers/mtd/spi/spi-nor-ids.c#L183

Do i need to take it from a real HW and compare?

On 12.08.2020 10:27, Cédric Le Goater wrote:
> On 8/11/20 10:37 PM, Igor Kononenko wrote:
>> Support a following SPI flashes:
>> * mx66l51235f
>> * mt25ql512ab
>>
>> Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
>> ---
>>  hw/block/m25p80.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 8227088441..bf1f833784 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -219,6 +219,7 @@ static const FlashPartInfo known_devices[] = {
>>      { INFO("mx25l12855e", 0xc22618,      0,  64 << 10, 256, 0) },
>>      { INFO("mx25l25635e", 0xc22019,      0,  64 << 10, 512, 0) },
>>      { INFO("mx25l25655e", 0xc22619,      0,  64 << 10, 512, 0) },
>> +    { INFO("mx66l51235f", 0xc2201a,      0,  64 << 10, 1024, ER_4K | ER_32K) },
>>      { INFO("mx66u51235f", 0xc2253a,      0,  64 << 10, 1024, ER_4K | ER_32K) },
>>      { INFO("mx66u1g45g",  0xc2253b,      0,  64 << 10, 2048, ER_4K | ER_32K) },
>>      { INFO("mx66l1g45g",  0xc2201b,      0,  64 << 10, 2048, ER_4K | ER_32K) },
>> @@ -237,6 +238,7 @@ static const FlashPartInfo known_devices[] = {
>>      { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
>>      { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
>>      { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>> +    { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
> 
> Have checked the extended ID on real HW ? 
> 
> C. 
> 
>>      { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>>      { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>>      { INFO_STACKED("mt25ql01g", 0x20ba21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
>>
> 

-- 
best,

Igor Kononenko

