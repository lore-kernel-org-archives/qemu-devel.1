Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6FC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79ED421929
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ED421929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJS9-0002bd-QZ
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIJ7C-0005Dm-RK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIJ7B-0005vV-6P
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:03:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIJ7A-0005uJ-Vi
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:03:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2051387630;
 Wed,  9 Oct 2019 21:03:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-11.rdu2.redhat.com
 [10.10.120.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 787D219C69;
 Wed,  9 Oct 2019 21:03:13 +0000 (UTC)
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
To: Igor Mammedov <imammedo@redhat.com>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
 <4d47793c-7dfe-a8b6-8704-aca493689577@redhat.com>
 <20191009131305.298d8716@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f61b1627-c83e-6b1d-f1cb-d9f852af61a7@redhat.com>
Date: Wed, 9 Oct 2019 23:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191009131305.298d8716@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 09 Oct 2019 21:03:20 +0000 (UTC)
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

On 10/09/19 13:13, Igor Mammedov wrote:
> On Tue, 8 Oct 2019 20:58:30 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> Eduardo, Igor,
>>
>> On 10/08/19 12:52, Laszlo Ersek wrote:
>>> FW_CFG_MAX_CPUS exposes the (exclusive) maximum APIC ID to guest firmware,
>>> due to historical reasons. That value is not useful to edk2, however. For
>>> supporting VCPU hotplug, edk2 needs:
>>>
>>> - the boot CPU count (already exposed in FW_CFG_NB_CPUS),
>>>
>>> - and the maximum foreseen CPU count (tracked in
>>>   "MachineState.smp.max_cpus", but not currently exposed).
>>>
>>> Add a new fw-cfg file to expose "max_cpus".
>>>
>>> While at it, expose the rest of the topology too (die / core / thread
>>> counts), because I expect that the VCPU hotplug feature for OVMF will
>>> ultimately need those too, and the data size is not large.  
>>
>> In fact, it seems like OVMF will have to synthesize the new
>> (hot-plugged) VCPU's *APIC-ID* from the following information sources:
>>
>> - the topology information described above (die / core / thread counts), and
>>
>> - the "modern" CPU hotplug interface (docs/specs/acpi_cpu_hotplug.txt).
> 
> In general duplicating cpu_index+topo => apic id in firmware I
> consider as a really bad idea (even ignoring cpu_index 
> which I were trying to get rid of in QEMU), it's going to break
> when algorithms diverge and it will be never ending race.

OK.

> Topology is rather messy business, not only arch specific but also
> cpu specific (ex: on my review TODO list, there is a series for
> fixing broken EPYCs topo). Who knows what other variables would be
> add dependencies for calculating APIC IDs down the road.
> 
> I also consider to re-use CPU hotplug interface on ARM, which will
> bring its own set of algorithms.
> 
> Let's instead add a command to CPU hotplug interface to return
> APIC ID (which QEMU already calculated) and later MPIDR (ARM)
> for selected CPU, so firmware could get it while enumeration CPUs
> via that interface.

Sounds good to me, thanks.

I'll stay tuned for your patches! :)

Thanks!
Laszlo

