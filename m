Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FFC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3164921741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZdU/2UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3164921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl1P-0007kQ-8H
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1izkz3-0005ot-OC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1izkz2-0002hW-H1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1izkyx-0002Pg-L1; Thu, 06 Feb 2020 12:30:27 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6C6421741;
 Thu,  6 Feb 2020 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581010225;
 bh=O09wmBQDGjMvuEahncvzprNfE4F9flL20Vq1HRYdJng=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SZdU/2UA6tSSMSiqc1MjeWT40i+MWgDaMKYsJhNaqoQYU3+fyTUgGMdcPbZ+TuAsR
 fO4YD32UxHE1aRTQ3Sb4/Xx3VbhbF58x8rHcbZsHgnuCsjIueKldg/QDXQqZIaMaCK
 7wv64zKBXvSl2H/rpYPgM35t3kiMeFQoCQ2UO4sY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1izkyt-003N8T-Ma; Thu, 06 Feb 2020 17:30:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Feb 2020 17:30:23 +0000
From: Marc Zyngier <maz@kernel.org>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [RFC v2 00/14] Add SDEI support for arm64
In-Reply-To: <c67c1563-045f-a5f8-8b8b-97d792aa1912@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <CAFEAcA-+tAbb9h2wZOm56TqUvjQJT0OYFLwTVS-UxKrF5PO3mQ@mail.gmail.com>
 <5aece614-4341-35e5-53a6-2f3d788e6e8d@huawei.com>
 <e8b93460-48e6-43cd-4608-370c07cb45ec@huawei.com>
 <350aa4ca1b57a466ed882236caf23051@kernel.org>
 <c67c1563-045f-a5f8-8b8b-97d792aa1912@huawei.com>
Message-ID: <f8394aafb2adb513186cd2784a1cb077@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: guoheyi@huawei.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com,
 Dave.Martin@arm.com, mark.rutland@arm.com, james.morse@arm.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, shannon.zhaosl@gmail.com,
 imammedo@redhat.com, gshan@redhat.com
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-02-06 01:20, Heyi Guo wrote:
> Hi Marc,
> 
> On 2020/2/5 21:15, Marc Zyngier wrote:
>> Hi Heyi,
>> 
>> On 2020-02-04 08:26, Heyi Guo wrote:
>>> Update Marc's email address.
>>> 
>>> +cc Gavin as he is posting a RFC for ARM NMI.
>>> 
>>> Hi Marc,
>>> 
>>> Really sorry for missing to update your email address, for the 
>>> initial
>>> topic was raised long time ago and I forgot to update the Cc list in
>>> the commit message of the patches.
>>> 
>>> Thanks Gavin for forwarding current discussion on ARM NMI to me.
>>> 
>>> For you said SDEI is "horrible", does it mean we'd better never
>>> implement SDEI in virtual world? Or do you have any advice on how to
>>> implement it?
>> 
>> My concern is that SDEI implies having EL3. EL3 not being 
>> virtualizable
>> with KVM, you end-up baking SDEI in *hardware*. Of course, this 
>> hardware
>> is actually software (it is QEMU), but this isn't the way it was 
>> intended.
> 
>> 
>> It's not the first time we've done that (PSCI is another example), but 
>> the
>> logic behind SDEI looks much more invasive.
> 
> Thanks for your comments.
> 
> Thinking about them for quite a while, below is my understanding,
> please correct me if I'm wrong:
> 
> So should the KVM based virtual machine be treated as one with CPUs
> only having NS-EL1 and NS-EL0, ideally? And SDEI messes up this model,
> isn't it?

Well, that's exactly what it is (until we have nested virt, in which 
case
you will be able to add NS-EL2 to the mix).

> PSCI only contains some one-shot operations, so it is much less
> invasive than SDEI.
> 
> 
> I've another question. The origin of "virtual" SDEI requirement comes
> from the lack of hard lockup detector in VM.

Sure. But nothing guarantees that the guest is going to register a SDEI
entry point anyway.

> We can have some kind of
> watchdog, but how can the watchdog trigger the VM OS to panic and run
> kdump, even in irq-off state?

Nothing. All the events, including SDEI, are maskable, one way or 
another.

Gavin's approach to inject a SError is probably OK for Linux, given that
it tends to run with PSTATE.A==0. But that's not a guarantee either (if
you take a recursive exception, SError won't be delivered).

The long and the short of it is that there is no way to do what you want
with absolute guarantees on the ARM architecture. It just doesn't exist.

         M.
-- 
Jazz is not dead. It just smells funny...

