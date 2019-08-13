Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A489EC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CC220840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CC220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZVp-0004vZ-Hr
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56808)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hxZVF-0004Up-PO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hxZVE-0005Mx-F2
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hxZVE-0005M5-6s
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27C8B81F10;
 Tue, 13 Aug 2019 16:18:27 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-193.ams2.redhat.com
 [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A57182E27;
 Tue, 13 Aug 2019 16:18:24 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: edk2-devel-groups-io <devel@edk2.groups.io>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
Message-ID: <55cc7921-2b91-5060-d5de-d7513067f76e@redhat.com>
Date: Tue, 13 Aug 2019 18:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 13 Aug 2019 16:18:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: Yingwen Chen <yingwen.chen@intel.com>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, Jiewen Yao <jiewen.yao@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/13/19 18:09, Laszlo Ersek wrote:
> On 08/13/19 16:16, Laszlo Ersek wrote:

>> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
>>      rebase code.
>>
>> (07) Host CPU: (SMM) Send message to New CPU to Enable SMI.
> 
> Aha, so this is the SMM-only register you mention in step (03). Is the
> register specified in the Intel SDM?
> 
> 
>> (08) New CPU: (Flash) Get message - Enable SMI.
>>
>> (09) Host CPU: (SMM) Send SMI to the new CPU only.
>>
>> (10) New CPU: (SMM) Response first SMI at 38000, and rebase SMBASE to
>>      TSEG.
> 
> What code does the new CPU execute after it completes step (10)? Does it
> halt?
> 
> 
>> (11) Host CPU: (SMM) Restore 38000.
> 
> These steps (i.e., (06) through (11)) don't appear RAS-specific. The
> only platform-specific feature seems to be SMI masking register, which
> could be extracted into a new SmmCpuFeaturesLib API.
> 
> Thus, would you please consider open sourcing firmware code for steps
> (06) through (11)?
> 
> 
> Alternatively -- and in particular because the stack for step (01)
> concerns me --, we could approach this from a high-level, functional
> perspective. The states that really matter are the relocated SMBASE for
> the new CPU, and the state of the full system, right at the end of step
> (11).
> 
> When the SMM setup quiesces during normal firmware boot, OVMF could use
> existent (finalized) SMBASE infomation to *pre-program* some virtual
> QEMU hardware, with such state that would be expected, as "final" state,
> of any new hotplugged CPU. Afterwards, if / when the hotplug actually
> happens, QEMU could blanket-apply this state to the new CPU, and
> broadcast a hardware SMI to all CPUs except the new one.
> 
> The hardware SMI should tell the firmware that the rest of the process
> -- step (12) below, and onward -- is being requested.
> 
> If I understand right, this approach would produce an firmware & system
> state that's identical to what's expected right after step (11):
> 
> - all SMBASEs relocated
> - all preexistent CPUs in SMM
> - new CPU halted / blocked from launch
> - DRAM at 0x30000 / 0x38000 contains OS-owned data
> 
> Is my understanding correct that this is the expected state after step
> (11)?

Revisiting some of my notes from earlier, such as
<https://bugzilla.redhat.com/show_bug.cgi?id=1454803#c46> -- apologies,
private BZ... --, we discussed some of this stuff with Mike on the phone
in April.

And, it looked like generating a hardware SMI in QEMU, in association
with the hotplug action that was being requested through the QEMU
monitor, would be the right approach.

By now I have forgotten about that discussion -- hence "revisiting my
notes"--, but luckily, it seems consistent with what I've proposed
above, under "alternatively".

Thanks,
Laszlo

