Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59898C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04112074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04112074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ5G-0001f8-Sn
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kNZ1R-0006FS-0E; Wed, 30 Sep 2020 06:07:42 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:54285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kNZ1K-0005LL-Lv; Wed, 30 Sep 2020 06:07:40 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.238])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 9CE07606BFDF;
 Wed, 30 Sep 2020 12:07:23 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 30 Sep
 2020 12:07:22 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0053375a314-4bab-471a-b608-cb967ba91a30,
 57637F002EF1FCD73D3EA31567095A3A53C42315) smtp.auth=clg@kaod.org
Subject: Re: [PATCH] hw/arm/aspeed: Map the UART5 device unconditionally
To: Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Cameron Esfahani via <qemu-devel@nongnu.org>
References: <20200905212415.760452-1-f4bug@amsat.org>
 <e640309b-b694-e815-d64d-40dd453e52ef@amsat.org>
 <5e27c1f9-6d11-fa62-ba71-0020ce9d595b@kaod.org>
 <07b21d1d-fb5b-efb0-50f2-54a4b86df444@amsat.org>
 <4648c188-cacc-c532-857c-f0206f60e109@kaod.org>
 <fd68ae45-da39-44fe-b07f-2510481dbf7f@www.fastmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c18df4e1-99ad-8f73-378f-db00a8afa262@kaod.org>
Date: Wed, 30 Sep 2020 12:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fd68ae45-da39-44fe-b07f-2510481dbf7f@www.fastmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 7675ed01-7fb2-443a-8af1-d8875ce138fd
X-Ovh-Tracer-Id: 6402711295669472038
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrfedvgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejhedtveeihffguefgveejieevfeevtddvhefhjeeludevjeeifefhfeefteefueenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegrnhgurhgvfiesrghjrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 06:07:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 7:29 AM, Andrew Jeffery wrote:
> 
> 
> On Fri, 18 Sep 2020, at 02:33, Cédric Le Goater wrote:
>> On 9/17/20 6:57 PM, Philippe Mathieu-Daudé wrote:
>>> On 9/16/20 7:51 AM, Cédric Le Goater wrote:
>>>> On 9/15/20 7:23 PM, Philippe Mathieu-Daudé wrote:
>>>>> ping?
>>>>
>>>> It's reviewed : 
>>>>
>>>>   http://patchwork.ozlabs.org/project/qemu-devel/patch/20200905212415.760452-1-f4bug@amsat.org/
>>>>
>>>
>>> Yes I know :) This is part of my routine to check if a
>>> patch hasn't been confirmed to be queued 1 week after the
>>> last review, to ping the maintainer (because some
>>> automatically flush patches older than 1month in their
>>> mailbox).
>>
>> ooh. That's brutal.
>>
>>>> I will send a PR when I have more patches.
>>>
>>> Ah OK. I didn't know you would keep merging the Aspeed
>>> patches. Since this was a single patch, I thought it would
>>> go via the usual qemu-arm queue from Peter.
>>
>> sure. It could also. Fine with me. I have only three for the
>> moment. 
>>
>>> No rush, I just wanted to be sure the patch was not lost.
>>> Also, once a patch is queued, I understand it is the
>>> maintainer responsibility to keep rebasing the patch
>>> queued.
>>
>> yes. I know. I have been taking care of Andrew's ADC patches 
>> since 2017 ... cough cough :)
> 
> Agh!

Does that mean "I will work on it !" ? :)

C. 


