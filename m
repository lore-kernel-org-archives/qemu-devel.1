Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C6AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10D8206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10D8206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6f1-00059D-Of
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kD6dr-00043k-6w; Tue, 01 Sep 2020 09:48:07 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:49847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kD6dn-0000l6-Ry; Tue, 01 Sep 2020 09:48:06 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.149])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 3B439564199A;
 Tue,  1 Sep 2020 15:48:00 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 15:47:59 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0051a96b3e1-278c-45df-8a5c-e50aa7a49441,
 38EE1E9FF4E34D4C85F4190D418CEE501B878519) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 2/2] m25p80: Add the n25q256a SFDP table
To: Francisco Iglesias <frasse.iglesias@gmail.com>
References: <20200827091130.3525790-1-clg@kaod.org>
 <20200827091130.3525790-3-clg@kaod.org>
 <20200901133840.caw6abo4noq5choz@fralle-msi>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0a2bcbfa-833d-358a-6699-298f64918549@kaod.org>
Date: Tue, 1 Sep 2020 15:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901133840.caw6abo4noq5choz@fralle-msi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 6872353f-00a0-41c6-b53c-97fa054bcfac
X-Ovh-Tracer-Id: 5841168718214826857
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheeutdehgefhvdehtdeuleetgedvfeeukedtfeeihfffffeiuddutdduhffgvedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepfhhrrghsshgvrdhighhlvghsihgrshesghhmrghilhdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 08:45:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:38 PM, Francisco Iglesias wrote:
> Hi Cedric,
> 
> We need to rebase the patch and modify for meson build (I wasn't able to apply
> it).

Yes. You will find the patches and more support on my aspeed branch :

  https://github.com/legoater/qemu/tree/aspeed-5.2

  23c93a8f69c8 m25p80: Add the w25q512jv SFPD table
  51c73585a3a0 m25p80: Add the w25q256 SFPD table
  c1d31a41dd38 m25p80: Add the mx66l1g45g SFDP table
  4c66b8670fe2 m25p80: Add the mx25l25635f SFPD table
  070620851124 m25p80: Add the mx25l25635e SFPD table
  a51a58218157 m25p80: Add the n25q256a SFDP table
  bd6574bba30a m25p80: Add basic support for the SFDP command


Thanks,

C. 

> Best regards,
> Francisco 
> 
> On [2020 Aug 27] Thu 11:11:30, Cédric Le Goater wrote:
>> The same values were collected on 4 differents OpenPower systems,
>> palmettos, romulus and tacoma.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  hw/block/m25p80_sfdp.h |  2 ++
>>  hw/block/m25p80.c      |  6 ++++--
>>  hw/block/m25p80_sfdp.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>>  hw/block/Makefile.objs |  2 +-
>>  4 files changed, 56 insertions(+), 3 deletions(-)
>>  create mode 100644 hw/block/m25p80_sfdp.c
>>
>> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
>> index b75fd0b0c13f..ca2658a676e0 100644
>> --- a/hw/block/m25p80_sfdp.h
>> +++ b/hw/block/m25p80_sfdp.h
>> @@ -12,4 +12,6 @@
>>  
>>  #define M25P80_SFDP_AREA_SIZE 0x100
>>  
>> +extern const uint8_t m25p80_sfdp_n25q256a[M25P80_SFDP_AREA_SIZE];
>> +
>>  #endif
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 32925589ec7a..d053bdbb2805 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -233,11 +233,13 @@ static const FlashPartInfo known_devices[] = {
>>      { INFO("n25q128a11",  0x20bb18,      0,  64 << 10, 256, ER_4K) },
>>      { INFO("n25q128a13",  0x20ba18,      0,  64 << 10, 256, ER_4K) },
>>      { INFO("n25q256a11",  0x20bb19,      0,  64 << 10, 512, ER_4K) },
>> -    { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K) },
>> +    { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K),
>> +      .sfdp = m25p80_sfdp_n25q256a },
>>      { INFO("n25q512a11",  0x20bb20,      0,  64 << 10, 1024, ER_4K) },
>>      { INFO("n25q512a13",  0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>>      { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
>> -    { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
>> +    { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K),
>> +      .sfdp = m25p80_sfdp_n25q256a },
>>      { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>>      { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>>      { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>> diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
>> new file mode 100644
>> index 000000000000..def94bd4ea02
>> --- /dev/null
>> +++ b/hw/block/m25p80_sfdp.c
>> @@ -0,0 +1,49 @@
>> +/*
>> + * M25P80 Serial Flash Discoverable Parameter (SFDP)
>> + *
>> + * Copyright (c) 2020, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "m25p80_sfdp.h"
>> +
>> +/*
>> + * Micron
>> + */
>> +const uint8_t m25p80_sfdp_n25q256a[M25P80_SFDP_AREA_SIZE] = {
>> +    0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x00, 0xff,
>> +    0x00, 0x00, 0x01, 0x09, 0x30, 0x00, 0x00, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xe5, 0x20, 0xfb, 0xff, 0xff, 0xff, 0xff, 0x0f,
>> +    0x29, 0xeb, 0x27, 0x6b, 0x08, 0x3b, 0x27, 0xbb,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x27, 0xbb,
>> +    0xff, 0xff, 0x29, 0xeb, 0x0c, 0x20, 0x10, 0xd8,
>> +    0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>> +};
>> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
>> index 8855c2265639..b65a12c52b52 100644
>> --- a/hw/block/Makefile.objs
>> +++ b/hw/block/Makefile.objs
>> @@ -1,6 +1,6 @@
>>  common-obj-y += block.o cdrom.o hd-geometry.o
>>  common-obj-$(CONFIG_FDC) += fdc.o
>> -common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
>> +common-obj-$(CONFIG_SSI_M25P80) += m25p80.o m25p80_sfdp.o
>>  common-obj-$(CONFIG_NAND) += nand.o
>>  common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
>>  common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
>> -- 
>> 2.25.4
>>


