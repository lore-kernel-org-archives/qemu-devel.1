Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF0CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522EF20862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522EF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMCH-00031h-Bf
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iGLo9-0008At-6R
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iGLo7-0000JE-31
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:31:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iGLo5-0000If-9j
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:31:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8FCB18C4297;
 Fri,  4 Oct 2019 11:31:30 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BF9F1001B2B;
 Fri,  4 Oct 2019 11:31:25 +0000 (UTC)
Date: Fri, 4 Oct 2019 13:31:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Laszlo Ersek" <lersek@redhat.com>
Subject: Re: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM
 at default SMBASE address
Message-ID: <20191004133052.20373155@redhat.com>
In-Reply-To: <8f179aae-8ff4-2b2b-4024-1fd1156a3225@redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 04 Oct 2019 11:31:31 +0000 (UTC)
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

On Tue, 1 Oct 2019 20:03:20 +0200
"Laszlo Ersek" <lersek@redhat.com> wrote:

> On 09/30/19 16:22, Yao, Jiewen wrote:
> >   
> >> -----Original Message-----
> >> From: devel@edk2.groups.io <devel@edk2.groups.io> On Behalf Of Igor
> >> Mammedov
> >> Sent: Monday, September 30, 2019 8:37 PM
> >> To: Laszlo Ersek <lersek@redhat.com>  
> 
> >>> To me it looks like we need to figure out how QEMU can make the OS call
> >>> into SMM (in the GPE cpu hotplug handler), passing in parameters and
> >>> such. This would be step (03).
> >>>
> >>> Do you agree?
> >>>
> >>> If so, I'll ask Jiewen about such OS->SMM calls separately, because I
> >>> seem to remember that there used to be an "SMM communcation table" of
> >>> sorts, for flexible OS->SMM calls. However, it appears to be deprecated
> >>> lately.  
> >> we can try to resurrect and put over it some kind of protocol
> >> to describe which CPUs to where hotplugged.
> >>
> >> or we could put a parameter into SMI status register (IO port 0xb3)
> >> and the trigger SMI from GPE handler to tell SMI handler that cpu
> >> hotplug happened and then use QEMU's cpu hotplug interface
> >> to enumerate hotplugged CPUs for SMI handler.
> >>
> >> The later is probably simpler as we won't need to reinvent the wheel
> >> (just reuse the interface that's already in use by GPE handler).  
> 
> Based on "docs/specs/acpi_cpu_hotplug.txt", this seems to boil down to a
> bunch of IO port accesses at base 0x0cd8.
> 
> Is that correct?

yep, you can use it to iterate over hotplugged CPUs.
hw side (QEMU) uses cpu_hotplug_ops as IO write/read handlers
and firmware side (ACPI) scannig for hotplugged CPUs is implemented
in CPU_SCAN_METHOD.

What we can do on QEMU side is to write agreed upon value to command port (0xB2)
from CPU_SCAN_METHOD after taking ctrl_lock but before starting scan loop.
That way firmware will first bring up (from fw pov) all hotplugged CPUs
and then return control to OS to do the same from OS pov.


> 
> > [Jiewen] The PI specification Volume 4 - SMM defines EFI_MM_COMMUNICATION_PROTOCOL.Communicate() - It can be used to communicate between OS and SMM handler. But it requires the runtime protocol call. I am not sure how OS loader passes this information to OS kernel.
> > 
> > As such, I think using ACPI SCI/GPE -> software SMI handler is an easier way to achieve this. I also recommend this way.
> > For parameter passing, we can use 1) Port B2 (1 byte), 2) Port B3 (1 byte), 3) chipset scratch register (4 bytes or 8 bytes, based upon scratch register size), 4) ACPI NVS OPREGION, if the data structure is complicated.  
> 
> I'm confused about the details. In two categories:
> (1) what values to use,
> (2) how those values are passed.
> 
> Assume a CPU is hotpluged, QEMU injects an SCI, and the ACPI GPE handler
> in the OS -- which also originates from QEMU -- writes a particular byte
> to the Data port (0xB3), and then to the Control port (0xB2),
> broadcasting an SMI.
> 
> (1) What values to use.
> 
> Note that values ICH9_APM_ACPI_ENABLE (2) and ICH9_APM_ACPI_DISABLE (3)
> are already reserved in QEMU for IO port 0xB2, for different purposes.
> So we can't use those in the GPE handler.

SeaBIOS writes 0x00 into command port, but it seems that's taken by
EFI_SMM_COMMUNICATION_PROTOCOL. So we can use the next unused value
(lets say 0x4). We probably don't have to use status port or 
EFI_SMM_COMMUNICATION_PROTOCOL, since the value of written into 0xB2
is sufficient to distinguish hotplug event.

