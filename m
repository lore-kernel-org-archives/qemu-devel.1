Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE4C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAF72073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAF72073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGIGU-0001Ab-Ht
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 03:12:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGIFZ-0000mG-JV
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGIFY-0004dC-EP
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:11:25 -0400
Received: from [110.188.70.11] (port=21974 helo=spam1.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGIFX-0004aM-Mk
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:11:24 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
	by spam1.hygon.cn with ESMTP id x3G7Ajk0085144;
	Tue, 16 Apr 2019 15:10:45 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
	by MK-FE.hygon.cn with ESMTP id x3G7AB3x014210;
	Tue, 16 Apr 2019 15:10:11 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from [172.20.20.110] (172.23.18.44) by cncheex02.Hygon.cn
	(172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3;
	Tue, 16 Apr 2019 15:10:43 +0800
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415203917.GA32317@habkost.net>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <33dc5293-8791-4508-d796-efd6c49272d5@hygon.cn>
Date: Tue, 16 Apr 2019 15:09:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415203917.GA32317@habkost.net>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex02.Hygon.cn
	(172.23.18.12)
X-MAIL: spam1.hygon.cn x3G7Ajk0085144
X-DNSRBL: 
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 110.188.70.11
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
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
Cc: "mst@redhat.com" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416070953.2WvL9GqwwRhaaxZsPO9iVym4pFURh9kIw5IEKcJ_LU4@z>

On 2019/4/16 4:40, Eduardo Habkost wrote:
> On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
>> Add a new base CPU model called 'Dhyana' to model processors from Hygon
>> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
>>
>> The following features bits have been removed compare to AMD EPYC:
>> aes, pclmulqdq, sha_ni
>>
>> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
>> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
>> CPU model.
>>
>> Reference:
>> [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
>>
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
> 
> Thanks for the patch.
> 
> I'm wondering if we should let the CPU model be used only on
> Hygon hosts, to avoid confusion.

Yes, it should be. But how to achieve this?

-- 
Regards,
Pu Wen

