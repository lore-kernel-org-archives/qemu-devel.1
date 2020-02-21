Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09EAC35666
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D9520722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D9520722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5EMY-00080i-W2
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 14:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j5ELo-0007CD-Rb
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j5ELm-0002Xv-VW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:52:40 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:16891)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j5ELm-0002WJ-PX; Fri, 21 Feb 2020 14:52:38 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5E77D74637E;
 Fri, 21 Feb 2020 20:52:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 367CD74637C; Fri, 21 Feb 2020 20:52:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 342DD745953;
 Fri, 21 Feb 2020 20:52:35 +0100 (CET)
Date: Fri, 21 Feb 2020 20:52:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <CAFEAcA9-VzUXij1_vFr+d7KuMOw+Tdv0hvxW2WmfGxt=fAKvjg@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2002212034570.8472@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
 <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
 <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
 <alpine.BSF.2.22.395.2002211807380.69986@zero.eik.bme.hu>
 <CAFEAcA9-VzUXij1_vFr+d7KuMOw+Tdv0hvxW2WmfGxt=fAKvjg@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
 QEMU Developers <qemu-devel@nongnu.org>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020, Peter Maydell wrote:
> On Fri, 21 Feb 2020 at 18:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Fri, 21 Feb 2020, Peter Maydell wrote:
>>> I think that is the wrong approach. Enabling use of the host
>>> FPU should not affect the accuracy of the emulation, which
>>> should remain bitwise-correct. We should only be using the
>>> host FPU to the extent that we can do that without discarding
>>> accuracy. As far as I'm aware that's how the hardfloat support
>>> for other guest CPUs that use it works.
>>
>> I don't know of a better approach. Please see section 4.2.2 Floating-Point
>> Status and Control Register on page 124 in this document:
>>
>> https://openpowerfoundation.org/?resource_lib=power-isa-version-3-0
>>
>> especially the definition of the FR and FI bits and tell me how can we
>> emulate these accurately and use host FPU.
>
> I don't know much about PPC, but if you can't emulate the
> guest architecture accurately with the host FPU, then
> don't use the host FPU. We used to have a kind of 'hardfloat'

I don't know if it's possible or not to emulate these accurately and use 
the FPU but nobody did it for QEMU so far. But if someone knows a way 
please speak up then we can try to implement it. Unfortunately this would 
require more detailed knowledge about different FPU implementations (at 
least X86_64, ARM and PPC that are the mostly used platforms) than what I 
have or willing to spend time to learn.

> support that was fast but inaccurate, but it was a mess
> because it meant that most guest code sort of worked but
> some guest code would confusingly misbehave. Deliberately
> not correctly emulating the guest CPU/FPU behaviour is not
> something I want us to return to.
>
> You're right that sometimes you can't get both speed
> and accuracy; other emulators (and especially ones
> which are trying to emulate games consoles) may choose
> to prefer speed over accuracy. For QEMU we prefer to
> choose accuracy over speed in this area.

OK, then how about keeping the default accurate but allow to opt in to use 
FPU even if it's known to break some bits for workloads where users would 
need speed over accuracy and would be happy to live with the limitation. 
Note that i've found that just removing the define that disables hardfloat 
for PPC target makes VMX vector instructions faster while normal FPU is a 
little slower without any other changes so disabling hardfloat already 
limits performance for guests using VMX even when not using the FPU for 
cases when it would cause inaccuracy. If you say we want accuracy and 
don't care about speed, then just don't disable hardfloat as it helps at 
least VMX and then we can add option to allow the user to say we can use 
hardfloat even if it's inaccurate then they can test their workload and 
decide for themselves.

Regards,
BALATON Zoltan

