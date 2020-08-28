Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C317C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE152078A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE152078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBYOd-0005Sy-JL
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 03:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kBYNj-0004dE-EO; Fri, 28 Aug 2020 03:01:03 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:51837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kBYNg-0004Am-G4; Fri, 28 Aug 2020 03:01:03 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.121])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id D21BB5B7244E;
 Fri, 28 Aug 2020 09:00:55 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 28 Aug
 2020 09:00:55 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0016507b4ff-0b1a-473b-9cb2-b4bc605d9a2a,
 83DB9928FED85C7E3E19C59E4C9B962512512EEC) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 02/21] m25p80: Add support for mx25l25635f
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200819100956.2216690-1-clg@kaod.org>
 <20200819100956.2216690-3-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <beba8cfb-9747-b2f9-6e8d-ed0d8754f92c@kaod.org>
Date: Fri, 28 Aug 2020 09:00:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819100956.2216690-3-clg@kaod.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: d511b321-1da8-475f-a6d2-dd9f8cc3d416
X-Ovh-Tracer-Id: 12368854902898068387
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddviedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeludeuleekhfduffektdeifeehvefgkeehgfduueehueelvdeklefgffduleduleenucffohhmrghinhepmhgrtghrohhnihigrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 03:00:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.782,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 12:09 PM, Cédric Le Goater wrote:
> The mx25l25635f is an extenstion of the mx25l25635e. It includes QPI
> support, 4-Byte Address Command Set and faster transfers. See this
> document for more details :
> 
> https://www.macronix.com/Lists/ApplicationNote/Attachments/1892/AN0200V1_MGRT_MX25L25635E_25735E%20to%20MX25L25635F_25735F.pdf
> 
> Both devices have the same 3bytes JEDEC ID: 0xc22019. They can be
> distinguished with the QPIID command which is only available on
> mx25l25635f and their Serial Flash Discoverable Parameters. However,
> some FW use the JEDEC ID. For instance, on a SuperMicro P9 Boston, the
> BMC FW reports :
> 
>   BMC flash ID: 0xc21920c2
>   jedec_id: 0xc21920c2
>   flash type: MX25L25635F
>   ReadClk=0x32, WriteClk=0x85, EraseClk=0x85
>   [smcfw_spi] cpuclk: 198000000 MHz, RefCLK: 24000000 MHz, AXI-AHB ratio: 2:1
>   platform_flash: MX25L25635F (32768 Kbytes)
> 
> Define the mx25l25635f with an extended JEDEC ID.

I am starting to think this is a broken driver or a very exotic HW. 
We have a couple of mx25l25635f on other openpower systems and the 
returned JEDEC ID is 0xc21920c21920.

I will keep this patch on the side for now.

Thanks,

C. 

> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/block/m25p80.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 605ff55c6756..1696ab1f7821 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -218,6 +218,7 @@ static const FlashPartInfo known_devices[] = {
>      { INFO("mx25l12805d", 0xc22018,      0,  64 << 10, 256, 0) },
>      { INFO("mx25l12855e", 0xc22618,      0,  64 << 10, 256, 0) },
>      { INFO6("mx25l25635e", 0xc22019,     0xc22019,  64 << 10, 512, 0) },
> +    { INFO("mx25l25635f", 0xc22019,      0xc200,  64 << 10, 512, 0) },
>      { INFO("mx25l25655e", 0xc22619,      0,  64 << 10, 512, 0) },
>      { INFO("mx66u51235f", 0xc2253a,      0,  64 << 10, 1024, ER_4K | ER_32K) },
>      { INFO("mx66u1g45g",  0xc2253b,      0,  64 << 10, 2048, ER_4K | ER_32K) },
> 


