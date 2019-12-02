Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1421C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA59A20672
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA59A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibpLz-0005i7-PN
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 12:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1ibpIe-0004WG-PB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1ibpId-0008Rl-PN
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:15:52 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:49773)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1ibpId-0008OZ-IR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:15:51 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1ibpIa-0004dV-NV; Mon, 02 Dec 2019 18:15:48 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 3/5] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Dec 2019 17:15:48 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <9909b304-9e52-6960-4397-b7d33159cebf@linaro.org>
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-4-maz@kernel.org>
 <0bc7c461-6b92-2782-4aec-2f649f5bc8cf@linaro.org>
 <d2875338d734fca3e5263b94eaf52c18@www.loen.fr>
 <9909b304-9e52-6960-4397-b7d33159cebf@linaro.org>
Message-ID: <d69cc2d0d3f56b2c84d5c73bc5abd9ff@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 213.251.177.50
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-12-02 16:56, Richard Henderson wrote:
> On 12/2/19 4:45 PM, Marc Zyngier wrote:
>>> Annoying that there's a bug in the manual -- FPSID is listed as 
>>> group 0 in
>>> plenty of places, except in the pseudo-code for Accessing the FPSID
>>> which uses TID3.
>>
>> Are you sure? I'm looking at DDI0487E_a,
> ...
>> Or have you spotted a discrepancy
>> somewhere else (which would be oh-so-surprising...)?
>
> In DDI0487E_a, page G8-6028:
>
>> elsif EL2Enabled() && !ELUsingAArch32(EL2) && HCR_EL2.TID3 == '1' 
>> then
>>   AArch64.AArch32SystemAccessTrap(EL2, 0x08);
>> elsif EL2Enabled() && ELUsingAArch32(EL2) && HCR.TID3 == '1' then
>>   AArch32.TakeHypTrapException(0x08);
>> else
>>   return FPSID;
>
> within the summary documentation for FPSID.

Ah, that was too obvious for me to find ;-). Indeed, this looks totally
bogus. I'll try and poke a few people...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

