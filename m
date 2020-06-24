Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444A2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D532078D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D532078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo95m-0006vy-Ce
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jo8o1-0003Zl-NA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 13:03:25 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:46037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jo8nz-0005JT-6n
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 13:03:25 -0400
Received: from player795.ha.ovh.net (unknown [10.108.35.103])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 74799288E84
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 19:03:13 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 2C49213950807;
 Wed, 24 Jun 2020 17:03:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00569df303c-7093-4f3f-af98-080a0189bc4b,E10FFB909967CDEE565F5962A97A61CD472B7760)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v4 6/8] hw/arm/aspeed: Describe each PCA9552 device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-7-f4bug@amsat.org>
 <38918d0a-272f-c05c-6a03-c6ddd8cc592e@kaod.org>
 <a046bcd2-1937-d971-8a1c-23fae0dfc9b1@amsat.org>
 <CAAdtpL4vFQaD_7uUvVAOy34ySXrZCQWnALM9=FOfVZo3750ufg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c33ab0f8-e0b9-9b98-5fb2-24ac6aef67b7@kaod.org>
Date: Wed, 24 Jun 2020 19:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4vFQaD_7uUvVAOy34ySXrZCQWnALM9=FOfVZo3750ufg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9750574671788542737
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekjedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieefheetueejvdduudevvddvvdefieefkeeitdejleeuffdthffhteelveevheeknecuffhomhgrihhnpehosghsvghrvhgrsghlvghhqhdrtghomhenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.51.82; envelope-from=clg@kaod.org;
 helo=14.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 13:03:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 6:54 PM, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> On Mon, Jun 22, 2020 at 10:35 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 6/22/20 8:49 AM, Cédric Le Goater wrote:
>>> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>>>> We have 2 distinct PCA9552 devices. Set their description
>>>> to distinguish them when looking at the trace events.
>>>
>>> It's nice and usefull but couldn't we do the same with a QOM object name ?
>>
>> qdev inherits QOM and overloads it with the qdev_ API.
>> Since we have a qdev object, isn't it better to use the qdev_ API?
>>
>> I'd keep the QOM API for bare QOM objects.(I find confusing to use
>> different APIs).
> 
> FYI you can get an idea of the QOM -> qdev -> sysbus -> ... tree here:
> https://observablehq.com/@philmd/qemu-aarch64-softmmu-qom-tree
> 

nice ! 

Thanks,

C.

