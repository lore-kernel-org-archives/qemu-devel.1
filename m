Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C283C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7312C2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7312C2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQfZ-0007IW-M4
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58389)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hnQfQ-0006sW-0o
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hnQfO-0007ML-UT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40460)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hnQfO-0007LL-OI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 476178E22C;
 Tue, 16 Jul 2019 16:51:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-187.ams2.redhat.com
 [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 041EF5D721;
 Tue, 16 Jul 2019 16:50:57 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
Date: Tue, 16 Jul 2019 18:50:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 16 Jul 2019 16:51:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/16/19 14:03, Peter Maydell wrote:
> On Fri, 24 May 2019 at 13:33, Laszlo Ersek <lersek@redhat.com> wrote:
>> On 11/02/18 18:16, Peter Maydell wrote:
>>> @@ -829,7 +840,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>>           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>>>           * Security Extensions is ARM_FEATURE_EL3.
>>>           */
>>> -        assert(cpu_isar_feature(arm_div, cpu));
>>> +        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
>>
>> The assertion above fails on my AArch64 host (APM Mustang A3). Meaning
>> that my host CPU supports AArch32, but lacks "arm_div".
> 
> Hi; I just realized we left this assertion-failure bug report
> unaddressed, so I had a look at it.

Yes, it's also tracked under LP#1830864; thanks for looking into it.

> 
> I tried to repro on my Mustang, but this works for me.
> A CPU with AArch32 but without the Arm-mode division instructions
> would be non-compliant (and very obviously so if tested), so
> I suspect the actual problem is not with the hardware but with
> the kernel not correctly reporting the ID registers to QEMU.
> What kernel version are you using?

So, I've just retested, with the QEMU binary I've left around from last
time. (This QEMU binary was built at upstream commit d247c8e7f4fc, with
Phil's v2 series applied on top, for regression testing:

[PATCH v2 0/9] hw/block/pflash_cfi01: Add DeviceReset() handler

http://mid.mail-archive.com/38281fa7-30f4-60ec-3357-3e1613c44dbe@redhat.com
)

The issue still reproduces, so it makes sense for me to look at the host
kernel version... Well, I'm afraid it won't help much, for an upstream
investigation:

  4.14.0-115.8.2.el7a.aarch64

This is the latest released kernel from "Red Hat Enterprise Linux for
ARM 64 7".

Thanks!
Laszlo

>> Better yet: can we rework the code to emit a warning, rather than
>> aborting QEMU? Assertions are not the best tool IMHO for catching
>> unusual (or slightly non-conformant / early) hardware.)
> 
> The intention of the assertion really is to catch QEMU bugs
> where we got the ID register values wrong in our emulated
> CPUs. Perhaps we should relax all these assertions to only
> testing if we're using TCG, not KVM ?
> 
> thanks
> -- PMM
> 


