Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC546C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D7E20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D7E20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8LRh-00082N-Pr
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i8LO7-0004FU-16
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i8LO5-0004dO-MZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i8LO0-0004ZL-Py; Thu, 12 Sep 2019 05:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A9F430860BD;
 Thu, 12 Sep 2019 09:27:31 +0000 (UTC)
Received: from [10.36.116.238] (ovpn-116-238.ams2.redhat.com [10.36.116.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5576F60C05;
 Thu, 12 Sep 2019 09:27:29 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190911155125.11932-1-eric.auger@redhat.com>
 <20190911155125.11932-4-eric.auger@redhat.com>
 <CAFEAcA-tZJ2C8=ZH5e7tXzigPu3SGjSJbnLybZTG+hZO-7ZV0A@mail.gmail.com>
 <1b849672-31a6-3d8d-b8ea-254e737e3b80@redhat.com>
 <CAFEAcA-xrPP6=dmaee7PZHOr_Fpw-KsCGY5QKHR94wL1uKWL6A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7eb28173-122f-454e-ccba-bd444d7b6376@redhat.com>
Date: Thu, 12 Sep 2019 11:27:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-xrPP6=dmaee7PZHOr_Fpw-KsCGY5QKHR94wL1uKWL6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 12 Sep 2019 09:27:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v2 3/3] virt: Check
 KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 9/12/19 11:00 AM, Peter Maydell wrote:
> On Thu, 12 Sep 2019 at 09:57, Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Peter,
>> On 9/12/19 10:42 AM, Peter Maydell wrote:
> 
>>> Is there really no place to put this check in common code?
> 
>> Not sure what you mean by common code here? Do you mean in a common code
>> for ARM machines (I don't think we have any atm) or directly in
>> kvm_init(). I did not want to pollute this latter with this ARM specific
>> fix.
> 
> I'd just rather we didn't have to have the same "if ..." check
> in every arm board that supports KVM.
> 
> If kvm_init() happens at a point where we have enough info to
> make the check, then you can put the check in kvm_arch_init(),
> which is the architecture-specific hook that kvm_init() calls.
OK Thank you for the hint. It should be OK.

Thanks!

Eric

> 
> thanks
> -- PMM
> 

