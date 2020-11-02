Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1A2C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8D02084C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8D02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVg5-0005hx-Nw
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 03:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kZVey-0004v8-It; Mon, 02 Nov 2020 03:57:54 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:41903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kZVet-0004ep-I0; Mon, 02 Nov 2020 03:57:51 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.214])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 7604269F854D;
 Mon,  2 Nov 2020 09:57:30 +0100 (CET)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 2 Nov 2020
 09:57:29 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005037cd79f-0a0c-41e0-8de6-6b1d9e550302,
 8DD5A59BB4BDDF13F63AE8D0997EBD433013A0F2) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 7/30] non-virt: Fix Lesser GPL version number
To: Thomas Huth <thuth@redhat.com>, Chetan Pant <chetan4windows@gmail.com>,
 <qemu-trivial@nongnu.org>
References: <20201016144243.26817-1-chetan4windows@gmail.com>
 <20201016145346.27167-1-chetan4windows@gmail.com>
 <4105debd-5624-4b45-4c95-1a678b764b57@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6a21dc82-2307-8cf6-3c24-035cd16b9b4b@kaod.org>
Date: Mon, 2 Nov 2020 09:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4105debd-5624-4b45-4c95-1a678b764b57@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: b6d973db-4f9d-4d8b-acd5-733036ad6cc4
X-Ovh-Tracer-Id: 14553945146829867814
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddttddguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:57:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 12:39 PM, Thomas Huth wrote:
> On 16/10/2020 16.53, Chetan Pant wrote:
>> There is no "version 2" of the "Lesser" General Public License.
>> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
>> This patch replaces all occurrences of "Lesser GPL version 2" with
>> "Lesser GPL version 2.1" in comment section.
>>
>> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

C. 

>> ---
>>  hw/intc/xics_pnv.c         | 2 +-
>>  hw/ppc/pnv.c               | 2 +-
>>  hw/ppc/pnv_core.c          | 2 +-
>>  hw/ppc/pnv_lpc.c           | 2 +-
>>  hw/ppc/pnv_psi.c           | 2 +-
>>  hw/ppc/pnv_xscom.c         | 2 +-
>>  include/hw/ppc/pnv.h       | 2 +-
>>  include/hw/ppc/pnv_core.h  | 2 +-
>>  include/hw/ppc/pnv_homer.h | 2 +-
>>  include/hw/ppc/pnv_lpc.h   | 2 +-
>>  include/hw/ppc/pnv_occ.h   | 2 +-
>>  include/hw/ppc/pnv_psi.h   | 2 +-
>>  include/hw/ppc/pnv_xscom.h | 2 +-
>>  13 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
>> index 35f3811..753c067 100644
>> --- a/hw/intc/xics_pnv.c
>> +++ b/hw/intc/xics_pnv.c
>> @@ -5,7 +5,7 @@
>>   *
>>   * This library is free software; you can redistribute it and/or
>>   * modify it under the terms of the GNU Lesser General Public License
>> - * as published by the Free Software Foundation; either version 2 of
>> + * as published by the Free Software Foundation; either version 2.1 of
>>   * the License, or (at your option) any later version.
> [...]
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


