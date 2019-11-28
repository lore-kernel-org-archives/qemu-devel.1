Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD58C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 17:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8183521741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 17:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8183521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaNw3-0008HP-Oa
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 12:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iaMlh-0002x7-UY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iaMlg-0004M4-CS
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:35:49 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:39704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1iaMlg-0004Ih-2l
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:35:48 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iaMld-00038D-8Q; Thu, 28 Nov 2019 17:35:45 +0100
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/3] target/arm: More =?UTF-8?Q?HCR=5FEL=32=2ETIDx=20f?=
 =?UTF-8?Q?ixes?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Nov 2019 16:35:45 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <CAFEAcA8GvqnwfGiKHi7OgcUqUu1JL9UKTe6J77-VHMnzRpKX_A@mail.gmail.com>
References: <20191128161718.24361-1-maz@kernel.org>
 <CAFEAcA8GvqnwfGiKHi7OgcUqUu1JL9UKTe6J77-VHMnzRpKX_A@mail.gmail.com>
Message-ID: <782ea75ba2ef3cff597ab07d7128dbc9@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, richard.henderson@linaro.org
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-11-28 16:30, Peter Maydell wrote:
> On Thu, 28 Nov 2019 at 16:17, Marc Zyngier <maz@kernel.org> wrote:
>>
>> I started looking the rest of the missing TIDx handling,
>> and this resulted in the following patches.
>>
>> There is still one thing I'm a bit puzzled by though:
>>
>> HCR_EL2.TID0 mandates trapping of the AArch32 JIDR
>> register, but I couldn't find a trace of it in the QEMU
>> code, and trying to read it seems to generate an exception.
>>
>> It isn't like anyone is going to miss it, but I wonder if
>> it should be implemented... It could also be that I'm missing
>> the obvious and that my testing is broken! ;-)
>
> Hmm, I was under the impression that we correctly implemented
> 'trivial Jazelle', but we obviously missed some of it
> (we do have the handling of BXJ insns).
> We should, yes, ideally, have RAZ/WI implementations
> of JIDR, JMCR and JOSCR.

OK, I'll have a look at this, and plumb the handling of TID0
in JIDR.

> We also I think don't get right the fiddly detail about
> attempting an exception return with SPSR.J set, but that's
> not worth messing about with IMHO.

Indeed. The less we hear about Jazelle, the better... ;-)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

