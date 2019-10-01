Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E582ECE58B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF58A206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF58A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMX4-0007By-Ah
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iFMUp-0005HN-M7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iFMUo-0000fe-2Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iFMUn-0000eX-Og
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:03:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F11A1895A42;
 Tue,  1 Oct 2019 18:03:32 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-64.rdu2.redhat.com
 [10.10.121.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E70260BE0;
 Tue,  1 Oct 2019 18:03:20 +0000 (UTC)
Subject: Re: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM
 at default SMBASE address
To: "Yao, Jiewen" <jiewen.yao@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 "imammedo@redhat.com" <imammedo@redhat.com>
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
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8f179aae-8ff4-2b2b-4024-1fd1156a3225@redhat.com>
Date: Tue, 1 Oct 2019 20:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503F7DFDB3@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 01 Oct 2019 18:03:32 +0000 (UTC)
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
 Brijesh Singh <brijesh.singh@amd.com>,
 "phillip.goerl@oracle.com" <phillip.goerl@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, "Kinney,
 Michael D" <michael.d.kinney@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/30/19 16:22, Yao, Jiewen wrote:
> 
>> -----Original Message-----
>> From: devel@edk2.groups.io <devel@edk2.groups.io> On Behalf Of Igor
>> Mammedov
>> Sent: Monday, September 30, 2019 8:37 PM
>> To: Laszlo Ersek <lersek@redhat.com>

>>> To me it looks like we need to figure out how QEMU can make the OS call
>>> into SMM (in the GPE cpu hotplug handler), passing in parameters and
>>> such. This would be step (03).
>>>
>>> Do you agree?
>>>
>>> If so, I'll ask Jiewen about such OS->SMM calls separately, because I
>>> seem to remember that there used to be an "SMM communcation table" of
>>> sorts, for flexible OS->SMM calls. However, it appears to be deprecated
>>> lately.
>> we can try to resurrect and put over it some kind of protocol
>> to describe which CPUs to where hotplugged.
>>
>> or we could put a parameter into SMI status register (IO port 0xb3)
>> and the trigger SMI from GPE handler to tell SMI handler that cpu
>> hotplug happened and then use QEMU's cpu hotplug interface
>> to enumerate hotplugged CPUs for SMI handler.
>>
>> The later is probably simpler as we won't need to reinvent the wheel
>> (just reuse the interface that's already in use by GPE handler).

Based on "docs/specs/acpi_cpu_hotplug.txt", this seems to boil down to a
bunch of IO port accesses at base 0x0cd8.

Is that correct?

> [Jiewen] The PI specification Volume 4 - SMM defines EFI_MM_COMMUNICATION_PROTOCOL.Communicate() - It can be used to communicate between OS and SMM handler. But it requires the runtime protocol call. I am not sure how OS loader passes this information to OS kernel.
> 
> As such, I think using ACPI SCI/GPE -> software SMI handler is an easier way to achieve this. I also recommend this way.
> For parameter passing, we can use 1) Port B2 (1 byte), 2) Port B3 (1 byte), 3) chipset scratch register (4 bytes or 8 bytes, based upon scratch register size), 4) ACPI NVS OPREGION, if the data structure is complicated.

I'm confused about the details. In two categories:
(1) what values to use,
(2) how those values are passed.

Assume a CPU is hotpluged, QEMU injects an SCI, and the ACPI GPE handler
in the OS -- which also originates from QEMU -- writes a particular byte
to the Data port (0xB3), and then to the Control port (0xB2),
broadcasting an SMI.

(1) What values to use.

Note that values ICH9_APM_ACPI_ENABLE (2) and ICH9_APM_ACPI_DISABLE (3)
are already reserved in QEMU for IO port 0xB2, for different purposes.
So we can't use those in the GPE handler.

Furthermote, OVMF's EFI_SMM_CONTROL2_PROTOCOL.Trigger() implementation
(in "OvmfPkg/SmmControl2Dxe/SmmControl2Dxe.c") writes 0 to both ports,
as long as the caller does not specify them.

  IoWrite8 (ICH9_APM_STS, DataPort    == NULL ? 0 : *DataPort);
  IoWrite8 (ICH9_APM_CNT, CommandPort == NULL ? 0 : *CommandPort);

