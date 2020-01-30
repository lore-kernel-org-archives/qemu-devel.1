Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C66C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DB5206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DB5206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7tJ-0003Uj-EW
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ix7sY-00033a-0K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ix7sW-0007br-Mp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:20:57 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ix7sW-0007bA-Cc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:20:56 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MQMm9-1jAeY60gNN-00MMjW; Thu, 30 Jan 2020 12:20:51 +0100
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <CAL1e-=ghxDLcU3iqkZ8q_sbk_DyR70t2a-jFtoNDVa7iTkMXsQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3d768689-b69f-02d9-b3b1-0c5a9a68df89@vivier.eu>
Date: Thu, 30 Jan 2020 12:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ghxDLcU3iqkZ8q_sbk_DyR70t2a-jFtoNDVa7iTkMXsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dTPmWtp0DmT/iKIA7sfsH4HWCej2NCOl3RhN6L58t4ifbyULFa/
 9obZVlU07LsEg1vcWaqMgIbz4e5ldbsMfqYJzDWfiIRnd3jc/obS5UCbzgRvQwzP78I0Gi5
 +ZmmPLsqgko6QP+FKwYu1NYsUhD+3yjOD4mIs36u+n+Fa6lrVcSdF7VBow9cFHCx0wJ9vvG
 XWJyi3wUDcr0Putp6bA3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TtIKymfVmX0=:PvG+6ERK4jznjfvQmrM1IK
 hrAPz2pV4BEpSP1aGJDf5+jdx2cXtmKxMsKTz3YkTv1G1U7yMS1v8Gk+PvcFrIurjnEkSL8M1
 VAfTn4bZxuFhcD/vAl+8Kiork3X0KUMyxNIOc136GSYzDpBrC8EkiEbAxF5BsgguHo3Tp8rUY
 27wWOuNt/Pi/KIKl1kmELUPpcb/W+GlEK+wxa1/k3ha79CuDydrsv1yQ0wqTbJZ9PozLmfMyQ
 lJfmPYBDvAobUQwVFJIvWZ/uf/SMCI8PcReHELNimGfALbNX55WEmNkyZPpMJlEiZW6V15lZU
 Btj0SNuogZPQUPDM2MmRTlqPUeFMmHlr/t6O0ksp3Wuj7ry6/VI6KNAKmki9NuImQuXl+cZe+
 HmOdHIrCbg8hYBZEBpHWQFisbo12T/ic/b9ULYQF+g7PVikgECX1+23XvR0i1n1/C3nu8DKw7
 ZXooUImJXehIkDfAfkDRkRNVe4vrLOmYUBLnz1PlrFiCP27p7bcsmjDgAdFxK98Bius6w8e09
 spZVT5p53xjodUgi/Zf6431/dTg+b8Y+6FHeNTJSWh7KCm5RuB3a8UToHJioBdRlAb40N5Byl
 P4YsYwqMfCYCFru5OCPySp4qqKPyKqpEaJxbdNI7o3HF1VsrBt11XS6gIENDgUVVM9Q/EWKdj
 lHMIb4CJVpJi7yuEFuN2evlL/tsz3Lo5P//84NRmXXmka5qcBXHDaBGb4Qc4a/7dj9rjPLkjt
 TM0LRwtwzlhN0Ow1zzVll+MByfWfjlaDkxo+H6qAMHz/skj8HagCVFm8J/BpAYH7uAm2fKsSq
 kpTAnFCk+YCuWI2ZYg1ffLusiEqC5+JoxL9h5kC/F88g0M5EArnNYRfMYuTXxnXzqQ4qJsB
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/01/2020 à 12:09, Aleksandar Markovic a écrit :
> 14:34 Čet, 23.01.2020. Aleksandar Markovic <aleksandar.m.mail@gmail.com
> <mailto:aleksandar.m.mail@gmail.com>> је написао/ла:
>>
>> Extend support for ioctls in QEMU linux-user mode
>>
>>
>> PLANNED ACTIVITIES
>>
>> BACKGROUND
>>
>> There is currently 2500+ ioctls defined in Linux kernel. QEMU
> linux-user currently supports only several hundred. There is a constant
> need for expanding ioctl support in QEMU. Users use Linux-user mode in
> variety of setups (for example, building and testing tools and
> applications under chroot environment), and, on a regular basis, efforts
> by multiple people are made to fill in missing support. However, these
> efforts have been usually done on a piece-by-piece basis, i a limited
> way covering a partucular need. This project will take more proactive
> stance, and try to improve QEMU before users start complaining.
>>
>> PART I:
>>
>>    a) Add strace support for outputing ioctl IDs (the second argument
> of ioctl()) as strings rather than numbers - for all platform
> independant ioctls.
>>    b) Add strace support for printing the third argument of ioctl()
> (be it int, string, structure or array) - limited to selected ioctls
> that are frequently used.
>>
>> PART II:
>>
>>    a) Amend support for existing groups of ioctls that are not
> completed 100% (let's say, filesystem ioctls)
>>    b) Add support for a selected group of ioctls that are not
> currently supported (for example, dm ioctls, Bluetooth ioctls, or Radeon
> DRM ioctls)
>>
>> PART III:
>>
>>   a) Develop unit tests for selected ioctls that are already supported
> in QEMU.
>>
>> DELIVERABLES
>>
>> The deliverables are in the form of source code for each part,
> intended to be upstreamed, and time needed for upstreaming (addressing
> reviews, etc.) process is included int this project.
>>
>> The delivery of results can and should be distributed over larger
> period of time 2-3 months.
>>
>>
>> Montor: open (I propose Laurent Vivier)
>>
>> Student: open
> 
> Hello, Peter, Laurent, Stefan.
> 
> I presented in this thread two variants of a potential
> linux-user-related project for GSoC/Outreachy. The first variant is more
> focused on a particular area (ioctl support), while the second one
> covers wider set of current issues within linux-user. The pros and cons
> of both should be carefully assesed. I will leave to Peter and Laurent
> the final judgement if we want to go or not with this project and also
> the final formulation of the project.

I think the second variant (that includes new syscalls) is more
interesting for us and for the student.

> Stefan, there was an idea in this thread that this project contributes
> (apart to QEMU) to another ooen source project (LTP). In my layman view,
> this is an advantage. But, how does that fit into GSoC/Outreachy rules?
> 
> Laurent, all this seems to be dependant on whether you are ready to
> mentor the project. Are you?

Yes, of course.

> The deadline for submitting GSoC/Outreachy projects (within QEMU) is
> just around the corner (Feb 1). I leave to Laurent or Peter (should they
> give "go" to this proposal) to officially submit the project on our wiki
> page created for that purpose, in the form they deem the best.

Peter, is it ok for you?

Thanks,
Laurent


