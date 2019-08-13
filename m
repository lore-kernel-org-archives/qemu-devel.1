Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9BDC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2129920840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2129920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZMp-0002KN-FW
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hxZMG-00013v-Ny
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hxZME-0007En-Vr
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hxZME-0007E3-Nm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03D663064FCF;
 Tue, 13 Aug 2019 16:09:10 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-193.ams2.redhat.com
 [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5338E80483;
 Tue, 13 Aug 2019 16:09:07 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: edk2-devel-groups-io <devel@edk2.groups.io>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
Message-ID: <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
Date: Tue, 13 Aug 2019 18:09:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 13 Aug 2019 16:09:10 +0000 (UTC)
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

On 08/13/19 16:16, Laszlo Ersek wrote:

> Yingwen and Jiewen suggested the following process.
>
> Legend:
>
> - "New CPU":  CPU being hot-added
> - "Host CPU": existing CPU
> - (Flash):    code running from flash
> - (SMM):      code running from SMRAM
>
> Steps:
>
> (01) New CPU: (Flash) enter reset vector, Global SMI disabled by
>      default.

- What does "Global SMI disabled by default" mean? In particular, what
  is "global" here?

  Do you mean that the CPU being hot-plugged should mask (by default)
  broadcast SMIs? What about directed SMIs? (An attacker could try that
  too.)

  And what about other processors? (I'd assume step (01)) is not
  relevant for other processors, but "global" is quite confusing here.)

- Does this part require a new branch somewhere in the OVMF SEC code?
  How do we determine whether the CPU executing SEC is BSP or
  hot-plugged AP?

- How do we tell the hot-plugged AP where to start execution? (I.e. that
  it should execute code at a particular pflash location.)

  For example, in MpInitLib, we start a specific AP with INIT-SIPI-SIPI,
  where "SIPI" stores the startup address in the "Interrupt Command
  Register" (which is memory-mapped in xAPIC mode, and an MSR in x2APIC
  mode, apparently). That doesn't apply here -- should QEMU auto-start
  the new CPU?

- What memory is used as stack by the new CPU, when it runs code from
  flash?

  QEMU does not emulate CAR (Cache As RAM). The new CPU doesn't have
  access to SMRAM. And we cannot use AcpiNVS or Reserved memory, because
  a malicious OS could use other CPUs -- or PCI device DMA -- to attack
  the stack (unless QEMU forcibly paused other CPUs upon hotplug; I'm
  not sure).

- If an attempt is made to hotplug multiple CPUs in quick succession,
  does something serialize those attempts?

  Again, stack usage could be a concern, even with Cache-As-RAM --
  HyperThreads (logical processors) on a single core don't have
  dedicated cache.

  Does CPU hotplug apply only at the socket level? If the CPU is
  multi-core, what is responsible for hot-plugging all cores present in
  the socket?


> (02) New CPU: (Flash) configure memory control to let it access global
>      host memory.

In QEMU/KVM guests, we don't have to enable memory explicitly, it just
exists and works.

In OVMF X64 SEC, we can't access RAM above 4GB, but that shouldn't be an
issue per se.


> (03) New CPU: (Flash) send board message to tell host CPU (GPIO->SCI)
>      -- I am waiting for hot-add message.

Maybe we can simplify this in QEMU by broadcasting an SMI to existent
processors immediately upon plugging the new CPU.


>                                        (NOTE: Host CPU can only send
>      instruction in SMM mode. -- The register is SMM only)

Sorry, I don't follow -- what register are we talking about here, and
why is the BSP needed to send anything at all? What "instruction" do you
have in mind?


> (04) Host CPU: (OS) get message from board that a new CPU is added.
>      (GPIO -> SCI)
>
> (05) Host CPU: (OS) All CPUs enter SMM (SCI->SWSMI) (NOTE: New CPU
>      will not enter CPU because SMI is disabled)

I don't understand the OS involvement here. But, again, perhaps QEMU can
force all existent CPUs into SMM immediately upon adding the new CPU.


> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
>      rebase code.
>
> (07) Host CPU: (SMM) Send message to New CPU to Enable SMI.

Aha, so this is the SMM-only register you mention in step (03). Is the
register specified in the Intel SDM?


> (08) New CPU: (Flash) Get message - Enable SMI.
>
> (09) Host CPU: (SMM) Send SMI to the new CPU only.
>
> (10) New CPU: (SMM) Response first SMI at 38000, and rebase SMBASE to
>      TSEG.

What code does the new CPU execute after it completes step (10)? Does it
halt?


> (11) Host CPU: (SMM) Restore 38000.

These steps (i.e., (06) through (11)) don't appear RAS-specific. The
only platform-specific feature seems to be SMI masking register, which
could be extracted into a new SmmCpuFeaturesLib API.

Thus, would you please consider open sourcing firmware code for steps
(06) through (11)?


Alternatively -- and in particular because the stack for step (01)
concerns me --, we could approach this from a high-level, functional
perspective. The states that really matter are the relocated SMBASE for
the new CPU, and the state of the full system, right at the end of step
(11).

When the SMM setup quiesces during normal firmware boot, OVMF could use
existent (finalized) SMBASE infomation to *pre-program* some virtual
QEMU hardware, with such state that would be expected, as "final" state,
of any new hotplugged CPU. Afterwards, if / when the hotplug actually
happens, QEMU could blanket-apply this state to the new CPU, and
broadcast a hardware SMI to all CPUs except the new one.

The hardware SMI should tell the firmware that the rest of the process
-- step (12) below, and onward -- is being requested.

If I understand right, this approach would produce an firmware & system
state that's identical to what's expected right after step (11):

- all SMBASEs relocated
- all preexistent CPUs in SMM
- new CPU halted / blocked from launch
- DRAM at 0x30000 / 0x38000 contains OS-owned data

Is my understanding correct that this is the expected state after step
(11)?

Three more comments on the "SMBASE pre-config" approach:

- the virtual hardware providing this feature should become locked after
  the configuration, until next platform reset

- the pre-config should occur via simple hardware accesses, so that it
  can be replayed at S3 resume, i.e. as part of the S3 boot script

- from the pre-configured state, and the APIC ID, QEMU itself could
  perhaps calculate the SMI stack location for the new processor.


> (12) Host CPU: (SMM) Update located data structure to add the new CPU
>      information. (This step will involve CPU_SERVICE protocol)

I commented on EFI_SMM_CPU_SERVICE_PROTOCOL in upon bullet (4) of
<https://bugzilla.tianocore.org/show_bug.cgi?id=1512#c4>.

Calling EFI_SMM_ADD_PROCESSOR looks justified.

What are some of the other member functions used for? The scary one is
EFI_SMM_REGISTER_EXCEPTION_HANDLER.


> ===================== (now, the next SMI will bring all CPU into TSEG)

OK... but what component injects that SMI, and when?


> (13) New CPU: (Flash) run MRC code, to init its own memory.

Why is this needed esp. after step (10)? The new CPU has accessed DRAM
already. And why are we executing code from pflash, rather than from
SMRAM, given that we're past SMBASE relocation?


> (14) New CPU: (Flash) Deadloop, and wait for INIT-SIPI-SIPI.
>
> (15) Host CPU: (OS) Send INIT-SIPI-SIPI to pull new CPU in.

I'm confused by these steps. I thought that step (12) would complete the
hotplug, by updating the administrative data structures internally. And
the next SMI -- raised for the usual purposes, such as a software SMI
for variable access -- would be handled like it always is, except it
would also pull the new CPU into SMM too.

Thanks!
Laszlo

