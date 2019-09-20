Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC01C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 06:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A382080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 06:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A382080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBCVp-0002uQ-Ih
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 02:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iBCU5-0000ud-8N
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iBCGn-0003Ju-AX
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:19:55 -0400
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:36132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iBCGl-0003DN-7y
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:19:51 -0400
Received: from player758.ha.ovh.net (unknown [10.109.143.223])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7488B18DDFF
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 08:19:40 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id D1F0FA0DD478;
 Fri, 20 Sep 2019 06:19:31 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 00/21] aspeed: Add support for the AST2600 SoC
To: Andrew Jeffery <andrew@aj.id.au>, no-reply <no-reply@patchew.org>,
 qemu-devel@nongnu.org
References: <156892658765.2125.17871103047730488122@1c8ae44fe5c0>
 <d0707b66-4446-457b-a5fa-2b4225db9ad5@www.fastmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e2a8d5a7-40b2-fde6-b84b-cd0d4eed2e1d@kaod.org>
Date: Fri, 20 Sep 2019 08:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d0707b66-4446-457b-a5fa-2b4225db9ad5@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8033014362241338323
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddugddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.97.206
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

On 20/09/2019 05:34, Andrew Jeffery wrote:
> 
> 
> On Fri, 20 Sep 2019, at 06:26, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20190919055002.6729-1-clg@kaod.org/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-quick@centos7 build test. Please find the 
>> testing commands and
>> their output below. If you have Docker installed, you can probably 
>> reproduce it
>> locally.
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> make docker-image-centos7 V=1 NETWORK=1
>> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
>> === TEST SCRIPT END ===
>>
>> libudev           no
>> default devices   yes
>>
>> warning: Python 2 support is deprecated
>> warning: Python 3 will be required for building future versions of QEMU
>> cross containers  no
>>
>> NOTE: guest cross-compilers enabled: cc
>> ---
>> Property '.cntfrq' not found
> 
> Ah, we should drop the patch introducing the CNTFRQ configuration for the 2600
> as well given the patch adding support to configure it isn't part of the series.

yes. I will move it behind in my branch.

Thanks,

C. 

