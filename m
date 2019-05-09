Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357BDC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098FE216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098FE216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOetv-0004EE-CZ
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:59:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOet9-0003sf-Fi
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOet8-0002LT-JD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:58:51 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hOet6-0002GP-CC; Thu, 09 May 2019 04:58:48 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1N336L-1gjRJt27zR-013Pnz; Thu, 09 May 2019 10:58:32 +0200
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190503112654.4393-1-laurent@vivier.eu>
	<80fb3313-239a-5828-94fa-d27137bfcb05@vivier.eu>
	<CAFEAcA_y24gpugttDTR-QrJ0fA7JCQeC0XXsR6pjm2rQ19rfCA@mail.gmail.com>
	<CAFEAcA9ZRSxPK17Zgx0WuhvjyVATL5-0Mp7LvBtv5O4+UGRVyg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2ada4cde-cece-4855-8499-90183a30fb0c@vivier.eu>
Date: Thu, 9 May 2019 10:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ZRSxPK17Zgx0WuhvjyVATL5-0Mp7LvBtv5O4+UGRVyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hD//g/G0xO7zOIplj7ylmP/XovAfqD6TemsDEQUCDjpoQry5z69
	hVtBCxW6ALlSSgw4SI+Y17NKgQp1tjK4I5gXW14QggzSRVWOnZnpsx6uXHMS68HhyiCgHIz
	nCxJlD1aL47RoABSDg4Qa7LolzMlBET2DJ/qJwnO3xtuMhCNd3/J1dJ/HN1tePWVUe53kYd
	X9pCmhKzb9z+9GC0u+Epw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lSlFZALYAOw=:UxjWZCKLPPQ4oHRl83T5T7
	NaVAAN+XExsc3IilnmXW2jE7SjDuPYUjtyCnTWDTk2M0iWGE886TgxN1ESntg2TI3ldjX88MZ
	kFBd+idAy9ektmhNPy8UM2fCm3o11mdglN0yrVG79moMEmbJkAD7+BXit/0eaOZqveSVQoWog
	Q8rkcMo+g11JQB7ex8ss5QyeDk8aHv7p0u62nMx9wcTZYvu534v9s50CbSTLV8Bg+a94UDPMH
	frojwnXTm6kP1CSEx4nk+XC+mqORQs1xI3YTABw95lGWcRePc/WkORiaII/gwvPy5fd2zWKCg
	GReYeppKejgUoCesG8fTw5oJyY1DfRFLAkmgt4mnKoUEoTvILO4h48EJrKC8c2Li+JmnfWRQl
	REFZEQgjuaSWS+6czwaZO+Zy7AODX4J8Owdp4JQDEkGF/rIo+KuZ2mXdDTsTIEF80QzSB+Rjm
	WY6Fk29sV5zhVXKPmPAfDeqnMkCB6uji/ogbW0Sajaj1FgqtHW4jDmTIKohVwActaDxPQYp61
	ta3oMD6PpGdLBXCN08AXUdS4+V6YOn2lyLH5jX+XoYTVfnJjOkbqsLcxfdeSqCcpw+/JwcB4c
	EtGXAokvVWJ/fQLlva0c59fDSltunlvtUyqotNHwTQ0KshQsMAk6gAHEEXspINx3Do399RKwq
	MGwu6F1esK/DVzTNiAFQ+ZQ1t3JvcbTulC/PNUg1ygIXhWv5w0sMNRhNm8IMZJsCQs50fqhQ7
	sXzfM0Cq3dEMZ49O5d4/etjASP0ICwNTCIHTZedk2f+zGJME3HAo+FDlfmU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [PULL v2 00/12] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/05/2019 10:51, Peter Maydell wrote:
> On Tue, 7 May 2019 at 21:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 7 May 2019 at 20:10, Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> Ping ?
>>
>> This is in my queue to process, but there are still a bunch of
>> other pullreqs in the queue too; I am working through them.
> 
> Wait, I'm confused now. Looking back through my emails you
> said "Forget this series, the send has been aborted for an
> unknown reason.". So should I be applying something ?

Yes, it's why I pinged.

I sent the v2 three times because the sent was aborted for an known 
reason two times. The third is the good one.

You must apply this series.

I can send a v3 if your prefer.

Thanks,
Laurent