> Furthermote, OVMF's EFI_SMM_CONTROL2_PROTOCOL.Trigger() implementation
> (in "OvmfPkg/SmmControl2Dxe/SmmControl2Dxe.c") writes 0 to both ports,
> as long as the caller does not specify them.
> 
>   IoWrite8 (ICH9_APM_STS, DataPort    == NULL ? 0 : *DataPort);
>   IoWrite8 (ICH9_APM_CNT, CommandPort == NULL ? 0 : *CommandPort);
> 
> And, there is only one Trigger() call site in edk2: namely in
> "MdeModulePkg/Core/PiSmmCore/PiSmmIpl.c", in the
> SmmCommunicationCommunicate() function.
> 
> (That function implements EFI_SMM_COMMUNICATION_PROTOCOL.Communicate().)
> This call site passes NULL for both DataPort and CommandPort.
> 
> Yet further, EFI_SMM_COMMUNICATION_PROTOCOL.Communicate() is used for
> example by the UEFI variable driver, for talking between the
> unprivileged (runtime DXE) and privileged (SMM) half.
> 
> As a result, all of the software SMIs currently in use in OVMF, related
> to actual firmware services, write 0 to both ports.
> 
> I guess we can choose new values, as long as we avoid 2 and 3 for the
> control port (0xB2), because those are reserved in QEMU -- see
> ich9_apm_ctrl_changed() in "hw/isa/lpc_ich9.c".
> 
> 
> (2) How the parameters are passed.
> 
> 
> (2a) For the new CPU, the SMI remains pending, until it gets an
> INIT-SIPI-SIPI from one of the previously plugged CPUs (most likely, the
> BSP). At that point, the new CPU will execute the "initial SMI handler
> for hotplugged CPUs", at the default SMBASE.
> 
> That's a routine we'll have to write in assembly, from zero. In this
> routine, we can read back IO ports 0xB2 and 0xB3. And QEMU will be happy
> to provide the values last written (see apm_ioport_readb() in
> "hw/isa/apm.c"). So we can receive the values in this routine. Alright.

Potentially we can can avoid writing custom SMI handler,
what do you think about following workflow:

on system boot after initial CPUs relocation, firmware set NOP SMI handler
at default SMBASE.
Then as reaction to GPE triggered SMI (on cpu hotplug), after SMI rendezvous,
a host cpu reads IO port 0xB2 and does hotplugged CPUs enumeration.

  a) assuming we allow hotplug only in case of negotiated SMI broadcast
     host CPU shoots down all in-flight INIT/SIPI/SIPI for hotpugged CPUs
     to avoid race within relocation handler.

 After that host CPU in loop

  b) it prepares/initializes necessary CPU structures for a hotplugged
     CPU if necessary and replaces NOP SMI handler with the relocation
     SMI handler that is used during system boot.
     
  c) a host CPU sends NOP INIT/SIPI/SIPI to the hotplugged CPU

  d) the woken up hotplugged CPU, jumps to default SMBASE and
     executes hotplug relocation handler.

  e) after the hotplugged CPU  is relocated and if there are more
     hotplugged CPUs, a host CPU repeats b-d steps for the next
     hotplugged CPU.

  f) after all CPUs are relocated, restore NOP SMI handler at default
     SMBASE.

> (2b) On all other CPUs, the SMM foundation already accepts the SMI.
> 
> There point where it makes sense to start looking is SmmEntryPoint()
> [MdeModulePkg/Core/PiSmmCore/PiSmmCore.c].
> 
> (2b1) This function first checks whether the SMI is synchronous. The
> logic for determining that is based on
> "gSmmCorePrivate->CommunicationBuffer" being non-NULL. This field is set
> to non-NULL in SmmCommunicationCommunicate() -- see above, in (1).
> 
> In other words, the SMI is deemed synchronous if it was initiated with
> EFI_SMM_COMMUNICATION_PROTOCOL.Communicate(). In that case, the
> HandlerType GUID is extracted from the communication buffer, and passed
> to SmiManage(). In turn, SmiManage() locates the SMI handler registered
> with the same handler GUID, and delegates the SMI handling to that
> specific handler.
> 
> This is how the UEFI variable driver is split in two halves:
> 
> - in "MdeModulePkg/Universal/Variable/RuntimeDxe/VariableSmm.c", we have
> a call to gMmst->MmiHandlerRegister(), with HandlerType =
> "gEfiSmmVariableProtocolGuid"
> 
> - in
> "MdeModulePkg/Universal/Variable/RuntimeDxe/VariableSmmRuntimeDxe.c", we
> format communication buffers with the header GUID set to the same
> "gEfiSmmVariableProtocolGuid".
> 
> Of course, this is what does *not* apply to our use case, as the SMI is
> raised by the OS (via an ACPI method), and *not* by a firmware agent
> that calls EFI_SMM_COMMUNICATION_PROTOCOL.Communicate().
> 
> Therefore, we need to look further in SmmEntryPoint()
> [MdeModulePkg/Core/PiSmmCore/PiSmmCore.c].
> 
> (2b2) What's left there is only the following:
> 
>   //
>   // Process Asynchronous SMI sources
>   //
>   SmiManage (NULL, NULL, NULL, NULL);
> 
> 
> So...
> 
> - Are we supposed to write a new DXE_SMM_DRIVER for OvmfPkg, and call
> gMmst->MmiHandlerRegister() in it, with HandlerType=NULL? (I.e.,
> register a "root SMI handler"?)
> 
> - And then in the handler, should we read IO ports 0xB2 / 0xB3?
> 
> - Also, is that handler where we'd somehow sync up with the hot-plugged
> VCPU, and finally call EFI_SMM_CPU_SERVICE_PROTOCOL.SmmAddProcessor()?
> 
> - Does it matter what (pre-existent) CPU executes the handler? (IOW,
> does it matter what the value of gMmst->CurrentlyExecutingCpu is?)
> 
> Thanks,
> Laszlo
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> 
> View/Reply Online (#48353): https://edk2.groups.io/g/devel/message/48353
> Mute This Topic: https://groups.io/mt/34201782/1958639
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub  [imammedo@redhat.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


