Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2296C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771A9206BB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 18:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771A9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0rsZ-0004PH-J1
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 14:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i0rqe-0003mz-MV
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i0rqd-0002st-1r
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:30:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i0rqc-0002sE-P2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 14:30:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35E5D106BB23;
 Thu, 22 Aug 2019 18:30:09 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FCBD2635A;
 Thu, 22 Aug 2019 18:29:38 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
 <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9D74A@ORSMSX113.amr.corp.intel.com>
 <adf3f3b8-1dc9-79e1-7411-4d9131657a1f@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9E82C@ORSMSX113.amr.corp.intel.com>
 <772d64f7-e153-e9e6-dd69-9f34de5bb577@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3ca65433-8aed-57d4-7f18-a2a2718a6ffe@redhat.com>
Date: Thu, 22 Aug 2019 20:29:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <772d64f7-e153-e9e6-dd69-9f34de5bb577@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 22 Aug 2019 18:30:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/22/19 08:18, Paolo Bonzini wrote:
> On 21/08/19 22:17, Kinney, Michael D wrote:
>> Paolo,
>>
>> It makes sense to match real HW.
>
> Note that it'd also be fine to match some kind of official Intel
> specification even if no processor (currently?) supports it.

I agree, because...

>> That puts us back to the reset vector and handling the initial SMI at
>> 3000:8000.  That is all workable from a FW implementation
>> perspective.

that would suggest that matching reset vector code already exists, and
it would "only" need to be upstreamed to edk2. :)

>> It look like the only issue left is DMA.
>>
>> DMA protection of memory ranges is a chipset feature. For the current
>> QEMU implementation, what ranges of memory are guaranteed to be
>> protected from DMA?  Is it only A/B seg and TSEG?
>
> Yes.

(

This thread (esp. Jiewen's and Mike's messages) are the first time that
I've heard about the *existence* of such RAM ranges / the chipset
feature. :)

Out of interest (independently of virtualization), how is a general
purpose OS informed by the firmware, "never try to set up DMA to this
RAM area"? Is this communicated through ACPI _CRS perhaps?

... Ah, almost: ACPI 6.2 specifies _DMA, in "6.2.4 _DMA (Direct Memory
Access)". It writes,

    For example, if a platform implements a PCI bus that cannot access
    all of physical memory, it has a _DMA object under that PCI bus that
    describes the ranges of physical memory that can be accessed by
    devices on that bus.

Sorry about the digression, and also about being late to this thread,
continually -- I'm primarily following and learning.

)

Thanks!
Laszlo

