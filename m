Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D3B21881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D3B21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54O0-0007Ez-Me
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i54MR-0005q2-QV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i54MQ-00064a-Cg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:40:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i54MN-0005wF-TE; Tue, 03 Sep 2019 04:40:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 587ADA36F04;
 Tue,  3 Sep 2019 08:40:17 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5FBA19C78;
 Tue,  3 Sep 2019 08:40:15 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190827160554.30995-1-eric.auger@redhat.com>
 <20190827160554.30995-3-eric.auger@redhat.com>
 <29520007-f3fd-ed8d-f52b-2839f991556a@huawei.com>
 <0dd3bc89-8f91-0f8e-8908-18712240a115@redhat.com>
 <CAFEAcA8u3Qe9zx=4QxW_Bb8a=JQ7kUmiAO5H-cwAU4i3R+Nf8w@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9bd0a5b8-ad15-d19f-2bcc-8b605afb5b78@redhat.com>
Date: Tue, 3 Sep 2019 10:40:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8u3Qe9zx=4QxW_Bb8a=JQ7kUmiAO5H-cwAU4i3R+Nf8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 03 Sep 2019 08:40:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 2/3] intc/arm_gic: Support PPI injection for
 more than 256 vpus
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 9/3/19 10:29 AM, Peter Maydell wrote:
> On Thu, 29 Aug 2019 at 08:58, Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Zenghui,
>>
>> On 8/29/19 4:53 AM, Zenghui Yu wrote:
>>> For confirmation, should we also adjust the vcpu_index in
>>> arm_cpu_kvm_set_irq(), just like above?
>>
>> I am not familiar with this path. in arm_cpu_initfn(), there is a
>> comment saying "VIRQ and VFIQ are unused with KVM but we add them to
>> maintain the same interface as non-KVM CPUs." So I don't know when that
>> code gets executed.
> 
> That comment is saying that all KVM guest CPUs are
> EL1-only (since we don't handle nested virt), and therefore
> they logically don't have an inbound VIRQ or VFIQ line.
> But we provide the qemu_irqs for them anyway, so that
> board code doesn't have to have tedious conditionals
> saying "if this CPU has EL2 then wire up VIRQ and VFIQ
> to the GIC". If you ever try to actually assert the VIRQ
> or VFIQ lines you will hit the g_assert_not_reached() in
> arm_cpu_kvm_set_irq().

OK thanks for the clarification. I mixed things up.

I guess arm_cpu_kvm_set_irq attempting to inject IRQ/FIQ into KVM is
used with userspace GIC emulation, which is not supported along with
GICv3. But anyway, I guess it does not hurt to set vcpu_index2 in
arm_cpu_kvm_set_irq?

Thanks

Eric


> 
> thanks
> -- PMM
> 

