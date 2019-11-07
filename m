Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA46EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8864206BA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8864206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSlOq-00078g-SM
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iSlNM-0006KI-P8
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iSlNK-0004RY-OA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:15:16 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:55829)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iSlNJ-0003yu-49
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:15:14 -0500
Received: from player730.ha.ovh.net (unknown [10.108.42.202])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0323C14A527
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 18:15:10 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id D6F68BBE68B0;
 Thu,  7 Nov 2019 17:14:58 +0000 (UTC)
Subject: Re: [PATCH 2/5] ipmi: Add support to customize OEM functions
To: David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>
References: <20191021131215.3693-1-clg@kaod.org>
 <20191021131215.3693-3-clg@kaod.org> <20191021143017.GH25427@t560>
 <20191027174739.GN3552@umbus.metropole.lan>
 <20191027183347.GC2461@minyard.net> <20191107170025.GD2461@umbus.Home>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <156e5bd5-726c-2db5-4b24-394d5ec0f268@kaod.org>
Date: Thu, 7 Nov 2019 18:14:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107170025.GD2461@umbus.Home>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5845109367003712467
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudduledgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.79.46
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
Cc: Joel Stanley <joel@jms.id.au>, "Marty E . Plummer" <hanetzer@startmail.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>> What's the plan for merging this, once it's ready?  Is there an IPMI
>>> tree for it to be staged in?  If not I could take it through the ppc
>>> tree, but I'd need some Acked-bys in that case.
>>
>> I have an IPMI tree for this.  I was assuming it was going in to the PPC
>> tree, but it's not big deal.
> 
> I'd be more comfortable if the generic ipmi changes went through the
> ipmi tree.  

Here is the patch :

	http://patchwork.ozlabs.org/patch/1185187/


> Note that I've moved the initial ppc specific patch from
> my ppc-for-4.2 tree to my ppc-for-4.3 tree, since it missed my
> previous pull request and it's not really post-freeze material.

OK. I was wondering where it had gone.

Thanks,

C.

