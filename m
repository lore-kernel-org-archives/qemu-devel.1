Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AC8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8CD21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8CD21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BAs-0004S7-2i
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i1Awk-0005W2-ER
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i1Awi-0008Bb-GQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i1Awi-0008BH-98
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:53:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87A123090FC1;
 Fri, 23 Aug 2019 14:53:42 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77A796CE79;
 Fri, 23 Aug 2019 14:53:33 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
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
 <3ca65433-8aed-57d4-7f18-a2a2718a6ffe@redhat.com>
 <c96fc875-ac07-b33c-e752-35cb65fa0e5e@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <88721a95-a31a-5302-3614-17440c7eb508@redhat.com>
Date: Fri, 23 Aug 2019 16:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c96fc875-ac07-b33c-e752-35cb65fa0e5e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 23 Aug 2019 14:53:42 +0000 (UTC)
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

On 08/22/19 20:51, Paolo Bonzini wrote:
> On 22/08/19 20:29, Laszlo Ersek wrote:
>> On 08/22/19 08:18, Paolo Bonzini wrote:
>>> On 21/08/19 22:17, Kinney, Michael D wrote:
>>>> DMA protection of memory ranges is a chipset feature. For the current
>>>> QEMU implementation, what ranges of memory are guaranteed to be
>>>> protected from DMA?  Is it only A/B seg and TSEG?
>>>
>>> Yes.
>>
>> This thread (esp. Jiewen's and Mike's messages) are the first time that
>> I've heard about the *existence* of such RAM ranges / the chipset
>> feature. :)
>>
>> Out of interest (independently of virtualization), how is a general
>> purpose OS informed by the firmware, "never try to set up DMA to this
>> RAM area"? Is this communicated through ACPI _CRS perhaps?
>>
>> ... Ah, almost: ACPI 6.2 specifies _DMA, in "6.2.4 _DMA (Direct Memory
>> Access)". It writes,
>>
>>     For example, if a platform implements a PCI bus that cannot access
>>     all of physical memory, it has a _DMA object under that PCI bus that
>>     describes the ranges of physical memory that can be accessed by
>>     devices on that bus.
>>
>> Sorry about the digression, and also about being late to this thread,
>> continually -- I'm primarily following and learning.
> 
> It's much simpler: these ranges are not in e820, for example
> 
> kernel: BIOS-e820: [mem 0x0000000000059000-0x000000000008bfff] usable
> kernel: BIOS-e820: [mem 0x000000000008c000-0x00000000000fffff] reserved

(1) Sorry, my _DMA quote was a detour from QEMU -- I wondered how a
physical machine with actual RAM at 0x30000, and also chipset level
protection against DMA to/from that RAM range, would expose the fact to
the OS (so that the OS not innocently try to set up DMA there).

(2) In case of QEMU+OVMF, "e820" is not defined at the firmware level.

While
- QEMU exports an "e820 map" (and OVMF does utilize that),
- and Linux parses the UEFI memmap into an "e820 map" (so that dependent
logic only need to deal with e820),

in edk2 the concepts are "GCD memory space map" and "UEFI memmap".

So what OVMF does is, it reserves the TSEG area in the UEFI memmap:

  https://github.com/tianocore/edk2/commit/b09c1c6f2569a

(This was later de-constified for the extended TSEG size, in commit
23bfb5c0aab6, "OvmfPkg/PlatformPei: prepare for PcdQ35TsegMbytes
becoming dynamic", 2017-07-05).

This is just to say that with OVMF, TSEG is not absent from the UEFI
memmap, it is reserved instead. (Apologies if I misunderstood and you
didn't actually claim otherwise.)


> The ranges are not special-cased in any way by QEMU.  Simply, AB-segs
> and TSEG RAM are not part of the address space except when in SMM.

(or when TSEG is not locked, and open; but:) yes, this matches my
understanding.

> Therefore, DMA to those ranges ends up respectively to low VGA RAM[1]
> and to the bit bucket.  When AB-segs are open, for example, DMA to that
> area becomes possible.

Which seems to imply that, if we alias 0x30000 to the AB-segs, and rely
on the AB-segs for CPU hotplug, OVMF should close and lock down the
AB-segs at first boot. Correct? (Because OVMF doesn't do anything about
AB at the moment.)

Thanks
Laszlo

> 
> Paolo
> 
> [1] old timers may remember DEF SEG=&HB800: BLOAD "foo.img",0.  It still
> works with some disk device models.
> 


