Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5801EC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3377E206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVvmWnkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3377E206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aDJ-0002tG-AL
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j1aCM-0002KO-1Z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j1aCJ-0002xn-Sr
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:23:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j1aCJ-0002wO-Os
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581445427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtLteavNR/sU8I4FM52dhJ4SSP+pHIXFfOdCu8qBlvk=;
 b=NVvmWnkKLJkjrTL+oWrCmMf0lqRhKyo3IsjxKZCzVU4sjobVLZI0LNmO8Zwn+UNP/L6a6f
 BCgicxmMHqGMrbustWveh9RdEJkIPpveT18S2SKfdssnhKAMXLQbUNL17bQP64tAQF9Uux
 XAnD4LSkeibDw6m7AnKZs5aO1ZkXNco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-eLXIxVWWPx6eFNA8tAG7jw-1; Tue, 11 Feb 2020 13:23:38 -0500
X-MC-Unique: eLXIxVWWPx6eFNA8tAG7jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BF2F18B9FC1;
 Tue, 11 Feb 2020 18:23:37 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A08560BF1;
 Tue, 11 Feb 2020 18:23:31 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 0/9] KVM: arm64: PMUv3 Event Counter
 Tests
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <CAFEAcA8iBvM2xguW2_6OFWDjPPEzEorief4F2aoh0Vitp466rQ@mail.gmail.com>
 <20200211160733.zbqh3vbscdfgkkcd@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7daa10bc-178d-48a1-aee4-a8edcaf37bc3@redhat.com>
Date: Tue, 11 Feb 2020 19:23:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200211160733.zbqh3vbscdfgkkcd@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kvm-devel <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Murray <andrew.murray@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, kvmarm@lists.cs.columbia.edu,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/11/20 5:07 PM, Andrew Jones wrote:
> On Tue, Feb 11, 2020 at 03:42:38PM +0000, Peter Maydell wrote:
>> On Thu, 30 Jan 2020 at 11:25, Eric Auger <eric.auger@redhat.com> wrote:
>>>
>>> This series implements tests exercising the PMUv3 event counters.
>>> It tests both the 32-bit and 64-bit versions. Overflow interrupts
>>> also are checked. Those tests only are written for arm64.
>>>
>>> It allowed to reveal some issues related to SW_INCR implementation
>>> (esp. related to 64-bit implementation), some problems related to
>>> 32-bit <-> 64-bit transitions and consistency of enabled states
>>> of odd and event counters (See [1]).
>>>
>>> Overflow interrupt testing relies of one patch from Andre
>>> ("arm: gic: Provide per-IRQ helper functions") to enable the
>>> PPI 23, coming from "arm: gic: Test SPIs and interrupt groups"
>>> (https://patchwork.kernel.org/cover/11234975/). Drew kindly
>>> provided "arm64: Provide read/write_sysreg_s".
>>>
>>> All PMU tests can be launched with:
>>> ./run_tests.sh -g pmu
>>> Tests also can be launched individually. For example:
>>> ./arm-run arm/pmu.flat -append 'chained-sw-incr'
>>>
>>> With KVM:
>>> - chain-promotion and chained-sw-incr are known to be failing.
>>>   [1] proposed a fix.
>>> - On TX2, I have some random failures due to MEM_ACCESS event
>>>   measured with a great disparity. This is not observed on
>>>   other machines I have access to.
>>> With TCG:
>>> - all new tests are skipped
>>
>> I'm having a go at using this patchset to test the support
>> I'm adding for TCG for the v8.1 and v8.4 PMU extensions...
>>
>> Q1: how can I get run_tests.sh to pass extra arguments to
>> QEMU ? The PMU events check will fail unless QEMU gets
>> the '-icount 8' to enable cycle-counting, but although
>> the underlying ./arm/run lets you add arbitrary extra
>> arguments to QEMU, run_tests.sh doesn't seem to. Trying to
>> pass them in via "QEMU=/path/to/qemu -icount 8" doesn't
>> work either.
int arm/unittests.cfg

there are tests related to TCG that are commented.

# Test PMU support (TCG) with -icount IPC=256
#[pmu-tcg-icount-256]
#file = pmu.flat
#extra_params = -icount 8 -append 'cycle-counter 256'
#groups = pmu
#accel = tcg

I wondered why we kept those and commented. Should we start with
separate tests for KVM and TCG?

> 
> Alex Bennee once submit a patch[*] allowing that to work, but
> it never got merged. I just rebased it and tried it, but it
> doesn't work now. Too much has changed in the run scripts
> since his posting. I can try to rework it though.
> 
> [*] https://github.com/rhdrjones/kvm-unit-tests/commit/9a8574bfd924f3e865611688e26bb12e53821747
> 
>>
>> Q2: do you know why arm/pmu.c:check_pmcr() insists that
>> PMCR.IMP is non-zero? The comment says "simple sanity check",
>> but architecturally a zero IMP field is permitted (meaning
>> "go look at MIDR_EL1 instead"). This causes TCG to fail this
>> test on '-cpu max', because in that case we set PMCR.IMP
>> to the same thing as MIDR_EL1.Implementer which is 0
>> ("software use", since QEMU is software...)
indeed
> 
> Probably just a misunderstanding on the part of the author (and
> reviewers). Maybe Eric can fix that while preparing this series.

Yes I can definitively fix that

Thanks

Eric
> 
> Thanks,
> drew
> 


