Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85F8C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 06:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FEA52073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 06:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEA52073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFutG-0000MV-3P
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 02:14:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hFusP-0008N2-6y
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hFusN-0006vC-PU
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:13:57 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:38262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hFusN-0006rI-GZ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 02:13:55 -0400
Received: from player798.ha.ovh.net (unknown [10.109.143.72])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 90A05EF063
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:13:46 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player798.ha.ovh.net (Postfix) with ESMTPSA id A2A4C4D9E7E3;
	Mon, 15 Apr 2019 06:13:40 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
	<CACPK8Xc_WeP3xuimjTBFRArteecikin9Qj8ZoCW-J2qBY4C=5g@mail.gmail.com>
	<CAFEAcA9t+GUG8PK623gb4v6ZBEhDX_7coOPcgLHDnUXTsrcrvg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c287ed71-59e8-3d7a-f835-1421cba7f6d9@kaod.org>
Date: Mon, 15 Apr 2019 08:13:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9t+GUG8PK623gb4v6ZBEhDX_7coOPcgLHDnUXTsrcrvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2385218956401478464
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -51
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrvdekgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.143
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415061340.Wu1GyWP36sioIS-nmamomjiTvWnOYKenGlsxnfOvvtY@z>

On 4/12/19 1:55 PM, Peter Maydell wrote:
> On Fri, 12 Apr 2019 at 04:17, Joel Stanley <joel@jms.id.au> wrote:
>> vmstate and migration is a foreign concept for the small ARM machines.
>> As well as being a developer, I am an end user of Qemu for them (the
>> aspeeds, microbit), and the use case is to boot up a firmware and
>> check that it does correct thing. I've never considered saving the
>> state and resming it, and can't think of a situation where that would
>> be done.
> 
> It's a really useful debugging tool:
>  https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/

yes.  Our Aspeed machines migrate quite well today and, who knows,
we might want one day to run Aspeed VMs on the "cloud". I doubt it 
but, anyway, it's really not complex to do either.

Thanks,

C. 

