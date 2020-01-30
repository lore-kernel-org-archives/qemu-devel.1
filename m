Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DD9C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A02206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxKrVjtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A02206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7XS-0003lH-HU
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 05:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1ix7Wg-0003Gf-CC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1ix7Wf-0007Hx-CM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:58:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1ix7Wd-0007Gm-0Z; Thu, 30 Jan 2020 05:58:19 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2EA25206F0;
 Thu, 30 Jan 2020 10:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580381897;
 bh=kueMvnSGUBryO7p/5gsplqvX6z/AIMTx3S0mVvQvfpA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kxKrVjtv75cIYpf9SLjtx+boIm5yaqAukoaSm6ctTK3Tp95iE3XWRlTSsfwKoPIrC
 DXIAswgYP+xuviMf2r6ujtZ8Mksu6w3xucpa3+tbbfZ4zB/rfyOmej7lSnVVvNod+F
 hFUh0JeTqhpyB/4OYcE1izcNAa5u+OHc7zY3kG2g=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1ix7WZ-002APm-Fh; Thu, 30 Jan 2020 10:58:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Jan 2020 10:58:15 +0000
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
In-Reply-To: <4a517e53-9a7c-903a-9fbc-e1aab1cccefb@redhat.com>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <f4699b81-26ac-fcd4-d3fc-f6e055beeb65@redhat.com>
 <9f82206e-0852-ae17-8c77-01d2a5cea97d@redhat.com>
 <51a83889-f2ef-5403-6661-710cfa1ffe01@redhat.com>
 <4a517e53-9a7c-903a-9fbc-e1aab1cccefb@redhat.com>
Message-ID: <503f32a53fb1a81e2612bcf3eff965da@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, jthierry@redhat.com, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, drjones@redhat.com,
 eric.auger@redhat.com, aik@ozlabs.ru, shan.gavin@gmail.com,
 qemu-devel@nongnu.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 Julien Thierry <jthierry@redhat.com>, aik@ozlabs.ru, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gavin,

On 2020-01-29 21:54, Gavin Shan wrote:
> On 1/29/20 6:57 PM, Julien Thierry wrote:
>> On 1/29/20 3:46 AM, Gavin Shan wrote:
>>> On 1/28/20 7:29 PM, Julien Thierry wrote:
> 
> .../...
> 
>>> 
>>> Julien, thanks for the explanation. The question we're not sure if 
>>> NMI should
>>> be injected on receiving HMP/QMP "nmi" command. It means it's not 
>>> clear what
>>> behavior we should have for this command on ARM. However, I have one 
>>> more
>>> unrelated question: "pseudo" NMI on ARM64 should be PPI? I mean SPI 
>>> can't
>>> be "pseudo" NMI.
>>> 
>> 
>> I'm not sure I understand why you say "SPI can't be "pseudo" NMI". 
>> Currently both PPI and SPI are supported in the "pseudo" NMI scheme. 
>> Do you think that should not be the case? If so, can you elaborate?
>> 
>> Thanks,
>> 
> 
> Julien, NMI interrupt is connected to the system by request_nmi() where 
> we have
> a check as below. -EINVAL will be returned from request_nmi() on those
> interrupts
> whose descriptors aren't marked with IRQ_NOAUTOEN. SPI falls into this 
> category.

The IRQ_NOAUTOEN is set on PPIs because you can't enable them all at 
once,
for obvious reasons.

This doesn't mean you cannot set it on other interrupt classes, 
including SPIs.
It is actually a fairly common thing to do when you want to decouple 
requesting
the interrupt from the enabling, if you do not want the interrupt to be 
able to
fire right away.

         M.
-- 
Jazz is not dead. It just smells funny...

