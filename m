Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DF6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA0F20578
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA0F20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATGg-0003k6-27
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kATFi-00036K-QN; Tue, 25 Aug 2020 03:20:18 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:34931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kATFg-0000OM-Cs; Tue, 25 Aug 2020 03:20:18 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.97])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id ABB7153BA8A6;
 Tue, 25 Aug 2020 09:20:04 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 25 Aug
 2020 09:20:03 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0042c929d5f-dbac-4368-bcac-a9b3146f5f02,
 1B83AABA3ADBE1952DEB3404AC7FA9E3DEF307C0) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 00/21] aspeed: cleanups and some extensions
To: Joel Stanley <joel@jms.id.au>
References: <20200819100956.2216690-1-clg@kaod.org>
 <CACPK8XcHq6uhg87LO0Kyeqxky0+avTkvshgssRuNz6pcpyQi=Q@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1c86b601-6ac1-1bd4-18d9-cef5b3c4fc8b@kaod.org>
Date: Tue, 25 Aug 2020 09:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XcHq6uhg87LO0Kyeqxky0+avTkvshgssRuNz6pcpyQi=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: fcd5b932-9145-4c80-ab42-feee8123d8f3
X-Ovh-Tracer-Id: 13520931982033390499
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudduledguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuteeufedvieevffdufffgheefgffhvefhvdehkedtgedvhfekteeffedufeehffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhmrghkvghfihhlvgdrnhhinhhjrgenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 03:20:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.25,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 8:01 AM, Joel Stanley wrote:
> On Wed, 19 Aug 2020 at 10:10, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> Hello,
>>
>> This series includes various fixes improving the support of Aspeed
>> machines. Extra attention was given to the robustness of the ftgmac100
>> model. A small kernel module tester was created for this purpose :
>>
>>    https://github.com/legoater/ftgmac100-test/
> 
> I gave this a test and it successfully broke the machine for me
> without your fixes.

The network stack is busted. yes. Sometimes it survives or does a reset.

HW always survives which is surprising.

Thanks, 

C.

> I tried to test this series but the new build system stopped me from
> being able to complete a build. It failed with:
> 
> Found ninjatool-1.8 at qemu/upstream/build/ninjatool
> ./ninjatool -t ninja2make --omit clean dist uninstall < build.ninja >
> Makefile.ninja
> /bin/sh: build.ninja: No such file or directory
> 
> :(
> 
>>
>> Changes in v2 :
>>
>>  - definitions for some new flash models in m25p80 by Igor
>>  - All Joel's comments should have been addressed
>>  - A better fix of the integer overflow in ftgmac100_do_tx suggested
>>    by Peter.
>>
>>
>> This needs a couple more reviewed-by before I can send a PR.
> 
> I have read through all the patches and I have no objections.
> 
> Cheers,
> 
> Joel
> 
>>
>> Thanks,
>>
>> C.
>>
>> Cédric Le Goater (16):
>>   m25p80: Return the JEDEC ID twice for mx25l25635e
>>   m25p80: Add support for mx25l25635f
>>   m25p80: Add support for n25q512ax3
>>   aspeed/scu: Fix valid access size on AST2400
>>   aspeed/smc: Fix MemoryRegionOps definition
>>   aspeed/smc: Fix max_slaves of the legacy SMC device
>>   aspeed/sdhci: Fix reset sequence
>>   ftgmac100: Fix registers that can be read
>>   ftgmac100: Fix interrupt status "Packet transmitted on ethernet"
>>   ftgmac100: Fix interrupt status "Packet moved to RX FIFO"
>>   ftgmac100: Change interrupt status when a DMA error occurs
>>   ftgmac100: Check for invalid len and address before doing a DMA
>>     transfer
>>   ftgmac100: Fix integer overflow in ftgmac100_do_tx()
>>   ftgmac100: Improve software reset
>>   aspeed/sdmc: Simplify calculation of RAM bits
>>   aspeed/smc: Open AHB window of the second chip of the AST2600 FMC
>>     controller
>>
>> Igor Kononenko (2):
>>   arm: aspeed: add strap define `25HZ` of AST2500
>>   hw: add a number of SPI-flash's of m25p80 family
>>
>> Joel Stanley (2):
>>   aspeed/sdmc: Perform memory training
>>   aspeed/sdmc: Allow writes to unprotected registers
>>
>> erik-smit (1):
>>   hw/arm/aspeed: Add board model for Supermicro X11 BMC
>>
>>  include/hw/misc/aspeed_scu.h  |   1 +
>>  include/hw/misc/aspeed_sdmc.h |  13 +++-
>>  hw/arm/aspeed.c               |  35 ++++++++++
>>  hw/block/m25p80.c             |   6 +-
>>  hw/misc/aspeed_scu.c          |   9 +--
>>  hw/misc/aspeed_sdmc.c         | 125 +++++++++++++++++++---------------
>>  hw/net/ftgmac100.c            |  95 ++++++++++++++++++--------
>>  hw/sd/aspeed_sdhci.c          |  14 +++-
>>  hw/ssi/aspeed_smc.c           |   6 +-
>>  9 files changed, 209 insertions(+), 95 deletions(-)
>>
>> --
>> 2.25.4
>>


