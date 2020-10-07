Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597CDC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916EF206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916EF206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ32R-00071N-8Z
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 02:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kQ31U-0006ZK-8W; Wed, 07 Oct 2020 02:34:00 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:56807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kQ31R-0004Fz-KQ; Wed, 07 Oct 2020 02:33:59 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.121])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 13BD062CDFF9;
 Wed,  7 Oct 2020 08:33:53 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 7 Oct 2020
 08:33:52 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00283e6032c-6ce9-4096-a9f9-397f3eefb726,
 A1FB6DEFD4FFF4B2E39ADAD8D1A9CF0B60FA0B96) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 0/9] 5p80: Add SFDP support
To: Joel Stanley <joel@jms.id.au>
References: <20200902093107.608000-1-clg@kaod.org>
 <CACPK8XdsX1hfNTw+Eb-=u2AXc8Ww5wVwU0mRnRo=p=d_VBTA0A@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f01f9079-aa22-b84d-1b6d-681bbf410408@kaod.org>
Date: Wed, 7 Oct 2020 08:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XdsX1hfNTw+Eb-=u2AXc8Ww5wVwU0mRnRo=p=d_VBTA0A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 357e581e-74ce-410d-912f-7b8db6d31a87
X-Ovh-Tracer-Id: 7012104623920614249
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeehgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheeutdehgefhvdehtdeuleetgedvfeeukedtfeeihfffffeiuddutdduhffgvedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 01:59:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 3:43 AM, Joel Stanley wrote:
> On Wed, 2 Sep 2020 at 09:31, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> Hello,
>>
>> JEDEC STANDARD JESD216 for Serial Flash Discovery Parameters (SFDP)
>> provides a mean to describe the features of a serial flash device
>> using a set of internal parameter tables. Support in Linux has been
>> added some time ago and the spi-nor driver is using it more often
>> to detect the flash settings and even flash models.
>>
>> This is the initial framework for the RDSFDP command giving access to
>> a private SFDP area under the flash.
>>
>> The patches available here :
>>
>>   https://github.com/legoater/qemu/commits/aspeed-5.2
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Joel Stanley <joel@jms.id.au>
> 
> Note that these need to be rebased on master; there are some minor conflicts.
> 
> These patches have proved essential in debugging a recent kernel
> regression. Thanks for adding this support Cédric.

We have been discussing offline with Francisco of a more subtle approach 
to reduce the size of the definitions of the SFDP tables. I agree that 
the current approach is brutal (and efficient :) but I haven't had time 
to take a close look at his proposal. See below.

    typedef struct SFDPSection {
        const uint32_t addr;
        const uint32_t size;
        const uint32_t wrap_sz;
        const uint8_t *data;
    } SFDPSection;
    
    #define SFDP_RAW(start_addr, vals...) \
    {                                     \
      .addr = start_addr,                 \
      .size = sizeof((uint8_t[]){vals}),  \
      .data = (const uint8_t[]){vals}     \
    }
    
    #define SFDP_RAW_WRAP(start_addr, _wrap_sz, vals...) \
    {                                     \
      .addr = start_addr,                 \
      .size = sizeof((uint8_t[]){vals}),  \
      .wrap_sz = _wrap_sz,                \
      .data = (const uint8_t[]){vals}     \
    }
    
    #define SFDP_TABLE_END() { 0 }
    #define IS_SFDP_END(x) (x.size == 0)
    
    #define M35T4545_WRAP_SZ 0x100
    
    static const SFDPTable m35t4545 = {
        SFDP_RAW_WRAP(0, M35T4545_WRAP_SZ,
                      0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x00, 0xff,
                      0x00, 0x00, 0x01, 0x09, 0x30, 0x00, 0x00, 0xff),
    
        SFDP_RAW(0x38,
                 0xe5, 0x20, 0xfb, 0xff, 0xff, 0xff, 0xff, 0x0f,
                 0x29, 0xeb, 0x27, 0x6b, 0x08, 0x3b, 0x27, 0xbb,
                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x27, 0xbb,
                 0xff, 0xff, 0x29, 0xeb, 0x0c, 0x20, 0x10, 0xd8,
                 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff),
    
        SFDP_TABLE_END()
    };
    
    uint8_t m25p80_sfdp_read(SFDPTable t, uint32_t addr)
    {
        if (t[0].wrap_sz) {
            addr &= (t.wrap_sz-1);
        }
    
        for (int i = 0; !IS_SFDP_END(t[i]); i++) {
            if (addr >= t[i].addr && addr < (t[i].addr + t[i].size)) {
                return t[i].data[addr];
            }
        }
        return 0xFF;
    }


The SFDP header (SFDP_RAW_WRAP) contains the list of the SFDP tables, 
the first being the BFPT at offset 0x30. It would be nice to be able 
to build the list in the header from the different table definitions.

C.



