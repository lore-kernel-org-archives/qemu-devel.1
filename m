Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F114C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5CA2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K/LzBLmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5CA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izzWP-0003co-1q
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izzVS-0002Zv-W9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izzVR-0002sX-Kp
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:00:58 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izzVR-0002jI-D8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:00:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200207090052euoutp01272abf2eb74742621729f15b9fb7a7e3~xEzLHO_be0319303193euoutp01K
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 09:00:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200207090052euoutp01272abf2eb74742621729f15b9fb7a7e3~xEzLHO_be0319303193euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1581066053;
 bh=X8Cum5Vj7zIHZ5SRKFgwHd96OwxEuFtdMrE7WFsA+9s=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=K/LzBLmnC3zyVOkg4GLIoxaoofBut4MwvndGGbqT9dIqxNtqF67RyLtGE2BFHRgTc
 YR+zzWUXlr01jMV2XPhq4BGNQyD0y1/cNr0EQia8FxYopnXFizNAE27HWxfubVa3xF
 aaEEqoxu1jxD4SYMnuxFZvHNFQW7eDINtr0ju1Ow=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200207090052eucas1p173262c9e800f7e8df3c783486b5058e8~xEzLAUo691260612606eucas1p14;
 Fri,  7 Feb 2020 09:00:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id AC.17.61286.4472D3E5; Fri,  7
 Feb 2020 09:00:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200207090052eucas1p288fdbb7b31ae8efe3a7f8a7820e17a74~xEzKpLmzp2542425424eucas1p2z;
 Fri,  7 Feb 2020 09:00:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200207090052eusmtrp11a358a4a8c7bf3cf3ea656dbcf04e26a~xEzKomHWd0976009760eusmtrp1r;
 Fri,  7 Feb 2020 09:00:52 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-64-5e3d2744f515
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 46.CB.08375.4472D3E5; Fri,  7
 Feb 2020 09:00:52 +0000 (GMT)
