Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A465AC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BD12082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BD12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izM0q-00077V-Iq
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1izLzz-0005th-Mp
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1izLzy-0000I5-4T
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:49:51 -0500
Received: from thoth.sbs.de ([192.35.17.2]:34903)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1izLzx-00009d-Qd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:49:50 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 015Enj4J031744
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2020 15:49:45 +0100
Received: from [139.25.68.37] ([139.25.68.37])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 015EnjWP017080;
 Wed, 5 Feb 2020 15:49:45 +0100
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
To: Stefan Hajnoczi <stefanha@gmail.com>, i.kotrasinsk@partner.samsung.com
References: <CGME20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a@eucas1p1.samsung.com>
 <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <20200205143911.GG58062@stefanha-x1.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1e872eb3-a21b-0f9b-e6a4-54843a028bed@siemens.com>
Date: Wed, 5 Feb 2020 15:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205143911.GG58062@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 192.35.17.2
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

On 05.02.20 15:39, Stefan Hajnoczi wrote:
> On Tue, Feb 04, 2020 at 12:30:42PM +0100, i.kotrasinsk@partner.samsung.com wrote:
>> From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
>>
>> This patchset adds a "memory exposing" device that allows two QEMU
>> instances to share arbitrary memory regions. Unlike ivshmem, it does not
>> create a new region of memory that's shared between VMs, but instead
>> allows one VM to access any memory region of the other VM we choose to
>> share.
>>
>> The motivation for this device is a sort of ARM Trustzone "emulation",
>> where a rich system running on one machine (e.g. x86_64 linux) is able
>> to perform SMCs to a trusted system running on another (e.g. OpTEE on
>> ARM). With a device that allows sharing arbitrary memory between VMs,
>> this can be achieved with minimal changes to the trusted system and its
>> linux driver while allowing the rich system to run on a speedier x86
>> emulator. I prepared additional patches for linux, OpTEE OS and OpTEE
>> build system as a PoC that such emulation works and passes OpTEE tests;
>> I'm not sure what would be the best way to share them.
>>
>> This patchset is my first foray into QEMU source code and I'm certain
>> it's not yet ready to be merged in. I'm not sure whether memory sharing
>> code has any race conditions or breaks rules of working with memory
>> regions, or if having VMs communicate synchronously via chardevs is the
>> right way to do it. I do believe the basic idea for sharing memory
>> regions is sound and that it could be useful for inter-VM communication.
> 
> Hi,
> Without having looked into the patches yet, I'm already wondering if you
> can use the existing -object
> memory-backend-file,size=512M,mem-path=/my/shared/mem feature for your
> use case?
> 
> That's the existing mechanism for fully sharing guest RAM and if you
> want to share all of memory then maybe a device is not necessary - just
> share the memory.

I suspect it's about sharing that memory in a discoverable way. Maybe it 
is also about the signalling channel defined in the device.

OTOH, when it's really about sharing everything, even bidirectional, 
that rather looks like a pragmatic shortcut, not a generic model.

The patches should clarify their use case a bit further, I think. The 
title suggests a generic sharing solution, but my impression is that it 
rather caters a specific case under specific boundary conditions.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

