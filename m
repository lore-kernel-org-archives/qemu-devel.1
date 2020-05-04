Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33747C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B9020746
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B9020746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWz0-00019n-3v
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jVWyB-0000ir-KY
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:01:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:57630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jVWy9-0002X6-BQ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:00:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jVWy7-0006nF-MB
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 09:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A121E2E80E7
 for <qemu-devel@nongnu.org>; Mon,  4 May 2020 09:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2020 08:48:14 -0000
From: John Hartley <1876678@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: graphdrum
X-Launchpad-Bug-Reporter: John Hartley (graphdrum)
X-Launchpad-Bug-Modifier: John Hartley (graphdrum)
Message-Id: <158858209471.12655.6550590823696382929.malonedeb@gac.canonical.com>
Subject: [Bug 1876678] [NEW] Ubuntu 20.04 QEMU Failure with nested FreeBSD
 bhyve 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9c73110f5d7f5784cea0e53de3329454f7cfa609
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 03:31:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1876678 <1876678@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

BUG:

Starting FreeBSD Layer 2 bhyve Guest within Layer 1 FreeBSD VM Host on
Layer 0 Ubuntu 20.04 KVM / QEMU Host result in Layer 1 Guest / Host
Pausing with "Emulation Failure"

TESTING:

My test scenario is nested virtualisation:
Layer 0 - Ubuntu 20.04 Host
Layer 1 - FreeBSD 12.1 with OVMF + bhyve hypervisor Guest/Host
Layer 2 - FreeBSD 12.1 guest

Layer 0 Host is: Ubuntu 20.04 LTS KVM / QEMU / libvirt

<<START QEMU VERSION>>
$ virsh -c qemu:///system version --daemon
Compiled against library: libvirt 6.0.0
Using library: libvirt 6.0.0
Using API: QEMU 6.0.0
Running hypervisor: QEMU 4.2.0
Running against daemon: 6.0.0
<<END QEMU VERSION>

<<START Intel VMX Support & Nesting Enabled>>
$ cat /proc/cpuinfo | grep -c vmx
64
$ cat /sys/module/kvm_intel/parameters/nested
Y
<<END Intel VMS>>


Layer 1 Guest / Host is: FreeBSD Q35 v4.2 with OVMF:

Pass Host VMX support to Layer 1 Guest via <cpu mode=3D'host-model>

<<LIBVIRT CONFIG SNIPPET>>
...
...
  <os>
    <type arch=3D'x86_64' machine=3D'pc-q35-4.2'>hvm</type>
    <loader readonly=3D'yes' type=3D'pflash'>/usr/share/OVMF/OVMF_CODE.fd</=
loader>
    <nvram>/home/USER/swarm.bhyve.freebsd/OVMF_VARS.fd</nvram>
  </os>
  <features>
    <acpi/>
    <apic/>
    <vmport state=3D'off'/>
  </features>
  <cpu mode=3D'host-model' check=3D'partial'/>
...
...
<END LIBVIRT CONFIG SNIPPET>>

Checked that Layer 1 - FreeBSD Quest / Host has VMX feature available:

<<LAYER 1 - FreeBSD CPU Features>>
# uname -a
FreeBSD swarm.DOMAIN.HERE 12.1-RELEASE FreeBSD 12.1-RELEASE GENERIC  amd64

# grep Features /var/run/dmesg.boot =

  Features=3D0xf83fbff<FPU,VME,DE,PSE,TSC,MSR,PAE,MCE,CX8,APIC,SEP,MTRR,PGE=
,MCA,CMOV,PAT,PSE36,MMX,FXSR,SSE,SSE2,SS>
  Features2=3D0xfffa3223<SSE3,PCLMULQDQ,VMX,SSSE3,FMA,CX16,PCID,SSE4.1,SSE4=
.2,x2APIC,MOVBE,POPCNT,TSCDLT,AESNI,XSAVE,OSXSAVE,AVX,F16C,RDRAND,HV>
  AMD Features=3D0x2c100800<SYSCALL,NX,Page1GB,RDTSCP,LM>
  AMD Features2=3D0x121<LAHF,ABM,Prefetch>
  Structured Extended Features=3D0x1c0fbb<FSGSBASE,TSCADJ,BMI1,HLE,AVX2,SME=
P,BMI2,ERMS,INVPCID,RTM,RDSEED,ADX,SMAP>
  Structured Extended Features2=3D0x4<UMIP>
  Structured Extended Features3=3D0xac000400<MD_CLEAR,IBPB,STIBP,ARCH_CAP,S=
SBD>
  XSAVE Features=3D0x1<XSAVEOPT>
<<END LAYER 1 - FreeBSD CPU Features>

On Layer 1 FreeBSD Guest / Host start up the Layer 2 guest..

<<START LAYER 2 GUEST START>>
# ls
FreeBSD-11.2-RELEASE-amd64-bootonly.iso	FreeBSD-12.1-RELEASE-amd64-dvd1.iso=
	bee-hd1-01.img
