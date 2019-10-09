Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E7C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A358206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A358206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJsw-0004WU-A4
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIJ5R-0003x1-C2
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIJ5P-0005N5-L0
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:01:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIJ5P-0005Ma-8J
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:01:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19248316E533;
 Wed,  9 Oct 2019 21:01:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-11.rdu2.redhat.com
 [10.10.120.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 568AA196B2;
 Wed,  9 Oct 2019 21:01:22 +0000 (UTC)
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
To: Igor Mammedov <imammedo@redhat.com>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
 <20191008175931.483af366@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3305625d-f3cf-47e8-0039-0838fc718d3d@redhat.com>
Date: Wed, 9 Oct 2019 23:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191008175931.483af366@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 09 Oct 2019 21:01:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/19 17:59, Igor Mammedov wrote:
> On Tue,  8 Oct 2019 12:52:58 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> FW_CFG_MAX_CPUS exposes the (exclusive) maximum APIC ID to guest firmware,
>> due to historical reasons. That value is not useful to edk2, however. For
>> supporting VCPU hotplug, edk2 needs:
>>
>> - the boot CPU count (already exposed in FW_CFG_NB_CPUS),
>>
>> - and the maximum foreseen CPU count (tracked in
>>   "MachineState.smp.max_cpus", but not currently exposed).
> one can get it with current QEMU without adding new fgcfg
> (albeit in a bit awkward way)
> 
> max_cpu count can be derived indirectly as result of cpu hotplug
> enumeration (IO interface at 0x0cd8-0xcf7) by writing/reading
> to/from selector register (see ACPI_CPU_SELECTOR_OFFSET_WR)
> until read value stops changing values (i.e. max cpu count
> is reached). One also can figure out present/non-present
> cpu status by reading flags register.

What do you mean by "read value stops changing values"?

I assume I have to write the CPU index (in incrementing fashion) to
offset 0 in the register block.

- What byte order?
- What offset / width do I need to read back? What endianness? :)
- What is the expected value once I run out of the possible CPU range?

(I tried to figure these out from "docs/specs/acpi_cpu_hotplug.txt", but
I can't find the answers in it. Apologies.)

Other than that, I'm fine with this method. Hopefully the IO port
accesses (on every boot) won't slow down the boot much (esp. in SEV
guests, where they are more costly).


>> Add a new fw-cfg file to expose "max_cpus".
>>
>> While at it, expose the rest of the topology too (die / core / thread
>> counts), because I expect that the VCPU hotplug feature for OVMF will
>> ultimately need those too, and the data size is not large. This is
>> slightly complicated by the fact that the die count is specific to
>> PCMachineState, but fw_cfg_arch_create() intends to be PC-independent (see
>> commit 149c50cabcc4).
> Could you clarify why topology info is necessary?

(Done in the subsequent message, but I'll answer here too, below.)


> Potentially it's possible to extend cpu hotplug ABI to report
> arch specific apic-id (x86) or mpidr (arm) if firmware really
> needs to know topology and let guest to decode it according
> to CPU's spec.

This would be very nice.

For the hotplug use case, the internal structure / topology of the
APIC-ID actually appears irrelevant. What's needed is that the "host
CPU", handling the hotplug SMI, can *somehow* deduce the APIC-ID of the
new CPU. (The edk2 code suggests that, on physical platforms, the RAS
controller passes the new APIC-ID the the "host CPU".) The edk2
infrastructure uses APIC-ID's as the unique key for identifying CPUs.

The topology info was supposed to allow OVMF to calculate the APIC-ID
from scratch, based on the sequential CPU index (retrieved from the ACPI
hotplug register block).

> So far there were no need for it as all possible cpus are
> described in ACPI tables passed to guest, but I'm not going
> to suggest to parse them on firmware side as it's too complicated :)

Thanks, that's appreciated :)

> PS:
> The reason we started building ACPI tables in QEMU, was never
> ending story of adding more ABI and supporting it afterwards.
> So I'd try to avoid doing it if it can be helped.

Sure, I don't insist.

If the hotplug register block can expose the APIC-IDs as "opaque"
integers, and they match the APIC-IDs read on the actual processors,
things should work.

Thanks,
Laszlo

