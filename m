Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE16C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DC220679
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIL5Xe+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DC220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUGv-0002sv-L1
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iXU7O-0003nH-SW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iXU7I-0001fl-NQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:50:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iXU7I-0001eC-75
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574272211;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=padFQJWMU0/PtWurwsOOAYRD346o/+U1FWZ8aKZJh9Q=;
 b=DIL5Xe+Z+9v95D7xvKzR6kYjPcZpiaQbdqpSM5hvbazR4UwuwgZ2BRUJ2dMr28L6vXXmI9
 RJDz8fV6vRuD66Kdy4bPTT5W9bumgIWWLN7ryU7DNaTga9XpL8W0WECe2JqOJd/3vX7nuX
 unJ5YobT1ohm19lGOUeBUUrvorei8rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-2zVPpPsKMsyceOW5aUqmlw-1; Wed, 20 Nov 2019 12:50:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 008B8800054
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 17:50:08 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98517104B527;
 Wed, 20 Nov 2019 17:50:05 +0000 (UTC)
Date: Wed, 20 Nov 2019 17:50:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: add VMX features to named CPU models
Message-ID: <20191120175002.GP2785116@redhat.com>
References: <20191120173753.8894-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120173753.8894-1-pbonzini@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2zVPpPsKMsyceOW5aUqmlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 06:37:53PM +0100, Paolo Bonzini wrote:
> This allows using "-cpu Haswell,+vmx", which we did not really want to
> support in QEMU but was produced by Libvirt when using the "host-model"
> CPU model.

Can you say what is currently broken ?  If I launch my current QEMU (I have
4.1.1 on Fedora 31):

 qemu-system-x86_64 -cpu Haswell,+vmx

... I don't get any reported errors.