And, there is only one Trigger() call site in edk2: namely in
"MdeModulePkg/Core/PiSmmCore/PiSmmIpl.c", in the
SmmCommunicationCommunicate() function.

(That function implements EFI_SMM_COMMUNICATION_PROTOCOL.Communicate().)
This call site passes NULL for both DataPort and CommandPort.

Yet further, EFI_SMM_COMMUNICATION_PROTOCOL.Communicate() is used for
example by the UEFI variable driver, for talking between the
unprivileged (runtime DXE) and privileged (SMM) half.

As a result, all of the software SMIs currently in use in OVMF, related
to actual firmware services, write 0 to both ports.

I guess we can choose new values, as long as we avoid 2 and 3 for the
control port (0xB2), because those are reserved in QEMU -- see
ich9_apm_ctrl_changed() in "hw/isa/lpc_ich9.c".


(2) How the parameters are passed.


(2a) For the new CPU, the SMI remains pending, until it gets an
INIT-SIPI-SIPI from one of the previously plugged CPUs (most likely, the
BSP). At that point, the new CPU will execute the "initial SMI handler
for hotplugged CPUs", at the default SMBASE.

That's a routine we'll have to write in assembly, from zero. In this
routine, we can read back IO ports 0xB2 and 0xB3. And QEMU will be happy
to provide the values last written (see apm_ioport_readb() in
"hw/isa/apm.c"). So we can receive the values in this routine. Alright.


(2b) On all other CPUs, the SMM foundation already accepts the SMI.

There point where it makes sense to start looking is SmmEntryPoint()
[MdeModulePkg/Core/PiSmmCore/PiSmmCore.c].

(2b1) This function first checks whether the SMI is synchronous. The
logic for determining that is based on
"gSmmCorePrivate->CommunicationBuffer" being non-NULL. This field is set
to non-NULL in SmmCommunicationCommunicate() -- see above, in (1).

In other words, the SMI is deemed synchronous if it was initiated with
EFI_SMM_COMMUNICATION_PROTOCOL.Communicate(). In that case, the
HandlerType GUID is extracted from the communication buffer, and passed
to SmiManage(). In turn, SmiManage() locates the SMI handler registered
with the same handler GUID, and delegates the SMI handling to that
specific handler.

This is how the UEFI variable driver is split in two halves:

- in "MdeModulePkg/Universal/Variable/RuntimeDxe/VariableSmm.c", we have
a call to gMmst->MmiHandlerRegister(), with HandlerType =
"gEfiSmmVariableProtocolGuid"

- in
"MdeModulePkg/Universal/Variable/RuntimeDxe/VariableSmmRuntimeDxe.c", we
format communication buffers with the header GUID set to the same
"gEfiSmmVariableProtocolGuid".

Of course, this is what does *not* apply to our use case, as the SMI is
raised by the OS (via an ACPI method), and *not* by a firmware agent
that calls EFI_SMM_COMMUNICATION_PROTOCOL.Communicate().

Therefore, we need to look further in SmmEntryPoint()
[MdeModulePkg/Core/PiSmmCore/PiSmmCore.c].

(2b2) What's left there is only the following:

  //
  // Process Asynchronous SMI sources
  //
  SmiManage (NULL, NULL, NULL, NULL);


So...

- Are we supposed to write a new DXE_SMM_DRIVER for OvmfPkg, and call
gMmst->MmiHandlerRegister() in it, with HandlerType=NULL? (I.e.,
register a "root SMI handler"?)

- And then in the handler, should we read IO ports 0xB2 / 0xB3?

- Also, is that handler where we'd somehow sync up with the hot-plugged
VCPU, and finally call EFI_SMM_CPU_SERVICE_PROTOCOL.SmmAddProcessor()?

- Does it matter what (pre-existent) CPU executes the handler? (IOW,
does it matter what the value of gMmst->CurrentlyExecutingCpu is?)

Thanks,
Laszlo

