Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46A3206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46A3206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvc4p-0005MZ-UG
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 03:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jvc40-0004r9-Ds
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:42:48 -0400
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:55393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jvc3y-0001WH-CL
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 03:42:48 -0400
Received: from player759.ha.ovh.net (unknown [10.110.103.199])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 2BDAF21D43E
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 09:42:41 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-1163-216.w90-76.abo.wanadoo.fr
 [90.76.222.216]) (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id B8476145F7BDC;
 Wed, 15 Jul 2020 07:42:30 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0024ac65c9e-140e-488a-86be-e40f045741a8,D1878713575E7557A8ED5F979EF3ECB62B482302)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9a1567f0-f13c-326d-460f-6ad167bcf523@kaod.org>
Date: Wed, 15 Jul 2020 09:42:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12930116007037930451
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfedugdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeekhfetudefffevvdeljeeggeehvdegueeiueefjeeuledtudegudehvdevlefgheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdeltddrjeeirddvvddvrddvudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.171.146; envelope-from=clg@kaod.org;
 helo=9.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 03:42:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>, IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 4:56 AM, Havard Skinnemoen wrote:
> On Mon, Jul 13, 2020 at 7:57 AM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>> This allows these NPCM7xx-based boards to boot from a flash image, e.g.
>>> one built with OpenBMC. For example like this:
>>>
>>> IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
>>> qemu-system-arm -machine quanta-gsj -nographic \
>>>       -bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
>>>       -drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on
>>>
>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>
>> May be we don't need to create the flash object if dinfo is NULL.
> 
> It's soldered on the board, so you can't really boot the board without
> it. But if you think it's better to remove it altogether if we don't
> have an image to load into it, I can do that.
> 
>>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> Tested-by: Cédric Le Goater <clg@kaod.org>
>>
>> Nice !
>>
>> We need a SPI controller model and a network device model now.
> 
> Yeah, and i2c, PWM, GPIO, etc., but if you're referring to the kernel
> crash, see below.

We don't need all device models but fixing the crash would be better. 

>> npcm7xx_bootrom.bin is a bit of a pain. Could we include it in
>> the QEMU roms ?
> 
> Yeah, I was planning to include this in v6.

Good. It will ease CI.

>> spi_master spi0: /ahb/fiu@fb000000/spi-nor@0 has no valid 'spi-max-frequency' property (-22)
>> spi_master spi0: Failed to create SPI device for /ahb/fiu@fb000000/spi-nor@0
> 
> This is a device tree bug:
> 
> https://github.com/hskinnemoen/openbmc/commit/99b172f88002f4fac939f85debe1187b9c569871
> 
>> libphy: Fixed MDIO Bus: probed
>> 8<--- cut here ---
>> Unable to handle kernel paging request at virtual address fffffffe
> 
> I believe this is a kernel bug:
> 
> https://github.com/hskinnemoen/openbmc/commit/77e9f58ba157eabc976f15fa49892128fe2b2382
> 
> I needed two additional patches to get all the way to the login prompt:
> 
> https://github.com/hskinnemoen/openbmc/commits/20200711-gsj-qemu-0
 

Great. So are these for mainline or Joel's openbmc branch ? 

Thanks,

C.

