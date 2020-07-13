Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F49C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F109206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F109206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxFR-0006Eh-9Q
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juxEj-0005RB-Tf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:07:09 -0400
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:40566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1juxEh-00064H-Ob
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:07:09 -0400
Received: from player687.ha.ovh.net (unknown [10.108.35.185])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 641F916E51F
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:07:05 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 9C90D1444834D;
 Mon, 13 Jul 2020 12:06:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006d8f129a2-5b12-4784-b312-7ece9f41aac6,
 29C60B8BFD44B6CD822E82BF6A6060F4508BB267) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2] ftgmac100: fix dblac write test
To: Erik Smit <erik.lucas.smit@gmail.com>, Andrew Jeffery <andrew@aj.id.au>
References: <20200628142658.29264-1-erik.lucas.smit@gmail.com>
 <df64d8de-9d7f-474b-8b72-5d2e6c7df1f4@www.fastmail.com>
 <CA+MHfovCuasf4RrfZrJwfHx4VOeRNfQ=MTMaFG4=Df8cELZ=EA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f46d2319-e83f-6d4a-97ba-3f91fe57dd3b@kaod.org>
Date: Mon, 13 Jul 2020 14:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfovCuasf4RrfZrJwfHx4VOeRNfQ=MTMaFG4=Df8cELZ=EA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5649765733691001664
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrvdekgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.35.227; envelope-from=clg@kaod.org;
 helo=17.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 08:07:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Cameron Esfahani via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 9:42 AM, Erik Smit wrote:
> Hi Andrew,
> 
> On Mon, 6 Jul 2020 at 03:59, Andrew Jeffery <andrew@aj.id.au> wrote:
>> On Sun, 28 Jun 2020, at 23:56, erik-smit wrote:
>>> The test of the write of the dblac register was testing the old value
>>> instead of the new value. This would accept the write of an invalid value
>>> but subsequently refuse any following valid writes.
>>>
>>> Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
>>> ---
>>> Changes since v1:
>>>
>>> Changed %ld to HWADDR_PRIx to fix building on mingw
>>
>> Bit of a nitpick, but the type of the value argument is uint64_t, so shouldn't
>> the result of the expression captured by FTGMAC100_DBLAC_TXDES_SIZE() and
>> FTGMAC100_DBLAC_RXDES_SIZE() be printed with a straight PRIx64 rather than
>> HWADDR_PRIx?
> 
> You are correct. I didn't understand the meaning of the PRI macros and
> just grabbed the other PRI macro I saw getting used in the file.

With that fixed,

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

