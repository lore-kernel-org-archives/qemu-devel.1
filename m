Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A77EC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D416D20706
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D416D20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVG0e-0003VC-NC
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 09:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVFvm-0006AL-WC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVFvl-00064s-EN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:17:06 -0500
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:60344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVFvk-00064T-CY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:17:05 -0500
Received: from player692.ha.ovh.net (unknown [10.108.57.245])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id EC95825A18E
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 15:17:01 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 707C9BFD145D;
 Thu, 14 Nov 2019 14:16:54 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] arm/aspeed: Watchdog and SDRAM fixes
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
References: <20191113221301.8768-1-joel@jms.id.au>
 <CAFEAcA8AL6865u8KaY3HjRH19mTP=JUJ3FAgf9VezJYPOEbmBg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3dbfb0eb-4ecb-35b4-9c8d-dec3fd6f083f@kaod.org>
Date: Thu, 14 Nov 2019 15:16:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8AL6865u8KaY3HjRH19mTP=JUJ3FAgf9VezJYPOEbmBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7051792592352807744
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeffedgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.107.29
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/2019 15:04, Peter Maydell wrote:
> On Wed, 13 Nov 2019 at 22:13, Joel Stanley <joel@jms.id.au> wrote:
>>
>> Three of these are fixes for ast2600 models that I found when testing
>> master. The forth is a usability improvement that is helpful when
>> diagnosing why a watchdog is biting.
>>
>> v3 adds some comments and fixes whitespace, and r-b from Alex. Thanks
>> for the review Alex.
>>
>> v2 fixes some review comments from C=C3=A9dric and adds his r-b.
>>
>> Joel Stanley (4):
>>   aspeed/sdmc: Make ast2600 default 1G
>>   aspeed/scu: Fix W1C behavior
>>   watchdog/aspeed: Improve watchdog timeout message
>>   watchdog/aspeed: Fix AST2600 frequency behaviour
>=20
> Were you wanting any of these (or any of the other aspeed
> patches currently on the list) to go into 4.2? None of them
> are specifically marked as for-4.2 bugfixes, and I don't
> know enough about aspeed to be able to judge their importance.

I think we are done for 4.2, although these are relatively=20
simple fixes that could go in 4.2. Nothing critical. As you
wish.

We are preparing, and reviewing, the initial 5.0 patchset=20
which will contain the I2C pool buffer model plus the fixes=20
Joel and I sent.

Thanks,
C.