>=20
> This was produced from the output of scripts/kvm/vmxcap using the followi=
ng
> very ugly Python script:
>=20
>     bits =3D {
>             'INS/OUTS instruction information': ['FEAT_VMX_BASIC', 'MSR_V=
MX_BASIC_INS_OUTS'],
>             'IA32_VMX_TRUE_*_CTLS support': ['FEAT_VMX_BASIC', 'MSR_VMX_B=
ASIC_TRUE_CTLS'],
>             'External interrupt exiting': ['FEAT_VMX_PINBASED_CTLS', 'VMX=
_PIN_BASED_EXT_INTR_MASK'],
>             'NMI exiting': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_NMI_=
EXITING'],
>             'Virtual NMIs': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_VIR=
TUAL_NMIS'],
>             'Activate VMX-preemption timer': ['FEAT_VMX_PINBASED_CTLS', '=
VMX_PIN_BASED_VMX_PREEMPTION_TIMER'],
>             'Process posted interrupts': ['FEAT_VMX_PINBASED_CTLS', 'VMX_=
PIN_BASED_POSTED_INTR'],
>             'Interrupt window exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_=
CPU_BASED_VIRTUAL_INTR_PENDING'],
>             'Use TSC offsetting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BA=
SED_USE_TSC_OFFSETING'],
>             'HLT exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_HLT=
_EXITING'],
>             'INVLPG exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_=
INVLPG_EXITING'],
>             'MWAIT exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_M=
WAIT_EXITING'],
>             'RDPMC exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_R=
DPMC_EXITING'],
>             'RDTSC exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_R=
DTSC_EXITING'],
>             'CR3-load exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASE=
D_CR3_LOAD_EXITING'],
>             'CR3-store exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BAS=
ED_CR3_STORE_EXITING'],
>             'CR8-load exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASE=
D_CR8_LOAD_EXITING'],
>             'CR8-store exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BAS=
ED_CR8_STORE_EXITING'],
>             'Use TPR shadow': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_=
TPR_SHADOW'],
>             'NMI-window exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BA=
SED_VIRTUAL_NMI_PENDING'],
>             'MOV-DR exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_=
MOV_DR_EXITING'],
>             'Unconditional I/O exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX=
_CPU_BASED_UNCOND_IO_EXITING'],
>             'Use I/O bitmaps': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED=
_USE_IO_BITMAPS'],
>             'Monitor trap flag': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BAS=
ED_MONITOR_TRAP_FLAG'],
>             'Use MSR bitmaps': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED=
_USE_MSR_BITMAPS'],
>             'MONITOR exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED=
_MONITOR_EXITING'],
>             'PAUSE exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_P=
AUSE_EXITING'],
>             'Activate secondary control': ['FEAT_VMX_PROCBASED_CTLS', 'VM=
X_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS'],
>             'Virtualize APIC accesses': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_=
SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES'],
>             'Enable EPT': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC=
_ENABLE_EPT'],
>             'Descriptor-table exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_=
SECONDARY_EXEC_DESC'],
>             'Enable RDTSCP': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_E=
XEC_RDTSCP'],
>             'Virtualize x2APIC mode': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SE=
CONDARY_EXEC_VIRTUALIZE_X2APIC_MODE'],
>             'Enable VPID': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXE=
C_ENABLE_VPID'],
>             'WBINVD exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_=
EXEC_WBINVD_EXITING'],
>             'Unrestricted guest': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECOND=
ARY_EXEC_UNRESTRICTED_GUEST'],
>             'APIC register emulation': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_S=
ECONDARY_EXEC_APIC_REGISTER_VIRT'],
>             'Virtual interrupt delivery': ['FEAT_VMX_SECONDARY_CTLS', 'VM=
X_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY'],
>             'PAUSE-loop exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECOND=
ARY_EXEC_PAUSE_LOOP_EXITING'],
>             'RDRAND exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_=
EXEC_RDRAND_EXITING'],
>             'Enable INVPCID': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_=
EXEC_ENABLE_INVPCID'],
>             'Enable VM functions': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECON=
DARY_EXEC_ENABLE_VMFUNC'],
>             'VMCS shadowing': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_=
EXEC_SHADOW_VMCS'],
>             'RDSEED exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_=
EXEC_RDSEED_EXITING'],
>             'Enable PML': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC=
_ENABLE_PML'],
>             'Enable XSAVES/XRSTORS': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SEC=
ONDARY_EXEC_XSAVES'],
>             'Save debug controls': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SA=
VE_DEBUG_CONTROLS'],
>             'Host address-space size': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXI=
T_HOST_ADDR_SPACE_SIZE'],
>             'Load IA32_PERF_GLOBAL_CTRL': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_=
EXIT_LOAD_IA32_PERF_GLOBAL_CTRL'],
>             'Acknowledge interrupt on exit': ['FEAT_VMX_EXIT_CTLS', 'VMX_=
VM_EXIT_ACK_INTR_ON_EXIT'],
>             'Save IA32_PAT': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_IA3=
2_PAT'],
>             'Load IA32_PAT': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_LOAD_IA3=
2_PAT'],
>             'Save IA32_EFER': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_IA=
32_EFER'],
>             'Load IA32_EFER': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_LOAD_IA=
32_EFER'],
>             'Save VMX-preemption timer value': ['FEAT_VMX_EXIT_CTLS', 'VM=
X_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER'],
>             'Clear IA32_BNDCFGS': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_CLE=
AR_BNDCFGS'],
>             'Load debug controls': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_=
LOAD_DEBUG_CONTROLS'],
>             'IA-32e mode guest': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_IA=
32E_MODE'],
>             'Load IA32_PERF_GLOBAL_CTRL': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM=
_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL'],
>             'Load IA32_PAT': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_I=
A32_PAT'],
>             'Load IA32_EFER': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_=
IA32_EFER'],
>             'Load IA32_BNDCFGS': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LO=
AD_BNDCFGS'],
>             'Store EFER.LMA into IA-32e mode guest control': ['FEAT_VMX_M=
ISC', 'MSR_VMX_MISC_STORE_LMA'],
>             'HLT activity state': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_ACTIVIT=
Y_HLT'],
>             'VMWRITE to VM-exit information fields': ['FEAT_VMX_MISC', 'M=
SR_VMX_MISC_VMWRITE_VMEXIT'],
>             'Inject event with insn length=3D0': ['FEAT_VMX_MISC', 'MSR_V=
MX_MISC_ZERO_LEN_INJECT'],
>             'Execute-only EPT translations': ['FEAT_VMX_EPT_VPID_CAPS', '=
MSR_VMX_EPT_EXECONLY'],
>             'Page-walk length 4': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT=
_PAGE_WALK_LENGTH_4'],
>             'Paging-structure memory type WB': ['FEAT_VMX_EPT_VPID_CAPS',=
 'MSR_VMX_EPT_WB'],
>             '2MB EPT pages': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_2MB =
| MSR_VMX_EPT_1GB'],
>             'INVEPT supported': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_I=
NVEPT'],
>             'EPT accessed and dirty flags': ['FEAT_VMX_EPT_VPID_CAPS', 'M=
SR_VMX_EPT_AD_BITS'],
>             'Single-context INVEPT': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_=
EPT_INVEPT_SINGLE_CONTEXT'],
>             'All-context INVEPT': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT=
_INVEPT_ALL_CONTEXT'],
>             'INVVPID supported': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_=
INVVPID'],
>             'Individual-address INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR=
_VMX_EPT_INVVPID_SINGLE_ADDR'],
>             'Single-context INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX=
_EPT_INVVPID_SINGLE_CONTEXT'],
>             'All-context INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EP=
T_INVVPID_ALL_CONTEXT'],
>             'Single-context-retaining-globals INVVPID': ['FEAT_VMX_EPT_VP=
ID_CAPS', 'MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS'],
>             'EPTP Switching': ['FEAT_VMX_VMFUNC', 'MSR_VMX_VMFUNC_EPT_SWI=
TCHING']
>     }
>=20
>     import sys
>     import textwrap
>=20
>     out =3D {}
>     for l in sys.stdin.readlines():
>         l =3D l.rstrip()
>         if l.endswith('!!'):
>             l =3D l[:-2].rstrip()
>         if l.startswith('    ') and (l.endswith('default') or l.endswith(=
'yes')):
>             l =3D l[4:]
>             for key, value in bits.items():
>                 if l.startswith(key):
>                     ctl, bit =3D value
>                     if ctl in out:
>                         out[ctl] =3D out[ctl] + ' | '
>                     else:
>                         out[ctl] =3D '    [%s] =3D ' % ctl
>                     out[ctl] =3D out[ctl] + bit
>=20
>     for x in sorted(out.keys()):
>         print("\n         ".join(textwrap.wrap(out[x] + ",")))
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 674 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 674 insertions(+)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 8447f4b82c..0f38c82903 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1873,6 +1873,24 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
>          .features[FEAT_8000_0001_ECX] =3D
>              CPUID_EXT3_LAHF_LM,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz",
>      },
> @@ -1900,6 +1918,21 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>                      CPUID_EXT3_OSVW, CPUID_EXT3_IBS, CPUID_EXT3_SVM */
>          .features[FEAT_8000_0001_ECX] =3D
>              0,
> +        /* VMX features from Cedar Mill/Prescott */
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Common KVM processor"
>      },
> @@ -1931,6 +1964,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT_SSE3,
>          .features[FEAT_8000_0001_ECX] =3D
>              0,
> +        /* VMX features from Yonah */
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXIT=
ING |
> +             VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_EXITIN=
G |
> +             VMX_CPU_BASED_PAUSE_EXITING | VMX_CPU_BASED_USE_MSR_BITMAPS=
,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Common 32-bit KVM processor"
>      },
> @@ -1952,6 +1999,19 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT_SSE3 | CPUID_EXT_MONITOR,
>          .features[FEAT_8000_0001_EDX] =3D
>              CPUID_EXT2_NX,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXIT=
ING |
> +             VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_EXITIN=
G |
> +             VMX_CPU_BASED_PAUSE_EXITING | VMX_CPU_BASED_USE_MSR_BITMAPS=
,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Genuine Intel(R) CPU           T2600  @ 2.16GHz",
>      },
> @@ -2062,6 +2122,24 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
>          .features[FEAT_8000_0001_ECX] =3D
>              CPUID_EXT3_LAHF_LM,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Celeron_4x0 (Conroe/Merom Class Core 2)",
>      },
> @@ -2085,6 +2163,27 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
>          .features[FEAT_8000_0001_ECX] =3D
>              CPUID_EXT3_LAHF_LM,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Core 2 Duo P9xxx (Penryn Class Core 2)",
>      },
> @@ -2108,6 +2207,45 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
>          .features[FEAT_8000_0001_ECX] =3D
>              CPUID_EXT3_LAHF_LM,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Core i7 9xx (Nehalem Class Core i7)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2148,6 +2286,47 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT3_LAHF_LM,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Westmere E56xx/L56xx/X56xx (Nehalem-C)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2193,6 +2372,47 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XSAVEOPT,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Xeon E312xx (Sandy Bridge)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2241,6 +2461,50 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XSAVEOPT,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_I=
NTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Xeon E3-12xx v2 (Ivy Bridge)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2292,6 +2556,52 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XSAVEOPT,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_I=
NTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
> +        .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Core Processor (Haswell)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2376,6 +2686,52 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XSAVEOPT,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_I=
NTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
> +        .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Core Processor (Broadwell)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2460,6 +2816,50 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        /* Missing: Mode-based execute control (XS/XU), processor tracin=
g, TSC scaling */
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
> +        .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Core Processor (Skylake)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2524,6 +2924,52 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        /* Missing: Mode-based execute control (XS/XU), processor tracin=
g, TSC scaling */
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_I=
NTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Xeon Processor (Skylake)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2594,6 +3040,52 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        /* Missing: Mode-based execute control (XS/XU), processor tracin=
g, TSC scaling */
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_I=
NTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Xeon Processor (Cascadelake)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> @@ -2663,6 +3155,50 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        /* Missing: Mode-based execute control (XS/XU), processor tracin=
g, TSC scaling */
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
> +        .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Core Processor (Icelake)",
>      },
> @@ -2721,6 +3257,52 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        /* Missing: Mode-based execute control (XS/XU), processor tracin=
g, TSC scaling */
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_I=
NTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Xeon Processor (Icelake)",
>      },
> @@ -2768,6 +3350,52 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_6_EAX_ARAT,
>          .features[FEAT_ARCH_CAPABILITIES] =3D
>              MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_I=
NTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
> +        .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Atom Processor (Denverton)",
>      },
> @@ -2838,6 +3466,52 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_VMX_BASIC] =3D MSR_VMX_BASIC_INS_OUTS |
> +             MSR_VMX_BASIC_TRUE_CTLS,
> +        .features[FEAT_VMX_ENTRY_CTLS] =3D VMX_VM_ENTRY_IA32E_MODE |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD=
_IA32_PAT |
> +             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTR=
OLS |
> +             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
> +        .features[FEAT_VMX_EPT_VPID_CAPS] =3D MSR_VMX_EPT_EXECONLY |
> +             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_E=
PT_2MB |
> +             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
> +             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_=
CONTEXT |
> +             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_AL=
L_CONTEXT |
> +             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_=
AD_BITS,
> +        .features[FEAT_VMX_EXIT_CTLS] =3D VMX_VM_EXIT_HOST_ADDR_SPACE_SI=
ZE |
> +             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTR=
OLS |
> +             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
> +             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
> +        .features[FEAT_VMX_MISC] =3D MSR_VMX_MISC_ACTIVITY_HLT |
> +             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
> +        .features[FEAT_VMX_PINBASED_CTLS] =3D VMX_PIN_BASED_EXT_INTR_MAS=
K |
> +             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
> +             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_I=
NTR,
> +        .features[FEAT_VMX_PROCBASED_CTLS] =3D VMX_CPU_BASED_VIRTUAL_INT=
R_PENDING |
> +             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING=
 |
> +             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING =
|
> +             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
> +             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EX=
ITING |
> +             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
> +             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITM=
APS |
> +             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING=
 |
> +             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_B=
ITMAPS |
> +             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EX=
ITING |
> +             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
> +        .features[FEAT_VMX_SECONDARY_CTLS] =3D
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_EPT |
> +             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
> +             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
> +             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTR=
ICTED_GUEST |
> +             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
> +             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
> +             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
> +             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENAB=
LE_INVPCID |
> +             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADO=
W_VMCS,
> +        .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Atom Processor (SnowRidge)",
>          .versions =3D (X86CPUVersionDefinition[]) {
> --=20
> 2.21.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