# /usr/sbin/bhyve -c 2 -m 2048 -H -A -s 0:0,hostbridge -s 1:0,lpc -s 2:0,e1=
000,tap0 -s 3:0,ahci-hd,bee-hd1-01.img -l com1,stdio -s 5:0,ahci-cd,./FreeB=
SD-12.1-RELEASE-amd64-dvd1.iso bee
<<END LAYER 2 GUEST START>>

Result is that Layer 1 - FreeBSD Host guest "paused".

To Layer 1 machines freezes I cannot get any further diagnostics from
this machine, so I run tail on libvirt log from Layer 0 - Ubuntu Host

<<LAYER 0 LOG TAIL>>
char device redirected to /dev/pts/29 (label charserial0)
2020-05-04T06:09:15.310474Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
2020-05-04T06:09:15.310531Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
2020-05-04T06:09:15.312533Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
2020-05-04T06:09:15.312548Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
2020-05-04T06:09:15.313828Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
2020-05-04T06:09:15.313841Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
2020-05-04T06:09:15.315185Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
2020-05-04T06:09:15.315201Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
KVM internal error. Suberror: 1
emulation failure
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00000000
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D00000000 EFL=3D00000000 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
CS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
SS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
DS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
FS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
GS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
LDT=3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
TR =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
GDT=3D     0000000000000000 00000000
IDT=3D     0000000000000000 00000000
CR0=3D80050033 CR2=3D0000000000000000 CR3=3D0000000000000000 CR4=3D00372060
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000 =

DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000d01
Code=3D<??> ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? =
?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? =
?? ?? ??
2020-05-04T06:35:39.186799Z qemu-system-x86_64: terminating on signal 15 fr=
om pid 2155 (/usr/sbin/libvirtd)
2020-05-04 06:35:39.386+0000: shutting down, reason=3Ddestroyed
<<END LAYER 0 LOG TAIL>>


I am reporting this bug here as result is very similar to that seen with QE=
MU seabios failure reported here: https://bugs.launchpad.net/qemu/+bug/1866=
870

However in this case my VM Layer 1 VM is using OVMF.

NOTE 1: I have also tested with Q35 v3.1 and 2.12 and get the same result.
NOTE 2: Due to bug in FreeBSD networking code, I had to compile custom kern=
el with "netmap driver disabled".  This is known bug in FreeBSD that I have=
 reported separately.
NOTE 3: I will cross posted this bug report on FreeBSD bugzilla as well: ht=
tps://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D246168
NOTE 4: Have done extensive testing of Ubuntu 20.04 Nested virtualisation w=
ith just Ubuntu hosts  and OVMF and the nested virtualisation runs correctl=
y, so problem is specific to using FreeBSD / bhyve guest / host.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1876678

Title:
  Ubuntu 20.04 QEMU Failure with nested FreeBSD bhyve

Status in QEMU:
  New

Bug description:
  BUG:

  Starting FreeBSD Layer 2 bhyve Guest within Layer 1 FreeBSD VM Host on
  Layer 0 Ubuntu 20.04 KVM / QEMU Host result in Layer 1 Guest / Host
  Pausing with "Emulation Failure"

  TESTING:

  My test scenario is nested virtualisation:
  Layer 0 - Ubuntu 20.04 Host
  Layer 1 - FreeBSD 12.1 with OVMF + bhyve hypervisor Guest/Host
  Layer 2 - FreeBSD 12.1 guest

  Layer 0 Host is: Ubuntu 20.04 LTS KVM / QEMU / libvirt

  <<START QEMU VERSION>>
  $ virsh -c qemu:///system version --daemon
  Compiled against library: libvirt 6.0.0
  Using library: libvirt 6.0.0
  Using API: QEMU 6.0.0
  Running hypervisor: QEMU 4.2.0
  Running against daemon: 6.0.0
  <<END QEMU VERSION>

  <<START Intel VMX Support & Nesting Enabled>>
  $ cat /proc/cpuinfo | grep -c vmx
  64
  $ cat /sys/module/kvm_intel/parameters/nested
  Y
  <<END Intel VMS>>


  Layer 1 Guest / Host is: FreeBSD Q35 v4.2 with OVMF:

  Pass Host VMX support to Layer 1 Guest via <cpu mode=3D'host-model>

  <<LIBVIRT CONFIG SNIPPET>>
  ...
  ...
    <os>
      <type arch=3D'x86_64' machine=3D'pc-q35-4.2'>hvm</type>
      <loader readonly=3D'yes' type=3D'pflash'>/usr/share/OVMF/OVMF_CODE.fd=
