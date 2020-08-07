Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1520C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A77820866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A77820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3vRC-0006VP-KG
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 02:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3vQ4-0005rw-5G; Fri, 07 Aug 2020 01:59:56 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:58927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3vQ1-0002JT-Q0; Fri, 07 Aug 2020 01:59:55 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.217])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 0988A549C489;
 Fri,  7 Aug 2020 07:59:44 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 07:59:44 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006991df880-09ce-4179-8efc-5a80c0d05a16,
 9C6B65F6CFD3D723D723CC07BEDAC6F805E88D1E) smtp.auth=clg@kaod.org
Subject: Re: [PATCH for-5.2 02/19] m25p80: Add support for mx25l25635f
To: Joel Stanley <joel@jms.id.au>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-3-clg@kaod.org>
 <CACPK8XddhjsdTF2tiiuFoDZ9L+LqOSJLydE-YUAqkbGs4OvquA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <baad9663-5df1-9a90-5cc7-44fda7a18cda@kaod.org>
Date: Fri, 7 Aug 2020 07:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XddhjsdTF2tiiuFoDZ9L+LqOSJLydE-YUAqkbGs4OvquA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: f85cd0b8-55bd-48a5-bf45-9614b3140636
X-Ovh-Tracer-Id: 17136196584775650211
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepleduueelkefhudffkedtieefheevgfekhefgudeuheeuledvkeelgfffudeludelnecuffhomhgrihhnpehmrggtrhhonhhigidrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghu
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:59:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 12:55 AM, Joel Stanley wrote:
> On Thu, 6 Aug 2020 at 13:21, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> The mx25l25635f is an extenstion of the mx25l25635e. It includes QPI
>> support, 4-Byte Address Command Set and faster transfers. See this
>> document for more details :
>>
>> https://www.macronix.com/Lists/ApplicationNote/Attachments/1892/AN0200V1_MGRT_MX25L25635E_25735E%20to%20MX25L25635F_25735F.pdf
>>
>> Both devices have the same 3bytes JEDEC ID: 0xc22019. They can be
>> distinguished with the QPIID command which is only available on
>> mx25l25635f. The mx25l25635f also has a longer JEDEC ID that we can
>> use for the model.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> We don't have support for this one in upstream Linux.

It's detected by testing the 4BYTE operation capability in the SFDP table
in mx25l25635_post_bfpt_fixups()

The only system I have access to is a SuperMicro P9 Boston but I can not
upload a new kernel. However, the FW reports : 

  BMC flash ID: 0xc21920c2
  jedec_id: 0xc21920c2
  flash type: MX25L25635F
  ReadClk=0x32, WriteClk=0x85, EraseClk=0x85
  [smcfw_spi] cpuclk: 198000000 MHz, RefCLK: 24000000 MHz, AXI-AHB ratio: 2:1
  platform_flash: MX25L25635F (32768 Kbytes)


> It's the one
> that Alexander tried to get merged by renaming the mysterious
> mx66l51235l.

Yes. That one behaves a bit more like the mx25l25635e.

Difficult to find a detection pattern. A model for SFDP would help. 

C.

> 
>> ---
>>  hw/block/m25p80.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 605ff55c6756..1696ab1f7821 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -218,6 +218,7 @@ static const FlashPartInfo known_devices[] = {
>>      { INFO("mx25l12805d", 0xc22018,      0,  64 << 10, 256, 0) },
>>      { INFO("mx25l12855e", 0xc22618,      0,  64 << 10, 256, 0) },
>>      { INFO6("mx25l25635e", 0xc22019,     0xc22019,  64 << 10, 512, 0) },
>> +    { INFO("mx25l25635f", 0xc22019,      0xc200,  64 << 10, 512, 0) },
>>      { INFO("mx25l25655e", 0xc22619,      0,  64 << 10, 512, 0) },
>>      { INFO("mx66u51235f", 0xc2253a,      0,  64 << 10, 1024, ER_4K | ER_32K) },
>>      { INFO("mx66u1g45g",  0xc2253b,      0,  64 << 10, 2048, ER_4K | ER_32K) },
>> --
>> 2.25.4
>>