Received: from [106.120.51.21] (unknown [106.120.51.21]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200207090052eusmtip1a56cfa843b6acac982df50d5b398b873~xEzKVXfIT1592815928eusmtip1R;
 Fri,  7 Feb 2020 09:00:52 +0000 (GMT)
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
To: Jan Kiszka <jan.kiszka@siemens.com>, Stefan Hajnoczi <stefanha@gmail.com>
From: =?UTF-8?Q?Igor_Kotrasi=c5=84ski?= <i.kotrasinsk@partner.samsung.com>
Message-ID: <91d3f574-3a4f-8291-040e-520c5c58e77e@partner.samsung.com>
Date: Fri, 7 Feb 2020 10:00:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1e872eb3-a21b-0f9b-e6a4-54843a028bed@siemens.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7ou6rZxBov2GlqcPtrBbHHv5k1m
 i/3b/rFazDnzgMXieO8OFoub06cyObB57Jx1l93jzrU9bB5Prm1m8ni/7yqbx/aTk5gCWKO4
 bFJSczLLUov07RK4Mtq2BhbMlKs4MG0OYwPjXIkuRg4OCQETia4nol2MXBxCAisYJf7un8IO
 4XxhlJj7bysbhPOZUeLDil5GmI4XVyUg4ssZJb7ffscC4bxllNh/4yFQByeHsIC1RM/zPjBb
 RMBfovHFTjCbWSBfYnvzYmYQm03AS+L+xJWMIDavgJvE+oZmsAUsAioSDafZQExRgQiJ018T
 ISoEJU7OfMICYnMK2Evc2jAfaqKjxJ/Hh1ghbHGJW0/mM0HY8hLb385hBjlNQmAZu8Sso4vB
 miUEXCR6u+4yQ9jCEq+Ob2GHsGUkTk/ugaqpl2i5s4MJormDUaJv5XQ2iIS1xJcNS6GKHCWu
 3GlihgQKn8SNt4IQi/kkJm2bDhXmlehoE4Ko1pPofnKTCWbVssZHLBMYlWYheW0WkndmIXln
 FpJ3FjCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMO6f/Hf+0g/HrpaRDjAIcjEo8
 vAmONnFCrIllxZW5hxglOJiVRHj7VG3jhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQ
 nliSmp2aWpBaBJNl4uCUamBc/aty3/8ZExg4D5wKPxt85/UV0RUcm+x2aj1MPKvcuN4pQf3C
 3APTn126XRXwvmv2IZV1LVk9zfNCpt6UerRxKs9HeeZJOfEcfu29krd7ckUNFxi/TNfWlPKZ
 o2BlsS189ZfH7ndKvdPLPkjaRs+8+unKSmGuE+VdWa5Kp/6aHt3DOL9d+FGQEktxRqKhFnNR
 cSIA70KAfjcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7ou6rZxBv9nSlucPtrBbHHv5k1m
 i/3b/rFazDnzgMXieO8OFoub06cyObB57Jx1l93jzrU9bB5Prm1m8ni/7yqbx/aTk5gCWKP0
 bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mtq2BhbM
 lKs4MG0OYwPjXIkuRg4OCQETiRdXgUwuDiGBpYwSzw/OYe5i5ASKy0j8OL2GDcIWlvhzrQvM
 FhJ4zSjx7YkDiC0sYC3R87wPLC4i4Ctx9+o+MJtZIF/iwemN7BBDe5gkti5qA0uwCXhJ3J+4
 khHE5hVwk1jf0MwIcgSLgIpEw2mwElGBCInn229AlQhKnJz5hAXE5hSwl7i1YT7UfFuJO3N3
 M0PY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLS
 vHS95PzcTYzAONt27OfmHYyXNgYfYhTgYFTi4U1wtIkTYk0sK67MPcQowcGsJMLbp2obJ8Sb
 klhZlVqUH19UmpNafIjRFOi3icxSosn5wBSQVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
 JDU7NbUgtQimj4mDU6qBkbXUrrag8UkgX8QlkSmm9jUiDCyTG4Vmte/R5Gz4LP/ItfTy51qz
 YCO/mXcjFTbON9vVvruxZ1LRss3zb5qolN12tquZ9qhJ7e876cqf3yUcWqIuT84rnNZeGKko
 03L9gq9GX/4cOZWzWxeqKe11/CR3ueOQpfnhJ1M3yZ+d9uTZxVdywkaBSizFGYmGWsxFxYkA
 18bOj8kCAAA=
X-CMS-MailID: 20200207090052eucas1p288fdbb7b31ae8efe3a7f8a7820e17a74
X-Msg-Generator: CA
X-RootMTR: 20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a
References: <CGME20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a@eucas1p1.samsung.com>
 <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <20200205143911.GG58062@stefanha-x1.localdomain>
 <1e872eb3-a21b-0f9b-e6a4-54843a028bed@siemens.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
Cc: peter.maydell@linaro.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:49 PM, Jan Kiszka wrote:
> On 05.02.20 15:39, Stefan Hajnoczi wrote:
>> On Tue, Feb 04, 2020 at 12:30:42PM +0100, 
>> i.kotrasinsk@partner.samsung.com wrote:
>>> From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
>>>
>>> This patchset adds a "memory exposing" device that allows two QEMU
>>> instances to share arbitrary memory regions. Unlike ivshmem, it does not
>>> create a new region of memory that's shared between VMs, but instead
>>> allows one VM to access any memory region of the other VM we choose to
>>> share.
>>>
>>> The motivation for this device is a sort of ARM Trustzone "emulation",
>>> where a rich system running on one machine (e.g. x86_64 linux) is able
>>> to perform SMCs to a trusted system running on another (e.g. OpTEE on
>>> ARM). With a device that allows sharing arbitrary memory between VMs,
>>> this can be achieved with minimal changes to the trusted system and its
>>> linux driver while allowing the rich system to run on a speedier x86
>>> emulator. I prepared additional patches for linux, OpTEE OS and OpTEE
>>> build system as a PoC that such emulation works and passes OpTEE tests;
>>> I'm not sure what would be the best way to share them.
>>>
>>> This patchset is my first foray into QEMU source code and I'm certain
>>> it's not yet ready to be merged in. I'm not sure whether memory sharing
>>> code has any race conditions or breaks rules of working with memory
>>> regions, or if having VMs communicate synchronously via chardevs is the
>>> right way to do it. I do believe the basic idea for sharing memory
>>> regions is sound and that it could be useful for inter-VM communication.
>>
>> Hi,
>> Without having looked into the patches yet, I'm already wondering if you
>> can use the existing -object
>> memory-backend-file,size=512M,mem-path=/my/shared/mem feature for your
>> use case?
>>
>> That's the existing mechanism for fully sharing guest RAM and if you
>> want to share all of memory then maybe a device is not necessary - just
>> share the memory.

That option adds memory in addition to the memory allocated with the 
'-m' flag, doesn't it? I looked into that option, and it seemed to me 
you can't back all memory this way.

Apart from that, the only advantage my solution has is that it's aware 
of any memory overlaying the memory-backed regions (i.e. memory backed 
by accessor functions). Maybe I don't need this for my use case, I'd 
have to test that.

> 
> I suspect it's about sharing that memory in a discoverable way. Maybe it 
> is also about the signalling channel defined in the device.
> 
> OTOH, when it's really about sharing everything, even bidirectional, 
> that rather looks like a pragmatic shortcut, not a generic model.
> 
> The patches should clarify their use case a bit further, I think. The 
> title suggests a generic sharing solution, but my impression is that it 
> rather caters a specific case under specific boundary conditions.
> 
> Jan
> 

The solution does stem from a specific use case, the ARM Trustzone 
forwarding described in the cover letter. Normally both OSes can pass 
data around by sharing physical addresses (potentially from anywhere in 
memory), so giving VMs an ability to access one another's memory no 
matter how it's backed allows for minimal trusted OS modification, just 
offsetting physical addresses. The interrupt functionality also reflects 
this, it's intended to pass around SMC data.

I realize that this kind of total memory sharing couples the two VMs 
tightly - this is why I'm asking for comments on this, perhaps there's a 
better solution for this specific scenario.

For what it's worth, the extent of this sharing can be reduced by using 
a limited MemoryRegion like it's done for secure and non-secure memory 
views on ARM.

Igor

