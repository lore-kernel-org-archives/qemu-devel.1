Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F386C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 14:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51B5217D7
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 14:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51B5217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGlxJ-00072q-Qb
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 10:54:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGlwR-0006lR-Uw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGlwQ-0007jr-M2
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:53:39 -0400
Received: from [110.188.70.11] (port=12939 helo=spam1.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGlwO-0007Xc-Mz
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:53:38 -0400
Received: from MK-DB.hygon.cn ([172.23.18.60])
	by spam1.hygon.cn with ESMTP id x3HEr49t059977;
	Wed, 17 Apr 2019 22:53:04 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
	by MK-DB.hygon.cn with ESMTP id x3HEqr4S065316;
	Wed, 17 Apr 2019 22:52:53 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex01.Hygon.cn
	(172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3;
	Wed, 17 Apr 2019 22:53:00 +0800
To: Pavel Hrdina <phrdina@redhat.com>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
Date: Wed, 17 Apr 2019 22:53:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416141700.GR18986@antique-laptop>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
	(172.23.18.10)
X-MAIL: spam1.hygon.cn x3HEr49t059977
X-DNSRBL: 
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 110.188.70.11
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
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
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org,
	ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417145304.zwOxLCarnAeH1lvlipLPmNf5hJWm01Ca3Ue4lTFVf4g@z>

On 2019/4/16 22:17, Pavel Hrdina wrote:
> On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
>> Add a new base CPU model called 'Dhyana' to model processors from Hygon
>> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
>>
>> The following features bits have been removed compare to AMD EPYC:
>> aes, pclmulqdq, sha_ni
>>
>> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
>> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
>> CPU model.
> 
> I have once question that we will have to solve for EPYC CPUs as well.
> The name should not be based on the Product name or Model name as that
> usually doesn't change with introduction of new microarchitecture.
> 
> With EPYC we made a mistake to name the CPU like that, luckily with
> Intel we already use the microarchitecture name, so the EPYC CPU should
> have been named ZEN-Server and for Ryzen CPUs there should be ZEN-Client
> if there is any difference or otherwise we can simply use ZEN.
> 
> The issue here is what happens once the ZEN2 microarchitecture is out
> wihch introduces new features and we will have to come up with a CPU
> name.
> 
> Obviously we cannot change/remove the EPYC models so the question is
> what is the difference between the AMD EPYC CPU and this new Dhyana CPU
> if they are both based on the ZEN microarchitecture?

Right now there's no much difference between Dhyana and EPYC from the 
software's view. Dhyana removed the instructions aes, pclmulqdq, sha_ni 
compared to EPYC, but will have it's own implementation such as for aes 
in future CPU models. Hygon also will implement something different from 
AMD in the future.

> In addition is there any way how we can introduce ZEN-Server &
> ZEN-Client or simply ZEN, if there is no difference, as an alias or a
> new model next to the EPYC?

Also as Eduardo mentioned that there's no CPU model alias or inheritance 
system in x86, so I think it's worthwhile to keep a separate CPU model 
for Hygon.

-- 
Regards,
Pu Wen