</loader>
      <nvram>/home/USER/swarm.bhyve.freebsd/OVMF_VARS.fd</nvram>
    </os>
    <features>
      <acpi/>
      <apic/>
      <vmport state=3D'off'/>
    </features>
    <cpu mode=3D'host-model' check=3D'partial'/>
  ...
  ...
  <END LIBVIRT CONFIG SNIPPET>>

  Checked that Layer 1 - FreeBSD Quest / Host has VMX feature available:

  <<LAYER 1 - FreeBSD CPU Features>>
  # uname -a
  FreeBSD swarm.DOMAIN.HERE 12.1-RELEASE FreeBSD 12.1-RELEASE GENERIC  amd64

  # grep Features /var/run/dmesg.boot =

    Features=3D0xf83fbff<FPU,VME,DE,PSE,TSC,MSR,PAE,MCE,CX8,APIC,SEP,MTRR,P=
GE,MCA,CMOV,PAT,PSE36,MMX,FXSR,SSE,SSE2,SS>
    Features2=3D0xfffa3223<SSE3,PCLMULQDQ,VMX,SSSE3,FMA,CX16,PCID,SSE4.1,SS=
E4.2,x2APIC,MOVBE,POPCNT,TSCDLT,AESNI,XSAVE,OSXSAVE,AVX,F16C,RDRAND,HV>
    AMD Features=3D0x2c100800<SYSCALL,NX,Page1GB,RDTSCP,LM>
    AMD Features2=3D0x121<LAHF,ABM,Prefetch>
    Structured Extended Features=3D0x1c0fbb<FSGSBASE,TSCADJ,BMI1,HLE,AVX2,S=
MEP,BMI2,ERMS,INVPCID,RTM,RDSEED,ADX,SMAP>
    Structured Extended Features2=3D0x4<UMIP>
    Structured Extended Features3=3D0xac000400<MD_CLEAR,IBPB,STIBP,ARCH_CAP=
,SSBD>
    XSAVE Features=3D0x1<XSAVEOPT>
  <<END LAYER 1 - FreeBSD CPU Features>

  On Layer 1 FreeBSD Guest / Host start up the Layer 2 guest..

  <<START LAYER 2 GUEST START>>
  # ls
  FreeBSD-11.2-RELEASE-amd64-bootonly.iso	FreeBSD-12.1-RELEASE-amd64-dvd1.i=
so	bee-hd1-01.img
  # /usr/sbin/bhyve -c 2 -m 2048 -H -A -s 0:0,hostbridge -s 1:0,lpc -s 2:0,=
e1000,tap0 -s 3:0,ahci-hd,bee-hd1-01.img -l com1,stdio -s 5:0,ahci-cd,./Fre=
eBSD-12.1-RELEASE-amd64-dvd1.iso bee
  <<END LAYER 2 GUEST START>>

  Result is that Layer 1 - FreeBSD Host guest "paused".

  To Layer 1 machines freezes I cannot get any further diagnostics from
  this machine, so I run tail on libvirt log from Layer 0 - Ubuntu Host

  <<LAYER 0 LOG TAIL>>
  char device redirected to /dev/pts/29 (label charserial0)
  2020-05-04T06:09:15.310474Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
  2020-05-04T06:09:15.310531Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
  2020-05-04T06:09:15.312533Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
  2020-05-04T06:09:15.312548Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
  2020-05-04T06:09:15.313828Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
  2020-05-04T06:09:15.313841Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
  2020-05-04T06:09:15.315185Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
  2020-05-04T06:09:15.315201Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
  KVM internal error. Suberror: 1
  emulation failure
  EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00000000
  ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
  EIP=3D00000000 EFL=3D00000000 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
  CS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
  SS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
  DS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
  FS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
  GS =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
  LDT=3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
  TR =3D0000 00000000 00000000 00008000 DPL=3D0 <hiword>
  GDT=3D     0000000000000000 00000000
  IDT=3D     0000000000000000 00000000
  CR0=3D80050033 CR2=3D0000000000000000 CR3=3D0000000000000000 CR4=3D003720=
60
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000d01
  Code=3D<??> ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?=
? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?=
? ?? ?? ??
  2020-05-04T06:35:39.186799Z qemu-system-x86_64: terminating on signal 15 =
from pid 2155 (/usr/sbin/libvirtd)
  2020-05-04 06:35:39.386+0000: shutting down, reason=3Ddestroyed
  <<END LAYER 0 LOG TAIL>>

  =

  I am reporting this bug here as result is very similar to that seen with =
QEMU seabios failure reported here: https://bugs.launchpad.net/qemu/+bug/18=
66870

  However in this case my VM Layer 1 VM is using OVMF.

  NOTE 1: I have also tested with Q35 v3.1 and 2.12 and get the same result.
  NOTE 2: Due to bug in FreeBSD networking code, I had to compile custom ke=
rnel with "netmap driver disabled".  This is known bug in FreeBSD that I ha=
ve reported separately.
  NOTE 3: I will cross posted this bug report on FreeBSD bugzilla as well: =
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D246168
  NOTE 4: Have done extensive testing of Ubuntu 20.04 Nested virtualisation=
 with just Ubuntu hosts  and OVMF and the nested virtualisation runs correc=
tly, so problem is specific to using FreeBSD / bhyve guest / host.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1876678/+subscriptions

