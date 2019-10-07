Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241CAC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE938217D6
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE938217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHPaJ-00045E-21
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHPZQ-0003YS-IZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHPZO-0005g1-27
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iHPZM-0005ey-4L
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6B18C049E1A;
 Mon,  7 Oct 2019 09:44:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-11.rdu2.redhat.com
 [10.10.120.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13DCD19C7F;
 Mon,  7 Oct 2019 09:44:35 +0000 (UTC)
Subject: Re: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM
 at default SMBASE address
To: Igor Mammedov <imammedo@redhat.com>
References: <20190917130708.10281-1-imammedo@redhat.com>
 <20190917130708.10281-2-imammedo@redhat.com>
 <561f4440-7c06-10d7-80ce-bbfa810fec59@redhat.com>
 <20190920102855.3fe2b689@redhat.com>
 <a581abbc-ec03-c332-b225-6f7cd3cfadae@redhat.com>
 <c18f1ada-3eca-d5f1-da4f-e74181c5a862@redhat.com>
 <20190924131936.7dec5e6c@redhat.com>
 <fb9c530c-f911-313d-6a79-5291e84327e5@redhat.com>
 <20190930143659.6de53f70@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7DFDB3@shsmsx102.ccr.corp.intel.com>
 <8f179aae-8ff4-2b2b-4024-1fd1156a3225@redhat.com>
 <20191004133052.20373155@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ddd26a7a-5aa0-27dc-4936-2f539b95b1df@redhat.com>
Date: Mon, 7 Oct 2019 11:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191004133052.20373155@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 07 Oct 2019 09:44:41 +0000 (UTC)
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, devel@edk2.groups.io,
 "phillip.goerl@oracle.com" <phillip.goerl@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Yao,
 Jiewen" <jiewen.yao@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/04/19 13:31, Igor Mammedov wrote:
> On Tue, 1 Oct 2019 20:03:20 +0200
> "Laszlo Ersek" <lersek@redhat.com> wrote:

>> (1) What values to use.

> SeaBIOS writes 0x00 into command port, but it seems that's taken by
> EFI_SMM_COMMUNICATION_PROTOCOL. So we can use the next unused value
> (lets say 0x4). We probably don't have to use status port or 
> EFI_SMM_COMMUNICATION_PROTOCOL, since the value of written into 0xB2
> is sufficient to distinguish hotplug event.

Thanks. Can you please write a QEMU patch for the ACPI generator such
that hotplugging a VCPU writes value 4 to IO port 0xB2?

That will allow me to experiment with OVMF.

(I can experiment with some other parts in edk2 even before that.)

>> (2) How the parameters are passed.
>>
>>
>> (2a) For the new CPU, the SMI remains pending, until it gets an
>> INIT-SIPI-SIPI from one of the previously plugged CPUs (most likely, the
>> BSP). At that point, the new CPU will execute the "initial SMI handler
>> for hotplugged CPUs", at the default SMBASE.
>>
>> That's a routine we'll have to write in assembly, from zero. In this
>> routine, we can read back IO ports 0xB2 and 0xB3. And QEMU will be happy
>> to provide the values last written (see apm_ioport_readb() in
>> "hw/isa/apm.c"). So we can receive the values in this routine. Alright.
> 
> Potentially we can can avoid writing custom SMI handler,
> what do you think about following workflow:
> 
> on system boot after initial CPUs relocation, firmware set NOP SMI handler
> at default SMBASE.
> Then as reaction to GPE triggered SMI (on cpu hotplug), after SMI rendezvous,
> a host cpu reads IO port 0xB2 and does hotplugged CPUs enumeration.
> 
>   a) assuming we allow hotplug only in case of negotiated SMI broadcast
>      host CPU shoots down all in-flight INIT/SIPI/SIPI for hotpugged CPUs
>      to avoid race within relocation handler.

How is that "shootdown" possible?

>  After that host CPU in loop
> 
>   b) it prepares/initializes necessary CPU structures for a hotplugged
>      CPU if necessary and replaces NOP SMI handler with the relocation
>      SMI handler that is used during system boot.
>      
>   c) a host CPU sends NOP INIT/SIPI/SIPI to the hotplugged CPU
> 
>   d) the woken up hotplugged CPU, jumps to default SMBASE and
>      executes hotplug relocation handler.
> 
>   e) after the hotplugged CPU  is relocated and if there are more
>      hotplugged CPUs, a host CPU repeats b-d steps for the next
>      hotplugged CPU.
> 
>   f) after all CPUs are relocated, restore NOP SMI handler at default
>      SMBASE.
> 

Thanks
Laszlo

